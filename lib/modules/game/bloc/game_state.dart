import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/modules/home/models/score_model.dart';

class GameInitial extends AppState {}

class GameImagesLoading extends AppState {}

class GameImagesLoaded extends AppState {
  final List<String>? images;

  GameImagesLoaded(this.images);
}

class GameError extends AppState {
  final String message;

  GameError(this.message);
}

class GameCompleted extends AppState {
  final Score score;

  GameCompleted(this.score);
}

class LevelCompleted extends AppState {
  int level = 0;

  LevelCompleted(this.level);
}

class CurrentLevelFetched extends AppState {
  int level = 0;

  CurrentLevelFetched(this.level);
}

class LevelError extends AppState {
  final String message;

  LevelError(this.message);
}
