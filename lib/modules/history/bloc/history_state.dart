import 'package:memmatch/core/bloc/app_state.dart';

import '../../home/models/score_model.dart';

class HistoryInitial extends AppState {}

class HistoryLoading extends AppState {}

class HistoryLoaded extends AppState {
  final List<Score> scores;

  HistoryLoaded(this.scores);

  List<Object> get props => [scores];
}

class HistoryError extends AppState {
  final String message;

  HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
