import 'package:json_annotation/json_annotation.dart';

part 'fit_response.g.dart';

@JsonSerializable()
class FitResponse {
  @JsonKey(name: 'calories')
  String? calories;

  @JsonKey(name: 'carbos')
  String? carbos;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'difficulty')
  double? difficulty;

  @JsonKey(name: 'fats')
  String? fats;

  @JsonKey(name: 'headline')
  String? headline;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'proteins')
  String? proteins;

  @JsonKey(name: 'thumb')
  String? thumb;

  @JsonKey(name: 'time')
  String? time;

  FitResponse({
    this.calories,
    this.carbos,
    this.description,
    this.difficulty,
    this.fats,
    this.headline,
    this.id,
    this.image,
    this.name,
    this.proteins,
    this.thumb,
    this.time,
  });

  factory FitResponse.fromJson(Map<String, dynamic> json) => _$FitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FitResponseToJson(this);
}
