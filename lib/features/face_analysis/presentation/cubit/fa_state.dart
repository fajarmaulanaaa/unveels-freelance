part of 'fa_bloc.dart';

class FaState extends Equatable {
  final bool isAllowCamera;
  final bool isLoading;
  final List<ResultFaceAnalyzeModel>? resultFaceAnalyzeModel;

  // Product fields
  final bool? loadingProduct;
  final ProductModel? productData;

  // Error message field
  final String? errorMessage;

  const FaState({
    this.isAllowCamera = false,
    this.isLoading = false,
    this.resultFaceAnalyzeModel,
    this.loadingProduct,
    this.productData,
    this.errorMessage,
  });

  factory FaState.initial() {
    return const FaState(
      isAllowCamera: false,
      isLoading: false,
      resultFaceAnalyzeModel: null,
      loadingProduct: false,
      productData: null,
      errorMessage: null,
    );
  }

  FaState copyWith({
    bool? isAllowCamera,
    bool? isLoading,
    List<ResultFaceAnalyzeModel>? resultFaceAnalyzeModel,
    bool? loadingProduct,
    ProductModel? productData,
    String? errorMessage,
  }) {
    return FaState(
      isAllowCamera: isAllowCamera ?? this.isAllowCamera,
      isLoading: isLoading ?? this.isLoading,
      resultFaceAnalyzeModel:
          resultFaceAnalyzeModel ?? this.resultFaceAnalyzeModel,
      loadingProduct: loadingProduct ?? this.loadingProduct,
      productData: productData ?? this.productData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isAllowCamera,
        isLoading,
        resultFaceAnalyzeModel,
        loadingProduct,
        productData,
        errorMessage,
      ];
}
