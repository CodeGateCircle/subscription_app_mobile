import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/screens/language_settings/locale_settings_screen.dart';
import 'settings_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Widget _buildSettingList(BuildContext context, Widget? settings) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: AppColor.white,
      ),
      child: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64),
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
      ),
      width: double.infinity,
      child: Column(
        children: [
          _buildSettingList(
            context,
            Column(
              children: [
                SettingsItem(
                  title: AppLocalizations.of(context)!.currencySettings,
                  onTap: () {},
                ),
                SettingsItem(
                  title: AppLocalizations.of(context)!.localeSettings,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LanguageSettings(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingList(
            context,
            Column(
              children: [
                SettingsItem(
                  title: AppLocalizations.of(context)!.termsOfUse,
                  onTap: () {},
                ),
                SettingsItem(
                  title: AppLocalizations.of(context)!.privacyPolicy,
                  onTap: () {},
                ),
                SettingsItem(
                  title: AppLocalizations.of(context)!.contactUs,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingList(
            context,
            SettingsItem(
              title: AppLocalizations.of(context)!.about,
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
