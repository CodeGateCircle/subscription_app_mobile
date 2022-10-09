import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:subscription_app_web/features/sns_app/app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final localeProvider = StateProvider<Locale>(
  (ref) => AppLocalizations.supportedLocales.first,
);

var logger = Logger();
void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = Provider((ref) {
      return ref.watch(localeProvider);
    });

    return MaterialApp(
      title: 'subscription_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(localeProvider),
      home: const SnsApp(),
    );
  }
}
