part of 'stf_cubit.dart';

class StfState extends Equatable {
  final SkinToneModel? skinTone;
  final bool isLoading;
  final String? errorMessage;
  final String? hexColor;
  final String? skinType;

  //skin tone
  final List<String>? matchedTones;

  const StfState(
      {this.skinTone,
      this.isLoading = false,
      this.errorMessage,
      this.hexColor,
      this.skinType,
      this.matchedTones});

  factory StfState.initial() {
    return StfState(
        skinTone: null,
        isLoading: false,
        errorMessage: null,
        hexColor: '',
        skinType: '',
        matchedTones: []);
  }

  StfState copyWith({
    int? counter,
    SkinToneModel? skinTone,
    bool? isLoading,
    String? errorMessage,
    String? hexColor,
    String? skinType,
    List<String>? matchedTones,
  }) {
    return StfState(
      skinTone: skinTone ?? this.skinTone,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      hexColor: hexColor ?? this.hexColor,
      skinType: skinType ?? this.skinType,
      matchedTones: matchedTones ?? this.matchedTones,
    );
  }

  @override
  List<Object?> get props =>
      [skinTone, isLoading, errorMessage, hexColor, skinType, matchedTones];
}
