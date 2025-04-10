// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ability_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ability {
  int get id;
  String get abilityName;
  String get generation;
  String get shortEffect;

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AbilityCopyWith<Ability> get copyWith =>
      _$AbilityCopyWithImpl<Ability>(this as Ability, _$identity);

  /// Serializes this Ability to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Ability &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.abilityName, abilityName) ||
                other.abilityName == abilityName) &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            (identical(other.shortEffect, shortEffect) ||
                other.shortEffect == shortEffect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, abilityName, generation, shortEffect);

  @override
  String toString() {
    return 'Ability(id: $id, abilityName: $abilityName, generation: $generation, shortEffect: $shortEffect)';
  }
}

/// @nodoc
abstract mixin class $AbilityCopyWith<$Res> {
  factory $AbilityCopyWith(Ability value, $Res Function(Ability) _then) =
      _$AbilityCopyWithImpl;
  @useResult
  $Res call(
      {int id, String abilityName, String generation, String shortEffect});
}

/// @nodoc
class _$AbilityCopyWithImpl<$Res> implements $AbilityCopyWith<$Res> {
  _$AbilityCopyWithImpl(this._self, this._then);

  final Ability _self;
  final $Res Function(Ability) _then;

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? abilityName = null,
    Object? generation = null,
    Object? shortEffect = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      abilityName: null == abilityName
          ? _self.abilityName
          : abilityName // ignore: cast_nullable_to_non_nullable
              as String,
      generation: null == generation
          ? _self.generation
          : generation // ignore: cast_nullable_to_non_nullable
              as String,
      shortEffect: null == shortEffect
          ? _self.shortEffect
          : shortEffect // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Ability extends Ability {
  const _Ability(
      {required this.id,
      required this.abilityName,
      required this.generation,
      required this.shortEffect})
      : super._();
  factory _Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  @override
  final int id;
  @override
  final String abilityName;
  @override
  final String generation;
  @override
  final String shortEffect;

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AbilityCopyWith<_Ability> get copyWith =>
      __$AbilityCopyWithImpl<_Ability>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AbilityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Ability &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.abilityName, abilityName) ||
                other.abilityName == abilityName) &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            (identical(other.shortEffect, shortEffect) ||
                other.shortEffect == shortEffect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, abilityName, generation, shortEffect);

  @override
  String toString() {
    return 'Ability(id: $id, abilityName: $abilityName, generation: $generation, shortEffect: $shortEffect)';
  }
}

/// @nodoc
abstract mixin class _$AbilityCopyWith<$Res> implements $AbilityCopyWith<$Res> {
  factory _$AbilityCopyWith(_Ability value, $Res Function(_Ability) _then) =
      __$AbilityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id, String abilityName, String generation, String shortEffect});
}

/// @nodoc
class __$AbilityCopyWithImpl<$Res> implements _$AbilityCopyWith<$Res> {
  __$AbilityCopyWithImpl(this._self, this._then);

  final _Ability _self;
  final $Res Function(_Ability) _then;

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? abilityName = null,
    Object? generation = null,
    Object? shortEffect = null,
  }) {
    return _then(_Ability(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      abilityName: null == abilityName
          ? _self.abilityName
          : abilityName // ignore: cast_nullable_to_non_nullable
              as String,
      generation: null == generation
          ? _self.generation
          : generation // ignore: cast_nullable_to_non_nullable
              as String,
      shortEffect: null == shortEffect
          ? _self.shortEffect
          : shortEffect // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
