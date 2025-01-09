import 'package:memmatch/core/package_loader/load_modules.dart';

class LocalDBResponse {
  AppResponseType? type;
  String? message;
  dynamic payload;

  LocalDBResponse({this.type, this.message, this.payload});

  bool isError() {
    return type == AppResponseType.error || type == AppResponseType.failed;
  }

  bool isSuccess() {
    return type == AppResponseType.success;
  }
}
