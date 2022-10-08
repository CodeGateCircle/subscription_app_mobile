import 'package:flutter/material.dart';
import 'package:subscription_app_web/screens/language_settings/locale_settings_screen.dart';
import 'settings_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Widget _buildSettingList(BuildContext context, Widget? settings) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(197, 198, 199, 0.5),
      ),
      width: double.infinity,
      child: Column(
        children: [
          _buildSettingList(
            context,
            Column(
              children: [
                SettingsItem(
                  title: "通貨の設定",
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
                SettingsItem(
                  title: "テーマ選択",
                  onTap: () {},
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
                  title: "利用規約",
                  onTap: () {},
                ),
                SettingsItem(
                  title: "プライパシーポリシー",
                  onTap: () {},
                ),
                SettingsItem(
                  title: "お問い合わせ",
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingList(
            context,
            SettingsItem(
              title: "このアプリについて",
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
