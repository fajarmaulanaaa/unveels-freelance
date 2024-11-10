part of 'fa_bloc.dart';

abstract class FaEvent extends Equatable {
  const FaEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAllowCamera extends FaEvent {
  final bool value;

  const UpdateAllowCamera(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateDataResultFa extends FaEvent {
  final List<ResultFaceAnalyzeModel> decodedData;

  UpdateDataResultFa(this.decodedData);
}
