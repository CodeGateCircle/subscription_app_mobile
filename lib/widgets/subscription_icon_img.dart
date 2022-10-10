import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subscription_app_web/config/app_color.dart';

class SubscriptionIconImage extends StatefulWidget {
  const SubscriptionIconImage({
    Key? key,
    required this.iconImageUrl,
    this.iconSize = 56,
    this.borderRadius = 16,
  }) : super(key: key);

  final String? iconImageUrl;
  final double? iconSize;
  final double? borderRadius;

  @override
  State<SubscriptionIconImage> createState() => _SubscriptionIconImageState();
}

class _SubscriptionIconImageState extends State<SubscriptionIconImage> {
  @override
  Widget build(BuildContext context) {
    final double defaultIconSize = widget.iconSize! / 2;

    return widget.iconImageUrl != null &&
            widget.iconImageUrl!.startsWith('https')
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColor.lightGray,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              child: Image.network(
                widget.iconImageUrl!,
                width: widget.iconSize,
                height: widget.iconSize,
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: widget.iconSize,
            height: widget.iconSize,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColor.lightGray,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: SvgPicture.asset(
              "images/icons/image-outline.svg",
              fit: BoxFit.fitWidth,
              color: AppColor.gray,
            ),
          );
  }
}
