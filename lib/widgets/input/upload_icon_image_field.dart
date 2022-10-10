import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/config/app_color.dart';

class UploadIconImageField extends StatelessWidget {
  const UploadIconImageField({
    Key? key,
    required this.onTapIconImage,
    required this.defaultImageUrl,
    this.iconImage,
  }) : super(key: key);

  final XFile? iconImage;
  final String? defaultImageUrl;
  final void Function() onTapIconImage;

  final double imageSize = 96;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTapIconImage,
          child: iconImage != null
              ? CircleAvatar(
                  radius: imageSize / 2,
                  backgroundImage: Image.file(File(iconImage!.path)).image,
                )
              : iconImage == null && defaultImageUrl != null
                  ? CircleAvatar(
                      radius: imageSize / 2,
                      backgroundImage: NetworkImage(defaultImageUrl!),
                    )
                  : Container(
                      width: imageSize,
                      height: imageSize,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColor.border,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SvgPicture.asset(
                        "images/icons/image-outline.svg",
                        color: AppColor.lightGray,
                      ),
                    ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
