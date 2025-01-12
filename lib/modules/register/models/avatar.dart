import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avatar.g.dart';

@JsonSerializable()
class Avatar {
  final String? imageUrl;
  final int? width;
  final int? height;

  Avatar({required this.imageUrl, required this.width, required this.height});

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
