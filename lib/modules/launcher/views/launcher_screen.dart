import 'package:get_it/get_it.dart';
import 'package:memmatch/core/management/theme/bloc/theme_bloc.dart';
import 'package:memmatch/core/management/theme/theme_manager.dart';
import 'package:memmatch/core/management/theme/util.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/core/repositories/local_storage_repository.dart';
import 'package:memmatch/modules/error/views/error_screen.dart';
import 'package:memmatch/modules/game/bloc/game_bloc.dart';
import 'package:memmatch/modules/history/bloc/history_bloc.dart';
import 'package:memmatch/modules/home/bloc/home_bloc.dart';
import 'package:memmatch/modules/register/bloc/register_bloc.dart';
import 'package:memmatch/routes/route_provider.dart';
import 'package:toastification/toastification.dart';

import '../../../injector.dart';

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
        create: (context) =>
            ThemeBloc(getIt.get<LocalStorageRepository>())..loadLocalTheme(),
      ),
      BlocProvider(
        create: (context) => getIt.get<HomeBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt.get<GameBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt.get<HistoryBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt.get<RegisterBloc>(),
      ),
    ], child: getLauncherScreen());
  }

  Widget getLauncherScreen() {
    return BlocBuilder<ThemeBloc, AppState>(builder: (context, state) {
      ThemeManager.context = context;
      print("Theme Manager ${ThemeManager.mode.name}");
      return FutureBuilder(
          future: AppRouter.createRouter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading spinner while router is being prepared
            }
            if (snapshot.hasError) {
              return const ErrorScreen(); // Handle error if router creation fails
            }
            return ResponsiveSizer(builder: (p0, p1, p2) {
              return ToastificationWrapper(
                config: ToastificationConfig(
                    applyMediaQueryViewInsets: true, itemWidth: 30.w),
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  themeMode: ThemeManager.mode,
                  darkTheme: ThemeManager.appThemeData[AppTheme.Dark],
                  theme: ThemeManager.appThemeData[AppTheme.Light],
                  routerDelegate: snapshot.data!.routerDelegate,
                  routeInformationParser: snapshot.data!.routeInformationParser,
                  routeInformationProvider:
                      snapshot.data!.routeInformationProvider,
                ),
              );
            });
          });
    });
  }
}
