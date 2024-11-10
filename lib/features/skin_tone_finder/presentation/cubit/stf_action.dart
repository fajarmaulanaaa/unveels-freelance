part of 'stf_bloc.dart';

abstract class StfEvent extends Equatable {
  const StfEvent();

  @override
  List<Object?> get props => [];
}

//tone type
class FetchToneType extends StfEvent {}

class UpdateToneTypeId extends StfEvent {
  final String newIdToneType;

  const UpdateToneTypeId(this.newIdToneType);

  @override
  List<Object?> get props => [newIdToneType];
}

//skin tone
class FetchSkinTone extends StfEvent {}

class UpdateSelectSkinId extends StfEvent {
  final String newSkinId;

  const UpdateSelectSkinId(this.newSkinId);

  @override
  List<Object?> get props => [newSkinId];
}

//product
class FetchProduct extends StfEvent {}

class ClearData extends StfEvent {}
class UpdateHexColorProduct extends StfEvent {
  final String newColor;

  const UpdateHexColorProduct(this.newColor);

  @override
  List<Object?> get props => [newColor];
}

//tab
class ChangeTabActive extends StfEvent {
  final int value;

  const ChangeTabActive(this.value);

  @override
  List<Object?> get props => [value];
}

//global
class UpdateHexColor extends StfEvent {
  final String newColor;

  const UpdateHexColor(this.newColor);

  @override
  List<Object?> get props => [newColor];
}

class UpdateSkinType extends StfEvent {
  final String newSkinType;

  const UpdateSkinType(this.newSkinType);

  @override
  List<Object?> get props => [newSkinType];
}

class UpdateAllowCamera extends StfEvent {
  final bool value;

  const UpdateAllowCamera(this.value);

  @override
  List<Object?> get props => [value];
}
