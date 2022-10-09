import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "¥",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Metropolis",
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 38,
                    child: Text(
                      NumberFormat().format(widget.totalAmount),
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Metropolis",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "/ ${AppLocalizations.of(context)!.monthly}",
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Metropolis",
                    ),
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
