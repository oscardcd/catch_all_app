// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'held_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HeldItem _$HeldItemFromJson(Map<String, dynamic> json) {
  return _HeldItem.fromJson(json);
}

/// @nodoc
class _$HeldItemTearOff {
  const _$HeldItemTearOff();

  _HeldItem call({Species? item}) {
    return _HeldItem(
      item: item,
    );
  }

  HeldItem fromJson(Map<String, Object?> json) {
    return HeldItem.fromJson(json);
  }
}

/// @nodoc
const $HeldItem = _$HeldItemTearOff();

/// @nodoc
mixin _$HeldItem {
  Species? get item => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HeldItemCopyWith<HeldItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeldItemCopyWith<$Res> {
  factory $HeldItemCopyWith(HeldItem value, $Res Function(HeldItem) then) =
      _$HeldItemCopyWithImpl<$Res>;
  $Res call({Species? item});

  $SpeciesCopyWith<$Res>? get item;
}

/// @nodoc
class _$HeldItemCopyWithImpl<$Res> implements $HeldItemCopyWith<$Res> {
  _$HeldItemCopyWithImpl(this._value, this._then);

  final HeldItem _value;
  // ignore: unused_field
  final $Res Function(HeldItem) _then;

  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(_value.copyWith(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Species?,
    ));
  }

  @override
  $SpeciesCopyWith<$Res>? get item {
    if (_value.item == null) {
      return null;
    }

    return $SpeciesCopyWith<$Res>(_value.item!, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc
abstract class _$HeldItemCopyWith<$Res> implements $HeldItemCopyWith<$Res> {
  factory _$HeldItemCopyWith(_HeldItem value, $Res Function(_HeldItem) then) =
      __$HeldItemCopyWithImpl<$Res>;
  @override
  $Res call({Species? item});

  @override
  $SpeciesCopyWith<$Res>? get item;
}

/// @nodoc
class __$HeldItemCopyWithImpl<$Res> extends _$HeldItemCopyWithImpl<$Res>
    implements _$HeldItemCopyWith<$Res> {
  __$HeldItemCopyWithImpl(_HeldItem _value, $Res Function(_HeldItem) _then)
      : super(_value, (v) => _then(v as _HeldItem));

  @override
  _HeldItem get _value => super._value as _HeldItem;

  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(_HeldItem(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Species?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HeldItem implements _HeldItem {
  _$_HeldItem({this.item});

  factory _$_HeldItem.fromJson(Map<String, dynamic> json) =>
      _$$_HeldItemFromJson(json);

  @override
  final Species? item;

  @override
  String toString() {
    return 'HeldItem(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HeldItem &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(item));

  @JsonKey(ignore: true)
  @override
  _$HeldItemCopyWith<_HeldItem> get copyWith =>
      __$HeldItemCopyWithImpl<_HeldItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HeldItemToJson(this);
  }
}

abstract class _HeldItem implements HeldItem {
  factory _HeldItem({Species? item}) = _$_HeldItem;

  factory _HeldItem.fromJson(Map<String, dynamic> json) = _$_HeldItem.fromJson;

  @override
  Species? get item;
  @override
  @JsonKey(ignore: true)
  _$HeldItemCopyWith<_HeldItem> get copyWith =>
      throw _privateConstructorUsedError;
}
