// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter_pokedex/features/authentication/presentation/loading_screen.dart'
    as _i1;
import 'package:flutter_pokedex/features/authentication/presentation/login_screen.dart'
    as _i2;
import 'package:flutter_pokedex/features/search/presentation/search_screen.dart'
    as _i3;

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i4.PageRouteInfo<void> {
  const LoadingRoute({List<_i4.PageRouteInfo>? children})
    : super(LoadingRoute.name, initialChildren: children);

  static const String name = 'LoadingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoadingScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.SearchScreen]
class SearchRoute extends _i4.PageRouteInfo<void> {
  const SearchRoute({List<_i4.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SearchScreen();
    },
  );
}
