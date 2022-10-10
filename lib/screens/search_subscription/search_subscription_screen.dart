import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/modules/search_result/search_result.entity.dart';
import 'package:subscription_app_web/screens/search_subscription/search_input.dart';
import 'package:subscription_app_web/screens/create_subscription/create_subscription_screen.dart';
import 'package:subscription_app_web/screens/search_subscription/search_results.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchSubscription extends StatefulWidget {
  const SearchSubscription({Key? key}) : super(key: key);

  @override
  State<SearchSubscription> createState() => _SearchSubscriptionState();
}

class _SearchSubscriptionState extends State<SearchSubscription> {
  List<SearchResult> searchResult = [];

  void setSearchResult(List<SearchResult> values) {
    setState(() {
      searchResult = values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            color: AppColor.black,
          ),
          actions: [
            Button(
              variant: Variant.solid,
              text: AppLocalizations.of(context)!.newSubscription,
              size: 90,
              color: AppColor.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateSubscription(),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 20,
        ),
        body: Column(
          children: [
            SearchInput(
              setSearchResult: setSearchResult,
            ),
            SearchResults(
              searchResults: searchResult,
            ),
          ],
        ),
      ),
    );
  }
}
