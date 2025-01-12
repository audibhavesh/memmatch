import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/core/constants/app_constants.dart';
import 'package:memmatch/core/management/theme/bloc/theme_state.dart';
import 'package:memmatch/core/management/theme/theme_manager.dart';
import 'package:memmatch/core/repositories/local_storage_repository.dart';

class ThemeBloc extends Cubit<AppState> {
  LocalStorageRepository localStorageRepository;

  ThemeBloc(this.localStorageRepository) : super(ThemeInitialState());

  void handleThemeEvent(ThemeMode themeMode) async {
    ThemeManager.mode = themeMode;
    try {
      await localStorageRepository.save(AppConstants.CURRENT_THEME, themeMode);
      emit(ThemeState());
    } catch (e) {
      emit(ThemeState());
    }
  }

  void loadLocalTheme() async {
    try {
      var response =
          await localStorageRepository.getDocument(AppConstants.CURRENT_THEME);
      if (response.payload?['data'] != null) {
        final ThemeMode themeMode = response.payload!['data'] as ThemeMode;
        ThemeManager.mode = themeMode;
        emit(ThemeState());
      }
    } catch (e) {
      emit(ThemeState());
    }
  }
}
