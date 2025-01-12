import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memmatch/core/constants/app_constants.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/core/repositories/local_storage_repository.dart';
import 'package:memmatch/injector.dart';
import 'package:memmatch/modules/error/views/error_screen.dart';
import 'package:memmatch/modules/game/bloc/game_bloc.dart';
import 'package:memmatch/modules/game/views/game_screen.dart';
import 'package:memmatch/modules/history/views/history_screen.dart';
import 'package:memmatch/modules/home/models/level_config.dart';
import 'package:memmatch/modules/home/views/home_screen.dart';
import 'package:memmatch/modules/register/view/register_screen.dart';
import 'package:memmatch/modules/result/views/result_screen.dart';
import 'package:memmatch/routes/route_name.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final LocalStorageRepository localStorageRepository =
      LocalStorageRepository();

  static Future<String> _initialRoute() async {
    // Check if an avatar path is saved in local storage
    var avatarPath = null;
    var response =
        await localStorageRepository.getDocument(AppConstants.AVATAR_PATH);
    if (response.payload["data"] != null) {
      avatarPath = response.payload["data"];
    }
    // Return the appropriate route based on the saved avatar path
    return avatarPath != null && avatarPath.isNotEmpty
        ? RouteName.homeScreen
        : RouteName.registerScreen;
  }

  static Future<GoRouter> createRouter() async {
    final initialLocation = await _initialRoute();
    // static var graph =
    return GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: false,
      initialLocation: RouteName.defaultRoute,
      routes: [
        GoRoute(
          path: RouteName.defaultRoute,
          name: RouteName.defaultRoute,
          // redirect: (_, __) => RouteName.registerScreen,
          redirect: (_, __) => initialLocation,
        ),
        buildNoTransitionRoute(RouteName.errorRoute, const ErrorScreen()),
        // buildNoTransitionRoute(RouteName.productRoute, const ProductScreen()),
        buildNoTransitionRoute(
            RouteName.registerScreen,
            RegisterScreen(
              viewType: "NEW",
            )),
        buildNoTransitionRoute(
            RouteName.editProfileScreen,
            RegisterScreen(
              viewType: "EDIT",
            )),
        buildNoTransitionRoute(RouteName.homeScreen, HomeScreen(), routes: [
          buildNoTransitionRoute(RouteName.resultScreen, ResultScreen()),
          buildNoTransitionRoute(RouteName.historyScreen, HistoryScreen()),
          buildNoTransitionRoute(
            RouteName.gameScreen,
            null,
            screenWithState: (context, state) {
              if (state.extra != null) {
                if (state.extra is LevelConfig?) {
                  var levelConfig = state.extra as LevelConfig;
                  // return BlocProvider(
                  //     key: UniqueKey(),
                  //     create: (context) => getIt.get<GameBloc>(),
                  //     child: GameScreen(
                  //         levelConfig: levelConfig));
                  return GameScreen(levelConfig: levelConfig);
                } else {
                  return ErrorScreen();
                }
              } else {
                return ErrorScreen();
              }
            },
          ),
        ]),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
    );
  }

  static GoRoute buildNoTransitionRoute(String path, Widget? screen,
      {String? name,
      Widget Function(BuildContext context, GoRouterState state)?
          screenWithState,
      List<GoRoute>? routes}) {
    return GoRoute(
        path: path,
        name: name ?? path,
        pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              name: state.name,
              child: screenWithState != null
                  ? screenWithState(context, state)
                  : screen ?? Container(),
            ),
        routes: routes ?? []);
  }
}
