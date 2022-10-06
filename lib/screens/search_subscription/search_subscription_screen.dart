import 'package:flutter/material.dart';

import 'package:subscription_app_web/screens/search_subscription/search_input.dart';
import 'package:subscription_app_web/screens/create_subscription/create_subscription_screen.dart';
import 'package:subscription_app_web/widgets/button.dart';

class SearchSubscription extends StatefulWidget {
  const SearchSubscription({Key? key}) : super(key: key);

  @override
  State<SearchSubscription> createState() => _SearchSubscriptionState();
}

class _SearchSubscriptionState extends State<SearchSubscription> {
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
            color: Colors.black,
          ),
          actions: [
            Button(
              variant: Variant.solid,
              text: "作成",
              size: 90,
              color: Colors.black,
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
          children: const [
            SearchInput(),
          ],
        ),
      ),
    );
  }
}
