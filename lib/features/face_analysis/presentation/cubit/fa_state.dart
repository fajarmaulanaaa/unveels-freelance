part of 'fa_bloc.dart';

class FaState extends Equatable {
  final bool isAllowCamera;
  final bool isLoading;
  final List<ResultFaceAnalyzeModel>? resultFaceAnalyzeModel;

  const FaState({
    this.isAllowCamera = false,
    this.isLoading = false,
    this.resultFaceAnalyzeModel,
  });

  factory FaState.initial() {
    return const FaState(
        isAllowCamera: false,
        isLoading: false,
        resultFaceAnalyzeModel: null
    );
  }

  FaState copyWith({
    bool? isAllowCamera,
    bool? isLoading,
    List<ResultFaceAnalyzeModel>? resultFaceAnalyzeModel
  }) {
    return FaState(
        isAllowCamera: isAllowCamera ?? this.isAllowCamera,
        isLoading: isLoading ?? this.isLoading,
        resultFaceAnalyzeModel: resultFaceAnalyzeModel ?? this.resultFaceAnalyzeModel
    );
  }

  @override
  List<Object?> get props => [isAllowCamera, isLoading];
}
