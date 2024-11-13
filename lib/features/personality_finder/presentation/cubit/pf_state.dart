part of 'pf_bloc.dart';

class PfState extends Equatable {
  final bool isAllowCamera;
  final bool isLoading;
  final List<ResultPersonalityModel>? resultPersonalityModel;

  // Product fields
  final bool? loadingProduct;
  final ProductModel? productData;
  final ProductModelLip? productModelLip;
  final ProductModelPerfume? productModelPerfume;
  final ProductModelLook? productModelLook;

  // Error message field
  final String? errorMessage;

  const PfState({
    this.isAllowCamera = false,
    this.isLoading = false,
    this.resultPersonalityModel,
    this.loadingProduct,
    this.productData,
    this.productModelLip,
    this.productModelPerfume,
    this.productModelLook,
    this.errorMessage,
  });

  factory PfState.initial() {
    return const PfState(
      isAllowCamera: false,
      isLoading: false,
      resultPersonalityModel: null,
      loadingProduct: false,
      productData: null,
      productModelLip: null,
      productModelPerfume: null,
      productModelLook: null,
      errorMessage: null,
    );
  }

  PfState copyWith({
    bool? isAllowCamera,
    bool? isLoading,
    List<ResultPersonalityModel>? resultPersonalityModel,
    bool? loadingProduct,
    ProductModel? productData,
    ProductModelLip? productModelLip,
    ProductModelPerfume? productModelPerfume,
    ProductModelLook? productModelLook,
    String? errorMessage,
  }) {
    return PfState(
      isAllowCamera: isAllowCamera ?? this.isAllowCamera,
      isLoading: isLoading ?? this.isLoading,
      resultPersonalityModel: resultPersonalityModel ?? this.resultPersonalityModel,
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
    resultPersonalityModel,
    loadingProduct,
    productData,
    productModelLip,
    productModelPerfume,
    productModelLook,
    errorMessage,
  ];
}