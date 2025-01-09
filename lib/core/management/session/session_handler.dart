import 'package:memmatch/core/constants/app_constants.dart';
import 'package:memmatch/core/network/repository/base_repository.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/core/repositories/local_storage_repository.dart';


class SessionHandler {

  static var accessToken = "";
  static var appSource = "WEB";
  static var userIp = "0.0.0.0";
  static var apiVersion = "v1";

  static String expiresIn = "0";

  static String refreshToken = "";

  // static User? user;

  static void clear() {
    accessToken = "";
    userIp = "0.0.0.0";
    expiresIn = "0";
    refreshToken = "";
    // user = null;
  }

  final Duration _gracePeriod = const Duration(minutes: 5);




}
