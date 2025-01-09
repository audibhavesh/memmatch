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

  void startGame() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
    getImages();
  }

  void getImages() async {
    emit(GameImagesLoading());
    try {
      final images = await imageLoadRepository.getImages();
      emit(GameImagesLoaded(images?.map((e) => e.downloadUrl ?? "").toList()));
    } catch (e) {
      print(e);
      emit(GameError('Failed to load images'));
    }
  }

  void onGameComplete(int moves) {
    final endTime = DateTime.now().millisecondsSinceEpoch;
    final timeInSeconds = (endTime - _startTime) ~/ 1000;

    final score = Score(
      moves: moves,
      timeInSeconds: timeInSeconds,
      timestamp: DateTime.now(),
    );

    homeBloc.saveScore(score);
    emit(GameCompleted(score));
  }
}