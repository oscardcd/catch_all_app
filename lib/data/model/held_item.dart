import 'package:catch_poke_app/data/model/species.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'held_item.freezed.dart';
part 'held_item.g.dart';

@freezed
class HeldItem with _$HeldItem {
  factory HeldItem({
    Species? item,
  }) = _HeldItem;

  factory HeldItem.fromJson(Map<String, dynamic> json) => _$HeldItemFromJson(json);
}
