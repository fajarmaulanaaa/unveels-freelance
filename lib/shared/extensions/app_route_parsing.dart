import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unveels/features/personality_finder/presentation/pages/pf_webview_page.dart';
import 'package:unveels/features/shop_the_look/presentation/pages/stl_webview_page.dart';
import 'package:unveels/features/skin_analysis/presentation/pages/sa_webview_page.dart';
import 'package:unveels/features/skin_tone_finder/presentation/pages/stf_webview_page.dart';
import '../../features/face_analysis/presentation/pages/fa_webview_page.dart';
import '../../features/find_the_look/presentation/pages/ftl_home_page.dart';
import '../../features/find_the_look/presentation/pages/ftl_live_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/shop_the_look/presentation/pages/stl_live_page.dart';
import '../configs/route_config.dart';

extension AppRouteParsing on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.home:
        return '/';
      case AppRoute.ftlHome:
        return 'ftl_home';
      case AppRoute.ftlLive:
        return 'ftl_live';
      case AppRoute.saWebview:
        return 'sa_live';
      case AppRoute.stfWebview:
        return 'stf_live';
      case AppRoute.pfWebView:
        return 'pf_live';
      case AppRoute.stlLive:
        return 'stl_live';
      case AppRoute.faWebView:
        return 'fa_live';
    }
  }

  Widget widget({
    Object? arguments,
  }) {
    switch (this) {
      case AppRoute.home:
        return const HomePage();
      case AppRoute.ftlHome:
        return const FTLHomePage();
      case AppRoute.ftlLive:
        FTLLivePageParams? params;
        if (arguments is FTLLivePageParams) {
          params = arguments;
        }

        return FTLLivePage(
          params: params,
        );
      case AppRoute.saWebview:
        return const SaWebviewPage();
      case AppRoute.stfWebview:
        return const StfWebviewPage();
      case AppRoute.pfWebView:
        return const PfWebviewPage();
      case AppRoute.faWebView:
        return const FaWebviewPage();
      case AppRoute.stlLive:
        return const STLWebviewPage();
        // return const STLLivePage();
    }
  }

  GoRoute router({
    GlobalKey<NavigatorState>? parentNavigatorKey,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      name: name,
      routes: routes,
      parentNavigatorKey: parentNavigatorKey,
      builder: (context, state) {
        final extra = state.extra;

        return widget(
          arguments: extra,
        );
      },
    );
  }
}
