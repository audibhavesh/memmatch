import 'package:dio/dio.dart' hide Headers;
import 'dart:typed_data';
import 'package:retrofit/retrofit.dart';

part 'register_api.g.dart';

@RestApi(baseUrl: "")
abstract class RegisterApi {
  factory RegisterApi(Dio dio, {String baseUrl}) = _RegisterApi;

  // @GET(
  //     'https://github.com/audibhavesh/audibhavesh.github.io/blob/main/images.json')
  @GET(
      'https://raw.githubusercontent.com/audibhavesh/audibhavesh.github.io/refs/heads/main/images.json')
  Future<String?> getAvatarImages();

  @GET("{url}")
  Future<String?> downloadImage(@Path("url") String url);
}
