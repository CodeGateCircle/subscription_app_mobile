import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionIconImage extends StatefulWidget {
  const SubscriptionIconImage({
    Key? key,
    required this.subscription,
    this.iconSize,
  }) : super(key: key);

  final Subscription subscription;
  final double? iconSize;

  @override
  State<SubscriptionIconImage> createState() => _SubscriptionIconImageState();
}

class _SubscriptionIconImageState extends State<SubscriptionIconImage> {
  final double defaultSize = 56;

  @override
  Widget build(BuildContext context) {
    final double defaultSvgSize =
        widget.iconSize == null ? defaultSize - 20 : widget.iconSize! - 20;

    return widget.subscription.image_url != null &&
            widget.subscription.image_url!.startsWith('http')
        ? CircleAvatar(
            radius: widget.iconSize ?? defaultSize,
            backgroundImage: NetworkImage(widget.subscription.image_url!),
          )
        : Container(
            width: widget.iconSize ?? defaultSize,
            height: widget.iconSize ?? defaultSize,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(999),
            ),
            child: SvgPicture.asset(
              'images/device_mobile.svg',
              semanticsLabel: 'subscription_default_icon',
              width: defaultSvgSize,
              height: defaultSvgSize,
              color: Colors.grey,
            ),
          );
  }
}
