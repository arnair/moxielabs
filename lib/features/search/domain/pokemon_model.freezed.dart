// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Pokemon {
  int get id;
  String get name;
  String get imageUrl;
  List<PokemonTypes> get type;
  bool get captured;
  List<Ability> get abilities;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PokemonCopyWith<Pokemon> get copyWith =>
      _$PokemonCopyWithImpl<Pokemon>(this as Pokemon, _$identity);

  /// Serializes this Pokemon to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Pokemon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            (identical(other.captured, captured) ||
                other.captured == captured) &&
            const DeepCollectionEquality().equals(other.abilities, abilities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      imageUrl,
      const DeepCollectionEquality().hash(type),
      captured,
      const DeepCollectionEquality().hash(abilities));

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, imageUrl: $imageUrl, type: $type, captured: $captured, abilities: $abilities)';
  }
}

/// @nodoc
abstract mixin class $PokemonCopyWith<$Res> {
  factory $PokemonCopyWith(Pokemon value, $Res Function(Pokemon) _then) =
      _$PokemonCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String imageUrl,
      List<PokemonTypes> type,
      bool captured,
      List<Ability> abilities});
}

/// @nodoc
class _$PokemonCopyWithImpl<$Res> implements $PokemonCopyWith<$Res> {
  _$PokemonCopyWithImpl(this._self, this._then);

  final Pokemon _self;
  final $Res Function(Pokemon) _then;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? type = null,
    Object? captured = null,
    Object? abilities = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<PokemonTypes>,
      captured: null == captured
          ? _self.captured
          : captured // ignore: cast_nullable_to_non_nullable
              as bool,
      abilities: null == abilities
          ? _self.abilities
          : abilities // ignore: cast_nullable_to_non_nullable
              as List<Ability>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Pokemon extends Pokemon {
  const _Pokemon(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required final List<PokemonTypes> type,
      this.captured = false,
      required final List<Ability> abilities})
      : _type = type,
        _abilities = abilities,
        super._();
  factory _Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String imageUrl;
  final List<PokemonTypes> _type;
  @override
  List<PokemonTypes> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  @override
  @JsonKey()
  final bool captured;
  final List<Ability> _abilities;
  @override
  List<Ability> get abilities {
    if (_abilities is EqualUnmodifiableListView) return _abilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_abilities);
  }

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PokemonCopyWith<_Pokemon> get copyWith =>
      __$PokemonCopyWithImpl<_Pokemon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PokemonToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Pokemon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            (identical(other.captured, captured) ||
                other.captured == captured) &&
            const DeepCollectionEquality()
                .equals(other._abilities, _abilities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      imageUrl,
      const DeepCollectionEquality().hash(_type),
      captured,
      const DeepCollectionEquality().hash(_abilities));

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, imageUrl: $imageUrl, type: $type, captured: $captured, abilities: $abilities)';
  }
}

/// @nodoc
abstract mixin class _$PokemonCopyWith<$Res> implements $PokemonCopyWith<$Res> {
  factory _$PokemonCopyWith(_Pokemon value, $Res Function(_Pokemon) _then) =
      __$PokemonCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String imageUrl,
      List<PokemonTypes> type,
      bool captured,
      List<Ability> abilities});
}

/// @nodoc
class __$PokemonCopyWithImpl<$Res> implements _$PokemonCopyWith<$Res> {
  __$PokemonCopyWithImpl(this._self, this._then);

  final _Pokemon _self;
  final $Res Function(_Pokemon) _then;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? type = null,
    Object? captured = null,
    Object? abilities = null,
  }) {
    return _then(_Pokemon(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<PokemonTypes>,
      captured: null == captured
          ? _self.captured
          : captured // ignore: cast_nullable_to_non_nullable
              as bool,
      abilities: null == abilities
          ? _self._abilities
          : abilities // ignore: cast_nullable_to_non_nullable
              as List<Ability>,
    ));
  }
}

// dart format on
