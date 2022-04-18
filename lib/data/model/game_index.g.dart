// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameIndex _$$_GameIndexFromJson(Map<String, dynamic> json) => _$_GameIndex(
      gameIndex: json['gameIndex'] as int?,
      version: json['version'] == null
          ? null
          : Species.fromJson(json['version'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameIndexToJson(_$_GameIndex instance) =>
    <String, dynamic>{
      'gameIndex': instance.gameIndex,
      'version': instance.version,
    };
