import 'package:memmatch/core/exceptions/app_exception.dart';
import 'package:flutter/material.dart';

class AppState{
  List<Object> get props => [];
}

class LoadingState extends AppState {
  final bool isLoading;

  LoadingState({required this.isLoading});
}

class SuccessState extends AppState {}

class ErrorState extends AppState {
  final String message;

  ErrorState(this.message);
}

class FailedState extends AppState {
  final AppException appException;

  FailedState(this.appException);
}

class ValidationErrorState extends AppState {
  final String message;

  ValidationErrorState(this.message);
}
