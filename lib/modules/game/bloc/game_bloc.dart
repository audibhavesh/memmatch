import 'package:bloc/bloc.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/modules/game/respository/image_load_repository.dart';
import 'package:memmatch/modules/home/bloc/home_bloc.dart';
import 'package:memmatch/modules/home/models/score_model.dart';

import 'game_state.dart';

class GameBloc extends Cubit<AppState> {
  final ImageLoadRepository imageLoadRepository;
  final HomeBloc homeBloc;
  int _startTime = 0;

  GameBloc({
    required this.imageLoadRepository,
    required this.homeBloc,
  }) : super(GameInitial());

  void startGame(int numCards) {
    _startTime = DateTime.now().millisecondsSinceEpoch;
    getImages(numCards);
  }

  Future<void> getImages(int numCards) async {
    // if (isClosed) return; // Prevent emitting states if Bloc is closed
    emit(GameImagesLoading());
    try {
      final images =
          await imageLoadRepository.getImages((numCards / 2).toInt());
      emit(GameImagesLoaded(images?.map((e) => e.downloadUrl ?? "").toList()));
    } catch (e) {
      print(e);
      if (!isClosed) {
        emit(GameError('Failed to load images'));
      }
    }
  }

  void onGameComplete(int moves, int level, int totalTime, int requiredMoves) {
    final endTime = DateTime.now().millisecondsSinceEpoch;
    final timeInSeconds = (endTime - _startTime) ~/ 1000;

    final score = Score(
        moves: moves,
        timeInSeconds: timeInSeconds,
        timestamp: DateTime.now(),
        level: level,
        totalTime: totalTime);

    homeBloc.saveScore(score);
    if (moves <= requiredMoves) {
      homeBloc.saveLevel(level);
    }
    emit(GameCompleted(score));
  }
}
