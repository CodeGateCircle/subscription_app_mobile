import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TotalAmount extends StatefulWidget {
  const TotalAmount({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  final int totalAmount;

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
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  AppLocalizations.of(context)!.totalAmount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¥"),
                  const SizedBox(width: 10),
                  Text(
                    widget.totalAmount.toString(),
                    style: const TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // TODO: 月/年表示をミュータブルにする
                  const Text("/月"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
