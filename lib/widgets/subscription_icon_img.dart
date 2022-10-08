import 'package:flutter/material.dart';

class SubscriptionIconImage extends StatefulWidget {
  const SubscriptionIconImage({
    Key? key,
    required this.iconImageUrl,
    this.iconSize = 56,
  }) : super(key: key);

  final String? iconImageUrl;
  final double? iconSize;

  @override
  State<SubscriptionIconImage> createState() => _SubscriptionIconImageState();
}

class _SubscriptionIconImageState extends State<SubscriptionIconImage> {
  @override
  Widget build(BuildContext context) {
    final double defaultIconSize = widget.iconSize! / 2;

    return widget.iconImageUrl != null &&
            widget.iconImageUrl!.startsWith('http')
        ? CircleAvatar(
            radius: widget.iconSize,
            backgroundImage: NetworkImage(widget.iconImageUrl!),
          )
        : Container(
            width: widget.iconSize,
            height: widget.iconSize,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Icon(
              Icons.image,
              size: defaultIconSize,
              color: const Color.fromRGBO(17, 17, 17, 0.25),
            ),
          );
  }
}
