import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memmatch/core/bloc/app_event.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/core/management/theme/bloc/theme_event.dart';
import 'package:memmatch/core/management/theme/bloc/theme_state.dart';
import 'package:memmatch/core/management/theme/theme_manager.dart';

class ThemeBloc extends Bloc<AppEvent, AppState> {
  ThemeBloc() : super(ThemeState()) {
    on<ThemeEvent>(_handleThemeEvent);
  }

  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {}

  _handleThemeEvent(ThemeEvent event, Emitter<AppState> emit) {
    ThemeManager.mode = event.mode;
    emit(ThemeState());
  }
}
