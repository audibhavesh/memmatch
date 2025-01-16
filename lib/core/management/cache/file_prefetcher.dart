import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:memmatch/injector.dart';

class ImagePreFetcher {
  static final DefaultCacheManager cacheManager = DefaultCacheManager();
  static final Map<String, bool> _preloadedImages = {};

  static String generateCacheKey(String url) {
    return url.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
  }

  static Future<void> prefetchImages(
      BuildContext context, List<String> imageUrls) async {
    List<Future<void>> prefetchFutures = [];

    for (String url in imageUrls) {
      String cacheKey = generateCacheKey(url);

      if (_preloadedImages[cacheKey] == true) {
        continue; // Skip if already preloaded
      }

      prefetchFutures.add(_prefetchSingleImage(context, url, cacheKey));
    }

    // Wait for all images to be fully loaded
    await Future.wait(prefetchFutures);
    print('All images fully preloaded and decoded');
  }

  static Future<void> _prefetchSingleImage(
      BuildContext context, String url, String cacheKey) async {
    try {
      // First ensure the file is cached
      FileInfo? fileInfo = await cacheManager.getFileFromCache(cacheKey);
      if (fileInfo == null) {
        fileInfo = await cacheManager.downloadFile(url, key: cacheKey);
      }

      // Then precache the image in Flutter's image cache
      await precacheImage(
        CachedNetworkImageProvider(
          url,
          cacheKey: cacheKey,
          cacheManager: cacheManager,
        ),
        context,
      );

      _preloadedImages[cacheKey] = true;
    } catch (e) {
      print('Error prefetching image $url: $e');
      _preloadedImages[cacheKey] = false;
    }
  }

  static bool isImagePreloaded(String url) {
    return _preloadedImages[generateCacheKey(url)] == true;
  }

  static Future<void> clearCache() async {
    await cacheManager.emptyCache();
  }

  static Future<void> clearCachePreloadedImages() async {
    await cacheManager.emptyCache();
    _preloadedImages.clear();
  }
}
