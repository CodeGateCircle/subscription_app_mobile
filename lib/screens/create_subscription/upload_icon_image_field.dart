import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadIconImageField extends StatelessWidget {
  const UploadIconImageField({
    Key? key,
    required this.iconImage,
    required this.onTapIconImage,
  }) : super(key: key);

  final XFile iconImage;
  final void Function() onTapIconImage;

  final double imageSize = 96;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTapIconImage,
          child: iconImage.path != ""
              ? CircleAvatar(
                  radius: imageSize / 2,
                  backgroundImage: Image.file(File(iconImage.path)).image,
                )
              : Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color.fromRGBO(240, 237, 235, 1),
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Icon(
                    Icons.image,
                    size: imageSize / 2,
                    color: const Color.fromRGBO(17, 17, 17, 0.25),
                  ),
                ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
