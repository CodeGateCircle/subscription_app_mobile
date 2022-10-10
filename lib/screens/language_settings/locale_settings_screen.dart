import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/widgets/input/dropdown_button_widget.dart';

class LanguageSettings extends ConsumerWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: AppColor.black,
        ),
        title: Text(
          AppLocalizations.of(context)!.localeSettings,
          style: Theme.of(context).textTheme.headline2,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButtonWidget<Locale>(
              labelText: AppLocalizations.of(context)!.localeSettings,
              dropdownValue: ref.watch(localeProvider),
              dropdownMenuItems: languageOptions,
              onChanged: (Locale value) {
                ref.read(localeProvider.notifier).state = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
