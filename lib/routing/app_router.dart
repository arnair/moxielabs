import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({GlobalKey<NavigatorState>? navigatorKey})
      : super(navigatorKey: navigatorKey ?? GlobalKey<NavigatorState>());

  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoadingRoute.page, initial: true, path: '/'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: SearchRoute.page, path: '/search'),
        // AutoRoute(page: MyPokedexRoute.page, path: '/pokedex'),
      ];
}
