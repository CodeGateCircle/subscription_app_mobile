import 'package:flutter/material.dart';

class AddSubscription extends StatefulWidget {
  const AddSubscription({Key? key}) : super(key: key);

  @override
  State<AddSubscription> createState() => _AddSubscriptionState();
}

class _AddSubscriptionState extends State<AddSubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
