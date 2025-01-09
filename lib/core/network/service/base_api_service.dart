import 'package:memmatch/core/network/models/api_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'base_api_service.g.dart';

@RestApi()
abstract class BaseApi {
  factory BaseApi(Dio dio, {String baseUrl}) = _BaseApi;

  @GET("/")
  Future<HttpResponse<ApiResponse<String>>> testDomain();

  @Headers({
    'Content-Type': 'text/plain',
    'Accept': 'text/plain',
  })
  @GET("https://api.ipify.org/")
  Future<HttpResponse<String>> getPublicIp();
}
