import 'package:get_it/get_it.dart';
import 'package:memmatch/core/management/theme/bloc/theme_bloc.dart';
import 'package:memmatch/core/management/theme/theme_manager.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/home/bloc/home_bloc.dart';
import 'package:memmatch/routes/route_provider.dart';
import 'package:toastification/toastification.dart';

import '../../../core/injector.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider(
        create: (context) => getIt.get<HomeBloc>(),
      )
    ], child: getLauncherScreen());
  }

  Widget getLauncherScreen() {
    return BlocBuilder<ThemeBloc, AppState>(builder: (context, state) {
      final RouteObserver<ModalRoute> routeObserver =
          RouteObserver<ModalRoute>();

      print("Theme Manager ${ThemeManager.mode.name}");
      return ResponsiveSizer(builder: (p0, p1, p2) {
        return ToastificationWrapper(
          config: ToastificationConfig(
              applyMediaQueryViewInsets: true, itemWidth: 30.w),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeManager.mode,
            darkTheme: ThemeManager.appThemeData[AppTheme.Dark],
            theme: ThemeManager.appThemeData[AppTheme.Light],
            routerDelegate: AppRouter.graph.routerDelegate,
            routeInformationParser: AppRouter.graph.routeInformationParser,
            routeInformationProvider: AppRouter.graph.routeInformationProvider,
          ),
        );
      });
    });
  }
}
