// import 'package:memmatch/modules/home/bloc/home_bloc.dart';
// import 'package:memmatch/modules/home/bloc/home_state.dart';
// import 'package:memmatch/modules/home/views/memory_grid.dart';
//
// import '../../../core/package_loader/load_modules.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<HomeBloc>().getImages();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Memory Match')),
//       body: BlocBuilder<HomeBloc, AppState>(
//         builder: (context, state) {
//           if (state is ImagesLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ImagesLoaded) {
//             return MemoryGrid(images: state.images);
//           } else if (state is ImagesError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Center(child: Text('Press the button to load images'));
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:go_router/go_router.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/game/views/game_screen.dart';
import 'package:memmatch/modules/home/bloc/home_bloc.dart';
import 'package:memmatch/modules/home/bloc/home_state.dart';
import 'package:memmatch/modules/home/models/level_config.dart';
import 'package:memmatch/modules/home/models/score_model.dart';
import 'package:memmatch/modules/home/views/level_card.dart';
import 'package:memmatch/routes/route_name.dart';

class HomeScreen extends StatefulWidget {
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
            currentLevel = 10;
            setState(() {});
          }
        },
        builder: (context, state) {
          // final scores = state is ScoresLoaded ? state.scores : <Score>[];
          // return Column(
          //   children: [
          //     // Game Options
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Card(
          //         child: InkWell(
          //           onTap: () {
          //             GoRouter.of(context).pushNamed(RouteName.gameScreen);
          //             // Navigator.push(
          //             //   context,
          //             //   MaterialPageRoute(
          //             //     builder: (context) => GameScreen(),
          //             //   ),
          //             // );
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.all(20.0),
          //             child: Row(
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.all(12),
          //                   decoration: BoxDecoration(
          //                     color: Theme.of(context)
          //                         .primaryColor
          //                         .withOpacity(0.1),
          //                     borderRadius: BorderRadius.circular(12),
          //                   ),
          //                   child: Icon(
          //                     Icons.play_arrow_rounded,
          //                     size: 32,
          //                     color: Theme.of(context).primaryColor,
          //                   ),
          //                 ),
          //                 const SizedBox(width: 16),
          //                 Expanded(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: const [
          //                       Text(
          //                         'Start New Game',
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                       SizedBox(height: 4),
          //                       Text(
          //                         'Test your memory with a new challenge',
          //                         style: TextStyle(color: Colors.grey),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //
          //     // Scores Section
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //       child: Row(
          //         children: const [
          //           Text(
          //             'History',
          //             style: TextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //
          //     Expanded(
          //       child: scores.isEmpty
          //           ? const Center(
          //               child: Text('No games played yet'),
          //             )
          //           : ListView.builder(
          //               padding: const EdgeInsets.all(16),
          //               itemCount: scores.length,
          //               itemBuilder: (context, index) {
          //                 final score = scores[index];
          //                 return Card(
          //                   margin: const EdgeInsets.only(bottom: 8),
          //                   child: ListTile(
          //                     leading: CircleAvatar(
          //                       child: Text('${index + 1}'),
          //                     ),
          //                     title: Text('Moves: ${score.moves}'),
          //                     subtitle: Text(
          //                       'Time: ${score.timeInSeconds ~/ 60}m ${score.timeInSeconds % 60}s\n'
          //                       '${score.timestamp.toString().split('.')[0]}',
          //                     ),
          //                   ),
          //                 );
          //               },
          //             ),
          //     ),
          //   ],
          // );

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
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
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
