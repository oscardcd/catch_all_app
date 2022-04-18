// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_index.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameIndex _$GameIndexFromJson(Map<String, dynamic> json) {
  return _GameIndex.fromJson(json);
}

/// @nodoc
class _$GameIndexTearOff {
  const _$GameIndexTearOff();

  _GameIndex call({int? gameIndex, Species? version}) {
    return _GameIndex(
      gameIndex: gameIndex,
      version: version,
    );
  }

  GameIndex fromJson(Map<String, Object?> json) {
    return GameIndex.fromJson(json);
  }
}

/// @nodoc
const $GameIndex = _$GameIndexTearOff();

/// @nodoc
mixin _$GameIndex {
  int? get gameIndex => throw _privateConstructorUsedError;
  Species? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameIndexCopyWith<GameIndex> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameIndexCopyWith<$Res> {
  factory $GameIndexCopyWith(GameIndex value, $Res Function(GameIndex) then) =
      _$GameIndexCopyWithImpl<$Res>;
  $Res call({int? gameIndex, Species? version});

  $SpeciesCopyWith<$Res>? get version;
}

/// @nodoc
class _$GameIndexCopyWithImpl<$Res> implements $GameIndexCopyWith<$Res> {
  _$GameIndexCopyWithImpl(this._value, this._then);

  final GameIndex _value;
  // ignore: unused_field
  final $Res Function(GameIndex) _then;

  @override
  $Res call({
    Object? gameIndex = freezed,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      gameIndex: gameIndex == freezed
          ? _value.gameIndex
          : gameIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as Species?,
    ));
  }

  @override
  $SpeciesCopyWith<$Res>? get version {
    if (_value.version == null) {
      return null;
    }

    return $SpeciesCopyWith<$Res>(_value.version!, (value) {
      return _then(_value.copyWith(version: value));
    });
  }
}

/// @nodoc
abstract class _$GameIndexCopyWith<$Res> implements $GameIndexCopyWith<$Res> {
  factory _$GameIndexCopyWith(
          _GameIndex value, $Res Function(_GameIndex) then) =
      __$GameIndexCopyWithImpl<$Res>;
  @override
  $Res call({int? gameIndex, Species? version});

  @override
  $SpeciesCopyWith<$Res>? get version;
}

/// @nodoc
class __$GameIndexCopyWithImpl<$Res> extends _$GameIndexCopyWithImpl<$Res>
    implements _$GameIndexCopyWith<$Res> {
  __$GameIndexCopyWithImpl(_GameIndex _value, $Res Function(_GameIndex) _then)
      : super(_value, (v) => _then(v as _GameIndex));

  @override
  _GameIndex get _value => super._value as _GameIndex;

  @override
  $Res call({
    Object? gameIndex = freezed,
    Object? version = freezed,
  }) {
    return _then(_GameIndex(
      gameIndex: gameIndex == freezed
          ? _value.gameIndex
          : gameIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as Species?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameIndex implements _GameIndex {
  _$_GameIndex({this.gameIndex, this.version});

  factory _$_GameIndex.fromJson(Map<String, dynamic> json) =>
      _$$_GameIndexFromJson(json);

  @override
  final int? gameIndex;
  @override
  final Species? version;

  @override
  String toString() {
    return 'GameIndex(gameIndex: $gameIndex, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameIndex &&
            const DeepCollectionEquality().equals(other.gameIndex, gameIndex) &&
            const DeepCollectionEquality().equals(other.version, version));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(gameIndex),
      const DeepCollectionEquality().hash(version));

  @JsonKey(ignore: true)
  @override
  _$GameIndexCopyWith<_GameIndex> get copyWith =>
      __$GameIndexCopyWithImpl<_GameIndex>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameIndexToJson(this);
  }
}

abstract class _GameIndex implements GameIndex {
  factory _GameIndex({int? gameIndex, Species? version}) = _$_GameIndex;

  factory _GameIndex.fromJson(Map<String, dynamic> json) =
      _$_GameIndex.fromJson;

  @override
  int? get gameIndex;
  @override
  Species? get version;
  @override
  @JsonKey(ignore: true)
  _$GameIndexCopyWith<_GameIndex> get copyWith =>
      throw _privateConstructorUsedError;
}
