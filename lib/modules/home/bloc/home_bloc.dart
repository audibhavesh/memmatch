import 'package:bloc/bloc.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/core/constants/app_constants.dart';
import 'package:memmatch/core/repositories/local_storage_repository.dart';
import 'package:memmatch/modules/home/bloc/home_state.dart';
import 'package:memmatch/modules/game/respository/image_load_repository.dart';

import '../models/score_model.dart';

class HomeBloc extends Cubit<AppState> {
  final ImageLoadRepository imageLoadRepository;

  final LocalStorageRepository storageRepository;

  var alreadyInserted=false;
  HomeBloc({required this.imageLoadRepository, required this.storageRepository})
      : super(MemoryMatchInitial());

  void getImages() async {
    emit(ImagesLoading());
    try {
      final images = await imageLoadRepository.getImages();
      // emit(ImagesLoaded(images));
      emit(ImagesLoaded(images?.map((e) => e.downloadUrl ?? "").toList()));
    } catch (e) {
      print(e);
      emit(ImagesError('Failed to load images'));
    }
  }

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
        var scores= scoresList.map((e) => Score.fromJson(e)).toList();
        emit(ScoresLoaded(scores));
        return scores;
      }else {
        emit(ScoresLoaded([]));
        return [];
      }
    } catch (e) {
      emit(ScoresLoaded([]));
      return [];
    }
  }

}
