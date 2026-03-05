import 'package:freezed_annotation/freezed_annotation.dart';

part 'cries.freezed.dart';
part 'cries.g.dart';

@freezed
abstract class Cries with _$Cries {
  factory Cries({
    String? latest,
    String? legacy,
  }) = _Cries;

  factory Cries.fromJson(Map<String, dynamic> json) => _$CriesFromJson(json);
}
