import 'package:go_router/go_router.dart';
import 'package:memmatch/core/management/theme/bloc/theme_bloc.dart';
import 'package:memmatch/core/management/theme/theme_manager.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/home/bloc/home_bloc.dart';
import 'package:memmatch/modules/home/bloc/home_state.dart';
import 'package:memmatch/modules/home/models/level_config.dart';
import 'package:memmatch/modules/home/models/score_model.dart';
import 'package:memmatch/modules/home/views/level_card.dart';
import 'package:memmatch/routes/route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Score> scores = [];

  List<LevelConfig> gameLevels = [
    LevelConfig(
        level: 1,
        numCards: 6,
        timeLimit: 240,
        requiredMoves: 12,
        numCardsPerRow: 3,
        isLocked: false),
    LevelConfig(
      level: 2,
      numCards: 8,
      timeLimit: 180,
      requiredMoves: 16,
      numCardsPerRow: 4,
    ),
    LevelConfig(
      level: 3,
      numCards: 10,
      timeLimit: 150,
      requiredMoves: 20,
      numCardsPerRow: 5,
    ),
    LevelConfig(
        level: 4,
        numCards: 12,
        timeLimit: 120,
        requiredMoves: 24,
        numCardsPerRow: 4),
    LevelConfig(
        level: 5,
        numCards: 14,
        timeLimit: 90,
        requiredMoves: 28,
        numCardsPerRow: 5),
    LevelConfig(
        level: 6,
        numCards: 16,
        timeLimit: 80,
        requiredMoves: 32,
        numCardsPerRow: 4),
    LevelConfig(
        level: 7,
        numCards: 18,
        timeLimit: 60,
        requiredMoves: 36,
        numCardsPerRow: 5),
    LevelConfig(
        level: 8,
        numCards: 20,
        timeLimit: 55,
        requiredMoves: 40,
        numCardsPerRow: 5),
    LevelConfig(
        level: 9,
        numCards: 22,
        timeLimit: 50,
        requiredMoves: 44,
        numCardsPerRow: 5),
    LevelConfig(
        level: 10,
        numCards: 24,
        timeLimit: 40,
        requiredMoves: 48,
        numCardsPerRow: 5),
  ];

  int currentLevel = 1;

  @override
  void initState() {
    super.initState();
    // context.read<HomeBloc>().loadScores();
    context.read<HomeBloc>().loadLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        elevation: 0,
        actions: [
          IconButton(
            icon: getThemeIcon(),
            onPressed: () {
              // GoRouter.of(context).pushNamed(RouteName.historyScreen);

              if (ThemeManager.mode == ThemeMode.dark) {
                context.read<ThemeBloc>().handleThemeEvent(ThemeMode.light);
              } else if (ThemeManager.mode == ThemeMode.light) {
                context.read<ThemeBloc>().handleThemeEvent(ThemeMode.system);
              } else {
                context.read<ThemeBloc>().handleThemeEvent(ThemeMode.dark);
              }
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              GoRouter.of(context).pushNamed(RouteName.historyScreen);
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, AppState>(
        listener: (context, state) {
          if (state is ScoresLoaded) {
            scores = state.scores;
            setState(() {});
          }
          if (state is LevelLoaded) {
            currentLevel = state.level + 1;
            // currentLevel = 10;
            setState(() {});
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Select Level',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: gameLevels.length,
                            itemBuilder: (context, index) {
                              final level = gameLevels[index];
                              final isLocked = level.level > currentLevel;

                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: LevelCard(
                                  level: level,
                                  isLocked: isLocked,
                                  onTap: isLocked
                                      ? null
                                      : () => _startLevel(level),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Current Progress',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: currentLevel / gameLevels.length,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Level $currentLevel/${gameLevels.length}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getThemeIcon() {
    switch (ThemeManager.mode) {
      case ThemeMode.system:
        return const Icon(Icons.settings);
      case ThemeMode.dark:
        return const Icon(Icons.dark_mode_outlined);
      case ThemeMode.light:
        return const Icon(Icons.sunny);
    }
  }

  void _startLevel(LevelConfig level) {
    GoRouter.of(context).pushNamed(RouteName.gameScreen, extra: level).then(
      (value) {
        if (mounted) {
          context.read<HomeBloc>().loadLevel();
        }
      },
    );
  }
}
