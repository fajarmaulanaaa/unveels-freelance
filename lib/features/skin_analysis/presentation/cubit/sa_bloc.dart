import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sa_action.dart';
part 'sa_state.dart';

class SaBloc extends Bloc<SaEvent, SaState> {
  SaBloc() : super(SaState.initial()) {
    on<UpdateAllowCamera>(_onUpdateAllowCamera);
  }
  void _onUpdateAllowCamera(UpdateAllowCamera event, Emitter<SaState> emit) {
    emit(state.copyWith(isAllowCamera: event.value));
  }
}
