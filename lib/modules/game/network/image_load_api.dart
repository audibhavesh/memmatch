import 'package:dio/dio.dart';
import 'package:memmatch/modules/game/models/image_response.dart';
import 'package:retrofit/retrofit.dart';

part 'image_load_api.g.dart';

@RestApi()
abstract class ImageLoadApi {
  factory ImageLoadApi(Dio dio, {String baseUrl}) = _ImageLoadApi;

  @GET('/list')
  Future<List<ImageResponse>?> getImages(
      {@Query('page') int page = 1, @Query('limit') int limit = 4});
}
