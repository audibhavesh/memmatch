import 'package:bloc/bloc.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/core/constants/app_constants.dart';
import 'package:memmatch/core/repositories/local_storage_repository.dart';
import 'package:memmatch/modules/game/bloc/game_state.dart';
import 'package:memmatch/modules/home/bloc/home_state.dart';
import 'package:memmatch/modules/game/respository/image_load_repository.dart';

import '../models/score_model.dart';

class HomeBloc extends Cubit<AppState> {
  final ImageLoadRepository imageLoadRepository;

  final LocalStorageRepository storageRepository;

  var alreadyInserted = false;

  HomeBloc({required this.imageLoadRepository, required this.storageRepository})
      : super(MemoryMatchInitial());



  Future<void> saveScore(Score score) async {
    try {
      final scores = await loadScores();
      scores.insert(0, score); // Add new score at the beginning
      await storageRepository.save(
          AppConstants.SCORES_KEY, scores.map((e) => e.toJson()).toList());
      emit(ScoresLoaded(scores));
    } catch (e) {
      print(e);
      emit(ImagesError('Failed to save score'));
    }
  }

  Future<List<Score>> loadScores() async {
    try {
      final response =
          await storageRepository.getDocument(AppConstants.SCORES_KEY);
      if (response.payload?['data'] != null) {
        final List scoresList = response.payload!['data'] as List;
        var scores = scoresList.map((e) => Score.fromJson(e)).toList();
        emit(ScoresLoaded(scores));
        return scores;
      } else {
        emit(ScoresLoaded([]));
        return [];
      }
    } catch (e) {
      emit(ScoresLoaded([]));
      return [];
    }
  }

  void saveLevel(int level) async {
    try {
      await storageRepository.save(AppConstants.LEVELS_KEY, level);
      emit(LevelCompleted(level));
    } catch (e) {
      print(e);
      emit(LevelError('Failed to save score'));
    }
  }

  Future<void> loadLevel() async {
    try {
      final response =
          await storageRepository.getDocument(AppConstants.LEVELS_KEY);
      if (response.payload?['data'] != null) {
        final int level = response.payload!['data'] as int;
        emit(LevelLoaded(level));
      } else {
        emit(LevelLoaded(0));
      }
    } catch (e) {
      print(e);
      emit(LevelError('Failed to load level'));
    }
  }
}
