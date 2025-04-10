// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokedexControllerHash() => r'35b7d1df5a1086401f1c59110b2329c7a65e7c07';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PokedexController
    extends BuildlessAutoDisposeNotifier<List<Pokemon>> {
  late final User user;

  List<Pokemon> build(
    User user,
  );
}

/// See also [PokedexController].
@ProviderFor(PokedexController)
const pokedexControllerProvider = PokedexControllerFamily();

/// See also [PokedexController].
class PokedexControllerFamily extends Family<List<Pokemon>> {
  /// See also [PokedexController].
  const PokedexControllerFamily();

  /// See also [PokedexController].
  PokedexControllerProvider call(
    User user,
  ) {
    return PokedexControllerProvider(
      user,
    );
  }

  @override
  PokedexControllerProvider getProviderOverride(
    covariant PokedexControllerProvider provider,
  ) {
    return call(
      provider.user,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pokedexControllerProvider';
}

/// See also [PokedexController].
class PokedexControllerProvider
    extends AutoDisposeNotifierProviderImpl<PokedexController, List<Pokemon>> {
  /// See also [PokedexController].
  PokedexControllerProvider(
    User user,
  ) : this._internal(
          () => PokedexController()..user = user,
          from: pokedexControllerProvider,
          name: r'pokedexControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pokedexControllerHash,
          dependencies: PokedexControllerFamily._dependencies,
          allTransitiveDependencies:
              PokedexControllerFamily._allTransitiveDependencies,
          user: user,
        );

  PokedexControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.user,
  }) : super.internal();

  final User user;

  @override
  List<Pokemon> runNotifierBuild(
    covariant PokedexController notifier,
  ) {
    return notifier.build(
      user,
    );
  }

  @override
  Override overrideWith(PokedexController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PokedexControllerProvider._internal(
        () => create()..user = user,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        user: user,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PokedexController, List<Pokemon>>
      createElement() {
    return _PokedexControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PokedexControllerProvider && other.user == user;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, user.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PokedexControllerRef on AutoDisposeNotifierProviderRef<List<Pokemon>> {
  /// The parameter `user` of this provider.
  User get user;
}

class _PokedexControllerProviderElement
    extends AutoDisposeNotifierProviderElement<PokedexController, List<Pokemon>>
    with PokedexControllerRef {
  _PokedexControllerProviderElement(super.provider);

  @override
  User get user => (origin as PokedexControllerProvider).user;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
