import 'package:freezed_annotation/freezed_annotation.dart';

part 'ability_model.freezed.dart';
part 'ability_model.g.dart';

@freezed
abstract class Ability with _$Ability {
  const Ability._();

  const factory Ability({
    required int id,
    required String abilityName,
    required String generation,
    required String shortEffect,
  }) = _Ability;

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  factory Ability.fromApiJson(Map<String, dynamic> json) {
    return Ability(
      id: json['id'] as int,
      abilityName: (json['name'] as String)[0].toUpperCase() +
          (json['name'] as String).substring(1),
      generation: json['generation']['name'] as String,
      shortEffect: (json['effect_entries'] as List)
          .where((entry) => entry['language']['name'] == 'en')
          .map((entry) => entry['short_effect'] as String)
          .first,
    );
  }
}
