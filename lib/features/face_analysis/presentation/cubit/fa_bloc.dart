import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unveels/features/face_analysis/presentation/models/fa_model.dart';

import '../../../../shared/service/fa_service.dart';
import '../../../product/product_model.dart';
import '../../../product/product_model_lipstick.dart';
import '../../../product/product_model_look.dart';
import '../../../product/product_model_perfume.dart';

part 'fa_actions.dart';
part 'fa_state.dart';

class FaBloc extends Bloc<FaEvent, FaState> {
  FaBloc() : super(FaState.initial()) {
    on<UpdateAllowCamera>(_onUpdateAllowCamera);
    on<UpdateDataResultFa>(_onUpdateDataResultFa);
    on<FetchProduct>(_onFetchProduct);
  }

  void _onUpdateAllowCamera(UpdateAllowCamera event, Emitter<FaState> emit) {
    emit(state.copyWith(isAllowCamera: event.value));
  }

  void _onUpdateDataResultFa(UpdateDataResultFa event, Emitter<FaState> emit) {
    emit(state.copyWith(resultFaceAnalyzeModel: event.decodedData));
  }

  Future<void> _onFetchProduct(FetchProduct event, Emitter<FaState> emit) async {
    try {
      emit(state.copyWith(loadingProduct: true));
      final faceValue = _getFaceValue(state);

      if (faceValue == "N/A") {
        throw Exception("No matching personality value found");
      }

      final productData = await FaService().fetchProductData(faceValue);

      final productDataLip = await FaService().fetchProductLipData(faceValue);

      final productDataLook = await FaService().fetchProductLookData(faceValue);

      final productDataPerfume = await FaService().fetchProductPerfumeData(faceValue);

      print(productData);

      emit(state.copyWith(
        productData: productData,
        productModelLip: productDataLip,
        productModelLook: productDataLook,
        productModelPerfume: productDataPerfume,
        loadingProduct: false,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), loadingProduct: false));
    }
  }

  String _getFaceValue(FaState faState) {
    final faceLabel = faState.resultFaceAnalyzeModel!.firstWhere(
          (model) => model.name == "Face Shape",
      orElse: () => ResultFaceAnalyzeModel(name: "Face Shape", outputLabel: ""),
    ).outputLabel;

    if (faceLabel == null || faceLabel.isEmpty) {
      return "N/A";
    }

    const face_shapes = [
      {"label": "Oval", "value": "6669"},
      {"label": "Round", "value": "6670"},
      {"label": "Square", "value": "6671"},
      {"label": "Diamond", "value": "6672"},
      {"label": "Heart", "value": "6673"},
      {"label": "Oblong", "value": "6674"},
    ];

    final face = face_shapes.firstWhere(
          (item) => item["label"] == faceLabel,
      orElse: () => {"value": "N/A"},
    );

    return face["value"] ?? "N/A";
  }
}
