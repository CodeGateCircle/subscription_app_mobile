import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/features/app_bottom_navigation_bar.dartapp_bottom_navigation_bar/app_bottom_navigation_bar.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/account/account.entity.dart';
import 'package:subscription_app_web/modules/account/account.service.dart';
import 'package:subscription_app_web/modules/account/account.store.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/widgets/input/dropdown_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends ConsumerState<SignUp> {
  Language language = Language.Japanese;
  Currency currency = Currency.JPY;

  @override
  Widget build(BuildContext context) {
    final languageOptions = [
      DropdownMenuItem(
        value: const Locale("ja"),
        child: Text(
          AppLocalizations.of(context)!.japanese,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      DropdownMenuItem(
        value: const Locale("en"),
        child: Text(
          AppLocalizations.of(context)!.english,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ];

    final currencyOptions = [
      DropdownMenuItem(
        value: Currency.JPY,
        child: Text(
          AppLocalizations.of(context)!.jpy,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      DropdownMenuItem(
        value: Currency.USD,
        child: Text(
          AppLocalizations.of(context)!.usd,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ];

    Future _signUp() async {
      try {
        final res = await AccountService.signUp(language, currency);
        ref.read(currentUserProvider.notifier).state = res;
      } catch (e) {
        logger.e(e);
      } finally {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AppBottomNavigationBar(),
          ),
        );
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              color: AppColor.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "images/sign-up-img.svg",
                    color: AppColor.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      AppLocalizations.of(context)!.signUpTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: AppColor.white,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      DropdownButtonWidget<Locale>(
                        labelText: AppLocalizations.of(context)!.localeSettings,
                        dropdownValue: ref.watch(localeProvider),
                        dropdownMenuItems: languageOptions,
                        onChanged: (Locale value) {
                          ref.read(localeProvider.notifier).state = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonWidget<Currency>(
                        labelText:
                            AppLocalizations.of(context)!.currencySettings,
                        dropdownValue: currency,
                        dropdownMenuItems: currencyOptions,
                        onChanged: (Currency value) {
                          setState(() {
                            currency = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Button(
                        variant: Variant.solid,
                        text: AppLocalizations.of(context)!.start,
                        color: Colors.black,
                        onPressed: _signUp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
