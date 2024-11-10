import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../shared/service/pf_service.dart';
import '../../../product/product_model.dart';
import '../models/pf_model.dart';

part 'pf_action.dart';
part 'pf_state.dart';

class PfBloc extends Bloc<PfEvent, PfState> {
  PfBloc() : super(PfState.initial()) {
    on<UpdateAllowCamera>(_onUpdateAllowCamera);
    on<UpdateDataResultPf>(_onUpdateDataResultPf);
    on<FetchProduct>(_onFetchProduct);
  }

  void _onUpdateAllowCamera(UpdateAllowCamera event, Emitter<PfState> emit) {
    emit(state.copyWith(isAllowCamera: event.value));
  }

  void _onUpdateDataResultPf(UpdateDataResultPf event, Emitter<PfState> emit) {
    emit(state.copyWith(resultPersonalityModel: event.decodedData));
  }

  Future<void> _onFetchProduct(FetchProduct event, Emitter<PfState> emit) async {
    try {
      emit(state.copyWith(loadingProduct: true));
      final personalityValue = _getPersonalityValue(state);

      if (personalityValue == "N/A") {
        throw Exception("No matching personality value found");
      }

      final productData = await PfService().fetchProductData(personalityValue);
      print(productData);

      emit(state.copyWith(
        productData: productData,
        loadingProduct: false,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), loadingProduct: false));
    }
  }

  String _getPersonalityValue(PfState pfState) {
    final personalityLabel = pfState.resultPersonalityModel!.firstWhere(
          (model) => model.name == "Personality Finder",
      orElse: () => ResultPersonalityModel(name: "Personality Finder", outputLabel: ""),
    ).outputLabel;

    if (personalityLabel == null || personalityLabel.isEmpty) {
      return "N/A";
    }

    const personalities = [
      {"label": "Open", "value": "6693"},
      {"label": "Neurotic", "value": "6694"},
      {"label": "Agreeable", "value": "6695"},
      {"label": "Extroverted", "value": "6696"},
      {"label": "Conscientious", "value": "6697"},
    ];

    final personality = personalities.firstWhere(
          (item) => item["label"] == personalityLabel,
      orElse: () => {"value": "N/A"},
    );

    return personality["value"] ?? "N/A";
  }
}
