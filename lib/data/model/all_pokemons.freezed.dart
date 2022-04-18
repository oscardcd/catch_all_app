// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'all_pokemons.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AllPokemons _$AllPokemonsFromJson(Map<String, dynamic> json) {
  return _AllPokemons.fromJson(json);
}

/// @nodoc
class _$AllPokemonsTearOff {
  const _$AllPokemonsTearOff();

  _AllPokemons call(
      {int? count, String? next, String? previous, List<Pokemon>? results}) {
    return _AllPokemons(
      count: count,
      next: next,
      previous: previous,
      results: results,
    );
  }

  AllPokemons fromJson(Map<String, Object?> json) {
    return AllPokemons.fromJson(json);
  }
}

/// @nodoc
const $AllPokemons = _$AllPokemonsTearOff();

/// @nodoc
mixin _$AllPokemons {
  int? get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<Pokemon>? get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllPokemonsCopyWith<AllPokemons> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllPokemonsCopyWith<$Res> {
  factory $AllPokemonsCopyWith(
          AllPokemons value, $Res Function(AllPokemons) then) =
      _$AllPokemonsCopyWithImpl<$Res>;
  $Res call(
      {int? count, String? next, String? previous, List<Pokemon>? results});
}

/// @nodoc
class _$AllPokemonsCopyWithImpl<$Res> implements $AllPokemonsCopyWith<$Res> {
  _$AllPokemonsCopyWithImpl(this._value, this._then);

  final AllPokemons _value;
  // ignore: unused_field
  final $Res Function(AllPokemons) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      next: next == freezed
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Pokemon>?,
    ));
  }
}

/// @nodoc
abstract class _$AllPokemonsCopyWith<$Res>
    implements $AllPokemonsCopyWith<$Res> {
  factory _$AllPokemonsCopyWith(
          _AllPokemons value, $Res Function(_AllPokemons) then) =
      __$AllPokemonsCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? count, String? next, String? previous, List<Pokemon>? results});
}

/// @nodoc
class __$AllPokemonsCopyWithImpl<$Res> extends _$AllPokemonsCopyWithImpl<$Res>
    implements _$AllPokemonsCopyWith<$Res> {
  __$AllPokemonsCopyWithImpl(
      _AllPokemons _value, $Res Function(_AllPokemons) _then)
      : super(_value, (v) => _then(v as _AllPokemons));

  @override
  _AllPokemons get _value => super._value as _AllPokemons;

  @override
  $Res call({
    Object? count = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
  }) {
    return _then(_AllPokemons(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      next: next == freezed
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Pokemon>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AllPokemons implements _AllPokemons {
  _$_AllPokemons({this.count, this.next, this.previous, this.results});

  factory _$_AllPokemons.fromJson(Map<String, dynamic> json) =>
      _$$_AllPokemonsFromJson(json);

  @override
  final int? count;
  @override
  final String? next;
  @override
  final String? previous;
  @override
  final List<Pokemon>? results;

  @override
  String toString() {
    return 'AllPokemons(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AllPokemons &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.next, next) &&
            const DeepCollectionEquality().equals(other.previous, previous) &&
            const DeepCollectionEquality().equals(other.results, results));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(next),
      const DeepCollectionEquality().hash(previous),
      const DeepCollectionEquality().hash(results));

  @JsonKey(ignore: true)
  @override
  _$AllPokemonsCopyWith<_AllPokemons> get copyWith =>
      __$AllPokemonsCopyWithImpl<_AllPokemons>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllPokemonsToJson(this);
  }
}

abstract class _AllPokemons implements AllPokemons {
  factory _AllPokemons(
      {int? count,
      String? next,
      String? previous,
      List<Pokemon>? results}) = _$_AllPokemons;

  factory _AllPokemons.fromJson(Map<String, dynamic> json) =
      _$_AllPokemons.fromJson;

  @override
  int? get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<Pokemon>? get results;
  @override
  @JsonKey(ignore: true)
  _$AllPokemonsCopyWith<_AllPokemons> get copyWith =>
      throw _privateConstructorUsedError;
}
