import 'package:memmatch/core/package_loader/load_modules.dart';

class AppException implements Exception {
  AppResponseType error;
  String? message = "";
  dynamic extra = {};

  AppException(this.error, this.message, {this.extra});
  @override
  String toString() {
    // TODO: implement toString
    return "APP EXCEPTION (Error=$error,message=$message,extra=$extra)";
  }
}
