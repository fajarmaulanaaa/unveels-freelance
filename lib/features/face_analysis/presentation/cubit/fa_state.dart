part of 'fa_bloc.dart';

class FaState extends Equatable {
  final bool isAllowCamera;
  final bool isLoading;
  final List<ResultFaceAnalyzeModel>? resultFaceAnalyzeModel;

  // Product fields
  final bool? loadingProduct;
  final ProductModel? productData;
  final ProductModelLip? productModelLip;
  final ProductModelPerfume? productModelPerfume;
  final ProductModelLook? productModelLook;

  // Error message field
  final String? errorMessage;

  const FaState({
    this.isAllowCamera = false,
    this.isLoading = false,
    this.resultFaceAnalyzeModel,
    this.loadingProduct,
    this.productData,
    this.productModelLip,
    this.productModelPerfume,
    this.productModelLook,
    this.errorMessage,
  });

  factory FaState.initial() {
    return const FaState(
      isAllowCamera: false,
      isLoading: false,
      resultFaceAnalyzeModel: null,
      loadingProduct: false,
      productData: null,
      productModelLip: null,
      productModelPerfume: null,
      productModelLook: null,
      errorMessage: null,
    );
  }

  FaState copyWith({
    bool? isAllowCamera,
    bool? isLoading,
    List<ResultFaceAnalyzeModel>? resultFaceAnalyzeModel,
    bool? loadingProduct,
    ProductModel? productData,
    ProductModelLip? productModelLip,
    ProductModelPerfume? productModelPerfume,
    ProductModelLook? productModelLook,
    String? errorMessage,
  }) {
    return FaState(
      isAllowCamera: isAllowCamera ?? this.isAllowCamera,
      isLoading: isLoading ?? this.isLoading,
      resultFaceAnalyzeModel: resultFaceAnalyzeModel ?? this.resultFaceAnalyzeModel,
      loadingProduct: loadingProduct ?? this.loadingProduct,
      productData: productData ?? this.productData,
      productModelLip: productModelLip ?? this.productModelLip,
      productModelPerfume: productModelPerfume ?? this.productModelPerfume,
      productModelLook: productModelLook ?? this.productModelLook,
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
    productModelLip,
    productModelPerfume,
    productModelLook,
    errorMessage,
  ];
}