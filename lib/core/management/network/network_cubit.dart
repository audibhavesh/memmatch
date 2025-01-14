// Dart imports:
import 'dart:async';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:memmatch/core/bloc/app_state.dart';
import 'package:memmatch/core/management/network/network_state.dart';

class InternetCubit extends Cubit<AppState> {
  late StreamSubscription<InternetConnectionStatus>? _subscription;

  late InternetConnectionChecker? _checker;

  InternetCubit() : super(NetworkInitialState()) {
    _checker = InternetConnectionChecker.instance;
    _subscription = _checker?.onStatusChange.listen((status) {
      // emit(status);
      if (status == InternetConnectionStatus.slow) {
        emit(NetworkSlowState());
      } else if (status == InternetConnectionStatus.disconnected) {
        emit(NetworkDisconnectedState());
      } else {
        emit(NetworkConnectedState());
      }
    });
  }

  void establishStream() async {
    await _subscription?.cancel();
    _checker?.dispose();

    _subscription = null;
    _checker = null;
    _checker = InternetConnectionChecker.instance;
    _subscription = _checker?.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.slow) {
        emit(NetworkSlowState());
      } else if (status == InternetConnectionStatus.disconnected) {
        emit(NetworkDisconnectedState());
      } else {
        emit(NetworkConnectedState());
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _checker?.dispose(); // Dispose of the InternetConnectionChecker instance
    return super.close();
  }
}
