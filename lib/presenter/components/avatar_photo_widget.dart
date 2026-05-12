import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarPhotoWidget extends StatelessWidget {
  const AvatarPhotoWidget({
    super.key,
    required this.photoUrl,
    this.height = 55,
    this.width = 55,
  });
  final String photoUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: CachedNetworkImage(
          imageUrl: photoUrl,
          fit: BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/avatar_default.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
