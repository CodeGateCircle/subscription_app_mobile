import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:subscription_app_web/config/app_color.dart';

class TotalAmount extends StatefulWidget {
  const TotalAmount({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  final double totalAmount;

  @override
  State<TotalAmount> createState() => _TotalAmountState();
}

class _TotalAmountState extends State<TotalAmount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 33),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 33),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  AppLocalizations.of(context)!.totalAmount,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AppColor.white,
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "¥",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 38,
                    child: Text(
                      NumberFormat().format(widget.totalAmount),
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 42,
                            fontFamily: "Metropolis",
                          ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "/ ${AppLocalizations.of(context)!.monthly}",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
