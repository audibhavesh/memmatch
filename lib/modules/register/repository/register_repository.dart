import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:memmatch/core/exceptions/app_exception.dart';
import 'package:memmatch/core/helpers/api_helper.dart';
import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/modules/game/models/image_response.dart';
import 'package:memmatch/modules/game/network/image_load_api.dart';
import 'package:memmatch/modules/register/models/avatar.dart';
import 'package:memmatch/modules/register/network/register_api.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/repositories/local_storage_repository.dart';

class RegisterRepository {
  RegisterApi registerApi;

  RegisterRepository(this.registerApi);

  Future<List<Avatar>?> getAvatarImages() async {
    return handleApiRequest(() async {
      var response = await registerApi.getAvatarImages();
      if (response is String) {
        final List<dynamic> jsonData = json.decode(response ?? "[]");
        return jsonData.map((json) => Avatar.fromJson(json)).toList();
      }
      // print("IMAGESSSSSSS $response");
      // if (response != null) {
      //   if (response.isNotEmpty) {
      //     return response;
      //   } else {
      //     throw AppException(AppResponseType.dataNotFound, "Not found");
      //   }
      // } else {
      //   throw AppException(AppResponseType.failed, "Failed");
      // }
    });
  }

  Future<String> downloadAndSaveAvatar(
      String? imageUrl, int selectedIndex) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      throw Exception("Invalid image URL");
    }

    try {
      // Fetch the image as bytes
      final String? imageBytes = await registerApi.downloadImage(imageUrl);
      // final List<int> imageBytes = await registerApi.downloadImage(imageUrl);
      // final Uint8List uint8ImageBytes = Uint8List.fromList(imageBytes);

      // Save the image locally
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = "${directory.path}/avatar_$selectedIndex.svg";

      final file = File(imagePath);
      await file.writeAsString(imageBytes ?? "");
      return imagePath;
    } catch (e) {
      throw Exception("Failed to download image: $e");
    }
  }
}
