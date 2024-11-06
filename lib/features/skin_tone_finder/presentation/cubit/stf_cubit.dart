import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unveels/features/skin_tone_finder/presentation/models/skin_tone_model.dart';
import 'package:unveels/shared/service/stf_service.dart';

part 'stf_state.dart';

class StfCubit extends Cubit<StfState> {
  StfCubit() : super(StfState.initial());

  void updateHexColor(String newColor) {
    emit(state.copyWith(hexColor: newColor));
  }

  void updateSkinType(String newSkinType) {
    emit(state.copyWith(skinType: newSkinType));
  }

  Future<void> fetchSkinTone() async {
    try {
      emit(state.copyWith(isLoading: true));
      final skinToneData = await StfService().fetchSkinToneData();
      final matchTone =
          skinToneData.options!.map((e) => e.label ?? '').toList();
      emit(state.copyWith(
        skinTone: skinToneData,
        matchedTones: matchTone,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
