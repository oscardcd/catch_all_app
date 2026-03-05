import 'package:catch_all_app/domain/entities/species.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'move.freezed.dart';
part 'move.g.dart';

@freezed
abstract class Move with _$Move {
  factory Move({
    Species? move,
    @JsonKey(name: 'version_group_details') List<VersionGroupDetail>? versionGroupDetails,
  }) = _Move;

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);
}

@freezed
abstract class VersionGroupDetail with _$VersionGroupDetail {
  factory VersionGroupDetail({
    @JsonKey(name: 'level_learned_at') int? levelLearnedAt,
    @JsonKey(name: 'move_learn_method') Species? moveLearnMethod,
    @JsonKey(name: 'version_group') Species? versionGroup,
  }) = _VersionGroupDetail;

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) => _$VersionGroupDetailFromJson(json);
}
