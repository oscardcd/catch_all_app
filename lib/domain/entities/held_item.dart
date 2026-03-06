import 'package:catch_all_app/domain/entities/species.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'held_item.freezed.dart';
part 'held_item.g.dart';

@freezed
abstract class HeldItem with _$HeldItem {
  factory HeldItem({
    Species? item,
    @JsonKey(name: 'version_details') List<VersionDetail>? versionDetails,
  }) = _HeldItem;

  factory HeldItem.fromJson(Map<String, dynamic> json) => _$HeldItemFromJson(json);
}

@freezed
abstract class VersionDetail with _$VersionDetail {
  factory VersionDetail({
    int? rarity,
    Species? version,
  }) = _VersionDetail;

  factory VersionDetail.fromJson(Map<String, dynamic> json) => _$VersionDetailFromJson(json);
}
