import 'package:memmatch/core/exceptions/app_exception.dart';
import 'package:memmatch/core/helpers/api_helper.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/game/models/image_response.dart';
import 'package:memmatch/modules/game/network/image_load_api.dart';

import '../../../core/repositories/local_storage_repository.dart';

class ImageLoadRepository {
  ImageLoadApi imageLoadApi;

  ImageLoadRepository(this.imageLoadApi);

  Future<List<ImageResponse>?> getImages(int? limit) async {
    return handleApiRequest(() async {
      var response = await imageLoadApi.getImages(limit: limit ?? 4);
      print("IMAGESSSSSSS $response");
      if (response != null) {
        if (response.isNotEmpty) {
          return response;
        } else {
          throw AppException(AppResponseType.dataNotFound, "Not found");
        }
      } else {
        throw AppException(AppResponseType.failed, "Failed");
      }
    });
  }
}
