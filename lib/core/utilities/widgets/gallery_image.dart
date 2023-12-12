import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class GalleryImage extends StatelessWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final bool? isPhoto;
  final Function() onTap;

  const GalleryImage(
      {Key? key,
      required this.imagePath,
      required this.height,
      required this.width,
      required this.isPhoto,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: isPhoto!
            ? CachedNetworkImage(
                height: height,
                width: width,
                placeholder: (context, url) => Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(color: Palette.primaryColor))),
                errorWidget: (context, url, error) => Icon(Icons.error, size: 30.0,color: Colors.red),
                fit: BoxFit.cover,
                imageUrl: imagePath ?? '',
                imageBuilder: (context, imageProvider) {
                  return GestureDetector(
                      onTap: onTap,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover))));
                },
              )
            : GestureDetector(
                onTap: onTap,
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Palette.primaryColor),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Icon(
                    Icons.add,
                    size: 30.0,
                    color: Palette.primaryColor,
                  ),
                ),
              ));
  }
}
