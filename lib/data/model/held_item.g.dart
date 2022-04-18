// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'held_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HeldItem _$$_HeldItemFromJson(Map<String, dynamic> json) => _$_HeldItem(
      item: json['item'] == null
          ? null
          : Species.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_HeldItemToJson(_$_HeldItem instance) =>
    <String, dynamic>{
      'item': instance.item,
    };
