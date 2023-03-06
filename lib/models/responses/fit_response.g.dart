// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitResponse _$FitResponseFromJson(Map<String, dynamic> json) => FitResponse(
      calories: json['calories'] as String?,
      carbos: json['carbos'] as String?,
      description: json['description'] as String?,
      difficulty: (json['difficulty'] as num?)?.toDouble(),
      fats: json['fats'] as String?,
      headline: json['headline'] as String?,
      id: json['id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      proteins: json['proteins'] as String?,
      thumb: json['thumb'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$FitResponseToJson(FitResponse instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'carbos': instance.carbos,
      'description': instance.description,
      'difficulty': instance.difficulty,
      'fats': instance.fats,
      'headline': instance.headline,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'proteins': instance.proteins,
      'thumb': instance.thumb,
      'time': instance.time,
    };
