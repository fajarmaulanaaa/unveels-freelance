part of 'stf_bloc.dart';

class StfState extends Equatable {
  final bool isAllowCamera;
  final SkinToneModel? skinTone;
  final bool isLoading;
  final String? errorMessage;
  final String? hexColor;
  final String? skinType;

  final List<Map<String, String>>? matchedTones;
  final String? selectToneSkinId;

  // tonetype
  final ToneTypeModel? toneTypeData;
  final List<String>? toneTypeOptions;
  final String? toneTypeSelectId;

  //product
  final bool? loadingProduct;
  final ProductModel? productData;

  //active tab
  final int? activeTab;

  const StfState({
    this.isAllowCamera = false,
    this.skinTone,
    this.isLoading = false,
    this.errorMessage,
    this.hexColor,
    this.skinType,
    this.matchedTones,
    this.selectToneSkinId,
    this.toneTypeData,
    this.toneTypeOptions,
    this.toneTypeSelectId,
    this.loadingProduct,
    this.productData,
    this.activeTab,
  });

  factory StfState.initial() {
    return const StfState(
      isAllowCamera: false,
      skinTone: null,
      isLoading: false,
      errorMessage: null,
      hexColor: '',
      skinType: '',
      matchedTones: [],
      selectToneSkinId: '',
      toneTypeData: null,
      toneTypeOptions: [],
      toneTypeSelectId: '',
      loadingProduct: false,
      productData: null,
      activeTab: 0,
    );
  }

  StfState copyWith({
    bool? isAllowCamera,
    SkinToneModel? skinTone,
    bool? isLoading,
    String? errorMessage,
    String? hexColor,
    String? skinType,
    List<Map<String, String>>? matchedTones,
    String? selectToneSkinId,

    // tone type
    ToneTypeModel? toneTypeData,
    List<String>? toneTypeOptions,
    String? toneTypeSelectId,

    //product
    bool? loadingProduct,
    ProductModel? productData,

    //tab
    int? activeTab,
  }) {
    return StfState(
      isAllowCamera: isAllowCamera ?? this.isAllowCamera,
      skinTone: skinTone ?? this.skinTone,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      hexColor: hexColor ?? this.hexColor,
      skinType: skinType ?? this.skinType,
      matchedTones: matchedTones ?? this.matchedTones,
      selectToneSkinId: selectToneSkinId ?? this.selectToneSkinId,
      toneTypeData: toneTypeData ?? this.toneTypeData,
      toneTypeOptions: toneTypeOptions ?? this.toneTypeOptions,
      toneTypeSelectId: toneTypeSelectId ?? this.toneTypeSelectId,
      loadingProduct: loadingProduct ?? this.loadingProduct,
      productData: productData ?? this.productData,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object?> get props => [
        skinTone,
        isLoading,
        errorMessage,
        hexColor,
        skinType,
        matchedTones,
        selectToneSkinId,
        toneTypeData,
        toneTypeOptions,
        toneTypeSelectId,
        loadingProduct,
        productData,
        activeTab
      ];
}
