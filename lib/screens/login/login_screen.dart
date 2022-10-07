import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/modules/account/account.entity.dart';
import 'package:subscription_app_web/modules/account/account.service.dart';
import 'package:subscription_app_web/screens/home/home_screen.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/widgets/dropdown_button_widget.dart';

// env
class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  Language language = Language.Japanese;
  Currency currency = Currency.JPY;

  Widget _buildOptionText(BuildContext context, String textValue) {
    return Text(
      textValue,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageOptions = [
      DropdownMenuItem(
        value: Language.Japanese,
        child: _buildOptionText(context, "日本語"),
      ),
      DropdownMenuItem(
        value: Language.English,
        child: _buildOptionText(context, "英語"),
      ),
    ];

    final currencyOptions = [
      DropdownMenuItem(
        value: Currency.JPY,
        child: _buildOptionText(context, "Japanese Yen（JPY）"),
      ),
      DropdownMenuItem(
        value: Currency.USD,
        child: _buildOptionText(context, "US Dollar（USD）"),
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "サブスクアプリへようこそ👋",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            DropdownButtonWidget<Language>(
              labelText: "言語設定",
              dropdownValue: language,
              dropdownMenuItems: languageOptions,
              onChanged: (Language value) {
                setState(() {
                  language = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonWidget<Currency>(
              labelText: "通貨設定",
              dropdownValue: currency,
              dropdownMenuItems: currencyOptions,
              onChanged: (Currency value) {
                setState(() {
                  currency = value;
                });
              },
            ),
            const SizedBox(height: 30),
            Button(
              variant: Variant.solid,
              text: "管理スタート",
              color: Colors.black,
              onPressed: () {
                AccountService.login(language, currency);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
