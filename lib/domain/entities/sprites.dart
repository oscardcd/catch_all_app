import 'package:freezed_annotation/freezed_annotation.dart';

part 'sprites.freezed.dart';
part 'sprites.g.dart';

@freezed
abstract class Sprites with _$Sprites {
  factory Sprites({
    @JsonKey(name: 'back_default') String? backDefault,
    @JsonKey(name: 'back_female') String? backFemale,
    @JsonKey(name: 'back_shiny') String? backShiny,
    @JsonKey(name: 'back_shiny_female') String? backShinyFemale,
    @JsonKey(name: 'front_default') String? frontDefault,
    @JsonKey(name: 'front_female') String? frontFemale,
    @JsonKey(name: 'front_shiny') String? frontShiny,
    @JsonKey(name: 'front_shiny_female') String? frontShinyFemale,
    OtherSprites? other,
    Versions? versions,
  }) = _Sprites;

  factory Sprites.fromJson(Map<String, dynamic> json) => _$SpritesFromJson(json);
}

@freezed
abstract class OtherSprites with _$OtherSprites {
  factory OtherSprites({
    @JsonKey(name: 'dream_world') DreamWorld? dreamWorld,
    Home? home,
    @JsonKey(name: 'official-artwork') OfficialArtwork? officialArtwork,
    Sprites? showdown,
  }) = _OtherSprites;

  factory OtherSprites.fromJson(Map<String, dynamic> json) => _$OtherSpritesFromJson(json);
}

@freezed
abstract class Versions with _$Versions {
  factory Versions({
    @JsonKey(name: 'generation-i') GenerationI? generationI,
    @JsonKey(name: 'generation-ii') GenerationIi? generationIi,
    @JsonKey(name: 'generation-iii') GenerationIii? generationIii,
    @JsonKey(name: 'generation-iv') GenerationIv? generationIv,
    @JsonKey(name: 'generation-v') GenerationV? generationV,
    @JsonKey(name: 'generation-vi') Map<String, Home>? generationVi,
    @JsonKey(name: 'generation-vii') GenerationVii? generationVii,
    @JsonKey(name: 'generation-viii') GenerationViii? generationViii,
    @JsonKey(name: 'generation-ix') GenerationIx? generationIx,
  }) = _Versions;

  factory Versions.fromJson(Map<String, dynamic> json) => _$VersionsFromJson(json);
}

@freezed
abstract class GenerationI with _$GenerationI {
  factory GenerationI({@JsonKey(name: 'red-blue') RedBlue? redBlue, RedBlue? yellow}) = _GenerationI;

  factory GenerationI.fromJson(Map<String, dynamic> json) => _$GenerationIFromJson(json);
}

@freezed
abstract class RedBlue with _$RedBlue {
  factory RedBlue({
    @JsonKey(name: 'back_default') String? backDefault,
    @JsonKey(name: 'back_gray') String? backGray,
    @JsonKey(name: 'back_transparent') String? backTransparent,
    @JsonKey(name: 'front_default') String? frontDefault,
    @JsonKey(name: 'front_gray') String? frontGray,
    @JsonKey(name: 'front_transparent') String? frontTransparent,
  }) = _RedBlue;

  factory RedBlue.fromJson(Map<String, dynamic> json) => _$RedBlueFromJson(json);
}

@freezed
abstract class GenerationIi with _$GenerationIi {
  factory GenerationIi({Crystal? crystal, Gold? gold, Gold? silver}) = _GenerationIi;

  factory GenerationIi.fromJson(Map<String, dynamic> json) => _$GenerationIiFromJson(json);
}

@freezed
abstract class Crystal with _$Crystal {
  factory Crystal({
    @JsonKey(name: 'back_default') String? backDefault,
    @JsonKey(name: 'back_shiny') String? backShiny,
    @JsonKey(name: 'back_shiny_transparent') String? backShinyTransparent,
    @JsonKey(name: 'back_transparent') String? backTransparent,
    @JsonKey(name: 'front_default') String? frontDefault,
    @JsonKey(name: 'front_shiny') String? frontShiny,
    @JsonKey(name: 'front_shiny_transparent') String? frontShinyTransparent,
    @JsonKey(name: 'front_transparent') String? frontTransparent,
  }) = _Crystal;

  factory Crystal.fromJson(Map<String, dynamic> json) => _$CrystalFromJson(json);
}

@freezed
abstract class Gold with _$Gold {
  factory Gold({
    @JsonKey(name: 'back_default') String? backDefault,
    @JsonKey(name: 'back_shiny') String? backShiny,
    @JsonKey(name: 'front_default') String? frontDefault,
    @JsonKey(name: 'front_shiny') String? frontShiny,
    @JsonKey(name: 'front_transparent') String? frontTransparent,
  }) = _Gold;

  factory Gold.fromJson(Map<String, dynamic> json) => _$GoldFromJson(json);
}

@freezed
abstract class GenerationIii with _$GenerationIii {
  factory GenerationIii({
    OfficialArtwork? emerald,
    @JsonKey(name: 'firered-leafgreen') Gold? fireredLeafgreen,
    @JsonKey(name: 'ruby-sapphire') Gold? rubySapphire,
  }) = _GenerationIii;

  factory GenerationIii.fromJson(Map<String, dynamic> json) => _$GenerationIiiFromJson(json);
}

@freezed
abstract class GenerationIv with _$GenerationIv {
  factory GenerationIv({
    @JsonKey(name: 'diamond-pearl') Sprites? diamondPearl,
    @JsonKey(name: 'heartgold-soulsilver') Sprites? heartgoldSoulsilver,
    Sprites? platinum,
  }) = _GenerationIv;

  factory GenerationIv.fromJson(Map<String, dynamic> json) => _$GenerationIvFromJson(json);
}

@freezed
abstract class GenerationV with _$GenerationV {
  factory GenerationV({@JsonKey(name: 'black-white') Sprites? blackWhite}) = _GenerationV;

  factory GenerationV.fromJson(Map<String, dynamic> json) => _$GenerationVFromJson(json);
}

@freezed
abstract class GenerationVii with _$GenerationVii {
  factory GenerationVii({DreamWorld? icons, @JsonKey(name: 'ultra-sun-ultra-moon') Home? ultraSunUltraMoon}) =
      _GenerationVii;

  factory GenerationVii.fromJson(Map<String, dynamic> json) => _$GenerationViiFromJson(json);
}

@freezed
abstract class GenerationViii with _$GenerationViii {
  factory GenerationViii({
    @JsonKey(name: 'brilliant-diamond-shining-pearl') DreamWorld? brilliantDiamondShiningPearl,
    DreamWorld? icons,
  }) = _GenerationViii;

  factory GenerationViii.fromJson(Map<String, dynamic> json) => _$GenerationViiiFromJson(json);
}

@freezed
abstract class GenerationIx with _$GenerationIx {
  factory GenerationIx({@JsonKey(name: 'scarlet-violet') DreamWorld? scarletViolet}) = _GenerationIx;

  factory GenerationIx.fromJson(Map<String, dynamic> json) => _$GenerationIxFromJson(json);
}

@freezed
abstract class DreamWorld with _$DreamWorld {
  factory DreamWorld({
    @JsonKey(name: 'front_default') String? frontDefault,
    @JsonKey(name: 'front_female') String? frontFemale,
  }) = _DreamWorld;

  factory DreamWorld.fromJson(Map<String, dynamic> json) => _$DreamWorldFromJson(json);
}

@freezed
abstract class Home with _$Home {
  factory Home({
    @JsonKey(name: 'front_default') String? frontDefault,
    @JsonKey(name: 'front_female') String? frontFemale,
    @JsonKey(name: 'front_shiny') String? frontShiny,
    @JsonKey(name: 'front_shiny_female') String? frontShinyFemale,
  }) = _Home;

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}

@freezed
abstract class OfficialArtwork with _$OfficialArtwork {
  factory OfficialArtwork({
    @JsonKey(name: 'front_default') String? frontDefault,
    @JsonKey(name: 'front_shiny') String? frontShiny,
  }) = _OfficialArtwork;

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) => _$OfficialArtworkFromJson(json);
}
