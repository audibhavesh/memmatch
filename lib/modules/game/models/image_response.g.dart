// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) =>
    ImageResponse(
      id: json['id'] as String?,
      downloadUrl: json['download_url'] as String?,
    );

Map<String, dynamic> _$ImageResponseToJson(ImageResponse instance) =>
    <String, dynamic>{
      'download_url': instance.downloadUrl,
      'id': instance.id,
    };
