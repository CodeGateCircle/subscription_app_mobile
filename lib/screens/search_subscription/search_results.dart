import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/search_result/search_result.entity.dart';
import 'package:subscription_app_web/screens/create_subscription/create_subscription_screen.dart';
import 'package:subscription_app_web/widgets/subscription_icon_img.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key? key,
    required this.searchResults,
  }) : super(key: key);

  final List<SearchResult> searchResults;

  Widget _buildResultCard(BuildContext context, SearchResult result) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateSubscription(
              initializeName: result.name,
              initializePrice: result.price,
              // defaultImageUrl: result.imageUrl,
            ),
          ),
        );
      },
      child: Container(
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
                  iconSize: 52,
                ),
                const SizedBox(width: 8),
                Text(
                  result.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            const Icon(Icons.chevron_right, size: 32),
          ],
        ),
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
