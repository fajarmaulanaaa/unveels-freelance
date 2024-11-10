part of 'sa_bloc.dart';

abstract class SaEvent extends Equatable {
  const SaEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAllowCamera extends SaEvent {
  final bool value;

  const UpdateAllowCamera(this.value);

  @override
  List<Object?> get props => [value];
}
