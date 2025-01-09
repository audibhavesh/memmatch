import 'package:memmatch/core/bloc/app_state.dart';

import '../models/score_model.dart';

class MemoryMatchInitial extends AppState {}


class ImagesError extends AppState {
  final String message;

  ImagesError(this.message);
}

class ScoresLoaded extends AppState {
  final List<Score> scores;

  ScoresLoaded(this.scores);
}

class LevelLoaded extends AppState {
  final int level;

  LevelLoaded(this.level);
}
