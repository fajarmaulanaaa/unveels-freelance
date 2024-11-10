part of 'pf_bloc.dart';

abstract class PfEvent extends Equatable {
  const PfEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAllowCamera extends PfEvent {
  final bool value;

  const UpdateAllowCamera(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateDataResultPf extends PfEvent {
  final List<ResultPersonalityModel> decodedData;

  UpdateDataResultPf(this.decodedData);
}
