import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/pf_model.dart';

part 'pf_action.dart';
part 'pf_state.dart';

class PfBloc extends Bloc<PfEvent, PfState> {
  PfBloc() : super(PfState.initial()) {
    on<UpdateAllowCamera>(_onUpdateAllowCamera);
    on<UpdateDataResultPf>(_onUpdateDataResultPf);
  }

  void _onUpdateAllowCamera(UpdateAllowCamera event, Emitter<PfState> emit) {
    emit(state.copyWith(isAllowCamera: event.value));
  }

  void _onUpdateDataResultPf(UpdateDataResultPf event, Emitter<PfState> emit) {
    emit(state.copyWith(resultPersonalityModel: event.decodedData));
  }
}
