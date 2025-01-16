import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:memmatch/core/management/cache/file_prefetcher.dart';
import 'package:memmatch/core/management/network/network_cubit.dart';
import 'package:memmatch/core/management/network/network_state.dart';
import 'package:memmatch/core/types/message_view_type.dart';
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
  Timer? _timer;
  int _timeRemaining = 0;
  bool _isTimeUp = false;

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().startGame(widget.levelConfig.numCards);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _timeRemaining = widget.levelConfig.timeLimit;
    //   _startTimer();
    // });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeRemaining > 0) {
            _timeRemaining--;
          } else if (!_isTimeUp) {
            _isTimeUp = true;
            _timer?.cancel();
            _showTimeUpDialog();
          }
        });
      }
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
    _timer?.cancel();
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
      body: BlocListener<InternetCubit, AppState>(
        listener: (context, state) {
          if (state is NetworkConnectedState) {
            if (images.isEmpty) {
              context.read<GameBloc>().startGame(widget.levelConfig.numCards);
            }
          }
          if (state is NetworkDisconnectedState) {
            UiWidgets.showAppMessages(
                context,
                AppResponseType.internetNotConnected,
                ErrorMessages.noInternetConnection,
                messageViewType: MessageViewType.snackBar);
          }
          if (state is NetworkSlowState) {
            UiWidgets.showAppMessages(context, AppResponseType.error,
                ErrorMessages.slowInternetConnection,
                messageViewType: MessageViewType.snackBar);
          }
        },
        child: Column(
          children: [
            // Level Progress Indicator
            LinearProgressIndicator(
              value: _timeRemaining / widget.levelConfig.timeLimit,
              // backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                _timeRemaining < widget.levelConfig.timeLimit * 0.3
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: BlocConsumer<GameBloc, AppState>(
                listener: (buildContext, state) {
                  if (state is GameCompleted) {
                    _timer?.cancel();
                    final timeSpent =
                        widget.levelConfig.timeLimit - _timeRemaining;
                    Future.delayed(
                      Duration(milliseconds: 500),
                      () {
                        if (mounted) {
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
                                      _timeRemaining =
                                          widget.levelConfig.timeLimit;
                                      _startTimer();
                                    });
                                  },
                                  child: const Text('Play Again'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  }
                  if (state is GameImagesLoaded) {
                    images = state.images ?? [];
                    // ImagePreFetcher.prefetchImages(state.images ?? []);
                    ImagePreFetcher.prefetchImages(context,images)
                        .then((_) {
                      // Optional: You can handle completion here if needed
                      print('Images prefetching completed');
                    }).catchError((error) {
                      print('Error during prefetching: $error');
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _timeRemaining = widget.levelConfig.timeLimit;
                      _startTimer();
                    });
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
                            widget.levelConfig.requiredMoves);
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
      ),
    );
  }
}
