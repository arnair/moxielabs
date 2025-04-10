// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ability _$AbilityFromJson(Map<String, dynamic> json) => _Ability(
      id: (json['id'] as num).toInt(),
      abilityName: json['abilityName'] as String,
      generation: json['generation'] as String,
      shortEffect: json['shortEffect'] as String,
    );

Map<String, dynamic> _$AbilityToJson(_Ability instance) => <String, dynamic>{
      'id': instance.id,
      'abilityName': instance.abilityName,
      'generation': instance.generation,
      'shortEffect': instance.shortEffect,
    };
