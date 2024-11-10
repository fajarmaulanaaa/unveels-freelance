import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unveels/features/face_analysis/presentation/models/fa_model.dart';

part 'fa_actions.dart';
part 'fa_state.dart';

class FaBloc extends Bloc<FaEvent, FaState> {
  FaBloc() : super(FaState.initial()) {
    on<UpdateAllowCamera>(_onUpdateAllowCamera);
    on<UpdateDataResultFa>(_onUpdateDataResultFa);
  }

  void _onUpdateAllowCamera(UpdateAllowCamera event, Emitter<FaState> emit) {
    emit(state.copyWith(isAllowCamera: event.value));
  }

  void _onUpdateDataResultFa(UpdateDataResultFa event, Emitter<FaState> emit) {
    emit(state.copyWith(resultFaceAnalyzeModel: event.decodedData));
  }
}
