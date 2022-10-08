import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  String inputValue = "";

  void _changeInputValue(String value) {
    // TODO: apiを使用した検索をかける処理を実装
    setState(() {
      inputValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        onChanged: (value) => _changeInputValue(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(14, 10, 0, 10),
          hintText:
              AppLocalizations.of(context)!.searchApplicationInputPlaceHolder,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: const Color.fromRGBO(240, 237, 235, 1),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(999),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(999),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
