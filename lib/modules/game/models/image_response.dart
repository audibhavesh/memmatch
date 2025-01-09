// lib/data/image_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {
  @JsonKey(name: "download_url")
  final String? downloadUrl;

  final String? id;

  ImageResponse({this.id, this.downloadUrl});

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
