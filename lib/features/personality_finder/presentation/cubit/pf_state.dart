part of 'pf_bloc.dart';

class PfState extends Equatable {
  final bool isAllowCamera;
  final bool isLoading;
  final List<ResultPersonalityModel>? resultPersonalityModel;

  const PfState({
    this.isAllowCamera = false,
    this.isLoading = false,
    this.resultPersonalityModel,
  });

  factory PfState.initial() {
    return const PfState(
      isAllowCamera: false,
      isLoading: false,
      resultPersonalityModel: null
    );
  }

  PfState copyWith({
    bool? isAllowCamera,
    bool? isLoading,
    List<ResultPersonalityModel>? resultPersonalityModel
  }) {
    return PfState(
      isAllowCamera: isAllowCamera ?? this.isAllowCamera,
      isLoading: isLoading ?? this.isLoading,
      resultPersonalityModel: resultPersonalityModel ?? this.resultPersonalityModel
    );
  }

  @override
  List<Object?> get props => [isAllowCamera, isLoading];
}
