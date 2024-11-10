part of 'sa_bloc.dart';

class SaState extends Equatable {
  final bool isAllowCamera;
  final bool isLoading;

  const SaState({
    this.isAllowCamera = false,
    this.isLoading = false,
  });

  factory SaState.initial() {
    return const SaState(
      isAllowCamera: false,
      isLoading: false,
    );
  }

  SaState copyWith({
    bool? isAllowCamera,
    bool? isLoading,
  }) {
    return SaState(
      isAllowCamera: isAllowCamera ?? this.isAllowCamera,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isAllowCamera, isLoading];
}
