import 'dart:async';

import 'package:memmatch/injector.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/game/bloc/game_bloc.dart';
import 'package:memmatch/modules/game/bloc/game_state.dart';
import 'package:memmatch/modules/game/views/memory_grid.dart';
import 'package:memmatch/modules/home/models/level_config.dart';

class GameScreen extends StatefulWidget {
  final LevelConfig levelConfig;

  const GameScreen({super.key, required this.levelConfig});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Timer _timer;
  int _timeRemaining = 0;
  bool _isTimeUp = false;

  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().startGame(widget.levelConfig.numCards);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timeRemaining = widget.levelConfig.timeLimit;
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else if (!_isTimeUp) {
          _isTimeUp = true;
          _timer.cancel();
          _showTimeUpDialog();
        }
      });
    });
  }

  void _showTimeUpDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) => AlertDialog(
              title: const Text('Time\'s Up! ⏰'),
              content: const Text('You ran out of time. Try again!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back to Levels'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context
                        .read<GameBloc>()
                        .startGame(widget.levelConfig.numCards);
                    setState(() {
                      _timeRemaining = widget.levelConfig.timeLimit;
                      _isTimeUp = false;
                      _startTimer();
                    });
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${widget.levelConfig.level}'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined),
                  const SizedBox(width: 4),
                  Text(
                    '${_timeRemaining ~/ 60}:${(_timeRemaining % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Level Progress Indicator
          LinearProgressIndicator(
            value: _timeRemaining / widget.levelConfig.timeLimit,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              _timeRemaining < widget.levelConfig.timeLimit * 0.3
                  ? Colors.red
                  : Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: BlocConsumer<GameBloc, AppState>(
              listener: (buildContext, state) {
                if (state is GameCompleted) {
                  _timer.cancel();
                  final timeSpent =
                      widget.levelConfig.timeLimit - _timeRemaining;
                  Future.delayed(
                    Duration(milliseconds: 500),
                    () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: Text(
                            state.score.moves <=
                                    widget.levelConfig.requiredMoves
                                ? 'Level Complete! 🎉'
                                : 'Level Finished',
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Moves: ${state.score.moves}'),
                              Text(
                                'Time: ${timeSpent ~/ 60}m ${timeSpent % 60}s',
                              ),
                              if (state.score.moves <=
                                  widget.levelConfig.requiredMoves)
                                const Text(
                                  '\nCongratulations! You\'ve unlocked the next level!',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              else
                                Text(
                                  '\nTry to complete in ${widget.levelConfig.requiredMoves} moves to unlock the next level.',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Back to Levels'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                buildContext
                                    .read<GameBloc>()
                                    .startGame(widget.levelConfig.numCards);
                                setState(() {
                                  _timeRemaining = widget.levelConfig.timeLimit;
                                  _startTimer();
                                });
                              },
                              child: const Text('Play Again'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is GameImagesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is GameImagesLoaded) {
                  return MemoryGrid(
                    images: state.images,
                    levelConfig: widget.levelConfig,
                    onGameComplete: (moves) {
                      context.read<GameBloc>().onGameComplete(
                            moves,
                            widget.levelConfig.level,
                            widget.levelConfig.timeLimit - _timeRemaining,
                          );
                    },
                    restartGame: () {
                      context
                          .read<GameBloc>()
                          .startGame(widget.levelConfig.numCards);
                      setState(() {
                        _timeRemaining = widget.levelConfig.timeLimit;
                        _isTimeUp = false;
                        _startTimer();
                      });
                    },
                  );
                }

                if (state is GameError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<GameBloc>()
                                .startGame(widget.levelConfig.numCards);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return BlocProvider(
//     create: (context) => getIt.get<GameBloc>()..startGame(),
//     child: Scaffold(
//       appBar: AppBar(
//         title: const Text('Memory Match'),
//         elevation: 0,
//       ),
//       body: BlocConsumer<GameBloc, AppState>(
//         listener: (buildContext, state) {
//           if (state is GameCompleted) {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (context) => AlertDialog(
//                 title: const Text('Congratulations! 🎉'),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Moves: ${state.score.moves}'),
//                     Text(
//                       'Time: ${state.score.timeInSeconds ~/ 60}m ${state.score.timeInSeconds % 60}s',
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('Back to Home'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       buildContext.read<GameBloc>().startGame();
//                     },
//                     child: const Text('Play Again'),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is GameImagesLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state is GameImagesLoaded) {
//             return MemoryGrid(
//               images: state.images,
//               onGameComplete: (moves) {
//                 context.read<GameBloc>().onGameComplete(moves);
//               },
//               restartGame: () {
//                 context.read<GameBloc>().startGame();
//               },
//               levelConfig: widget.levelConfig,
//             );
//           }
//
//           if (state is GameError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(state.message),
//                   ElevatedButton(
//                     onPressed: () {
//                       // context.read<GameBloc>().getImages();
//                       context.read<GameBloc>().startGame();
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return const SizedBox();
//         },
//       ),
//     ),
//   );
// }
}
