// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_pokemons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AllPokemons _$$_AllPokemonsFromJson(Map<String, dynamic> json) =>
    _$_AllPokemons(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AllPokemonsToJson(_$_AllPokemons instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
