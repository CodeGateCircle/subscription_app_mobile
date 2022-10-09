import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/search_result/search_result.entity.dart';
import 'package:subscription_app_web/screens/create_subscription/create_subscription_screen.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/widgets/subscription_icon_img.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key? key,
    required this.searchResults,
  }) : super(key: key);

  final List<SearchResult> searchResults;

  Widget _buildResultCard(BuildContext context, SearchResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SubscriptionIconImage(
                iconImageUrl: result.imageUrl,
              ),
              const SizedBox(width: 8),
              Text(
                result.name,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Button(
            variant: Variant.solid,
            text: AppLocalizations.of(context)!.addSubscription,
            size: 68,
            color: const Color.fromRGBO(203, 194, 189, 1),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateSubscription(
                    name: result.name,
                    price: result.price,
                    // defaultImageUrl: result.imageUrl,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _buildResultCard(
                context,
                searchResults[index],
              ),
            ],
          );
        },
      ),
    );
  }
}
