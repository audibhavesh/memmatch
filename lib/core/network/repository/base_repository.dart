import 'package:memmatch/core/exceptions/api_exceptions.dart';

import 'package:memmatch/core/network/models/api_response.dart';
import 'package:memmatch/core/network/service/base_api_service.dart';

class BaseRepository {
  BaseApi baseApi;

  BaseRepository(this.baseApi);

  Future<ApiResponse> testDomain() async {
    try {
      var response = await baseApi.testDomain();
      return response.data;
    } on ApiException catch (e, _) {
      throw e.appException();
    } catch (e, _) {
      throw ApiException.otherException(otherException: e).appException();
    }
  }

  Future<String> getPublicIP() async {
    try {
      var response = await baseApi.getPublicIp();
      var ip = response.data ?? "";
      return ip;
    } on ApiException catch (e, _) {
      throw e.appException();
    } catch (e, _) {
      throw ApiException.otherException(otherException: e).appException();
    }
  }
}
