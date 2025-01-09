import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/modules/game/models/image_response.dart';

import '../models/score_model.dart';

class MemoryMatchInitial extends AppState {}

class ImagesLoading extends AppState {}

class ImagesLoaded extends AppState {
  final List<String>? images;

  ImagesLoaded(this.images);
}

class ImagesError extends AppState {
  final String message;

  ImagesError(this.message);
}

class ScoresLoaded extends AppState {
  final List<Score> scores;
  ScoresLoaded(this.scores);
}