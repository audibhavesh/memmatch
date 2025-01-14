import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:memmatch/injector.dart';

class ImagePreFetcher {
  static String generateCacheKey(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    final id = segments[1]; // 'id' segment
    return 'picsum_$id.jpg'; // Added extension to ensure proper file type
  }

  static Future<void> prefetchImages(List<String> imageUrls) async {
    final defaultManager = getIt.get<DefaultCacheManager>();

    // Use a Set to remove any duplicate URLs
    final uniqueUrls = imageUrls.toSet();

    // Track which URLs we've processed
    final processedUrls = <String>{};

    await Future.wait(
      uniqueUrls.map((url) async {
        // Skip if we've already processed this URL
        if (processedUrls.contains(url)) {
          return;
        }

        final cacheKey = generateCacheKey(url);
        processedUrls.add(url);

        try {
          // Check if file is already cached
          final fileInfo = await defaultManager.getFileFromCache(cacheKey);

          if (fileInfo == null) {
            // Only download if not in cache
            final file = await defaultManager.downloadFile(
              url,
              key: cacheKey,
              force: false,
              // maxAge: const Duration(days: 30), // Keep cache for 30 days
            );
            print(
                'Cached new file: $url with key $cacheKey at ${file.file.path}');
          } else {
            print(
                'Using cached file: $url with key $cacheKey at ${fileInfo.file.path}');
          }
        } catch (error) {
          print('Error caching file $url: $error');
        }
      }),
    );
  }

  // Optional: Method to check if an image is already cached
  static Future<bool> isImageCached(String url) async {
    final defaultManager = getIt.get<DefaultCacheManager>();
    final cacheKey = generateCacheKey(url);
    final fileInfo = await defaultManager.getFileFromCache(cacheKey);
    return fileInfo != null;
  }
}
