import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/core/constants/app_constants.dart';
import 'package:memmatch/modules/home/models/score_model.dart';
import 'history_state.dart';
import '../../../core/repositories/local_storage_repository.dart';

class HistoryBloc extends Cubit<AppState> {
  final LocalStorageRepository storageRepository;

  HistoryBloc({required this.storageRepository}) : super(HistoryInitial());

  void loadHistory() async {
    emit(HistoryLoading());
    try {
      final response = await storageRepository.getDocument(AppConstants.SCORES_KEY);
      if (response.payload?['data'] != null) {
        final List scoresList = response.payload!['data'] as List;
        final scores = scoresList.map((e) => Score.fromJson(e)).toList();
        emit(HistoryLoaded(scores));
      } else {
        emit(HistoryLoaded([]));
      }
    } catch (e) {
      emit(HistoryError('Failed to load history'));
    }
  }
}
