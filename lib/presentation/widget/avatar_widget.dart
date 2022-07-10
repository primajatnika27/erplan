import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const AvatarWidget({
    Key? key,
    required this.imageUrl,
    this.radius = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, image) => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        backgroundImage: image,
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            strokeWidth: 1,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
