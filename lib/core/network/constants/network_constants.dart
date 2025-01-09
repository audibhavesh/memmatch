class NetworkConstants {
  static var baseUrl = "https://picsum.photos/v2";

  static var CONNECTION_TIMEOUT = const Duration(minutes: 1);
  static var READ_TIMEOUT = const Duration(minutes: 1);
  static var WRITE_TIMEOUT = const Duration(minutes: 1);

  // DEV env
  static const devBaseUrl = "https://picsum.photos/v2";

  static bool isDevelopmentBaseUrl() {
    if (baseUrl == devBaseUrl) {
      return true;
    } else {
      return false;
    }
  }
}
