import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/lib/debouncer.dart';
import 'package:subscription_app_web/modules/search_result/search_result.entity.dart';
import 'package:subscription_app_web/modules/search_result/search_result.repository.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    Key? key,
    required this.setSearchResult,
  }) : super(key: key);

  final void Function(List<SearchResult>) setSearchResult;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final debouncer = Debouncer(milliseconds: 500);
  String inputValue = "";

  void _changeInputValue(String value) async {
    Future search() async {
      final res = await SearchResultRepository.get(value);
      widget.setSearchResult(res.data.result);
    }

    setState(() {
      inputValue = value;
    });
    debouncer.run(() {
      search();
    });
    if (inputValue == "") widget.setSearchResult([]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: (value) => _changeInputValue(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(14, 10, 0, 10),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColor.black,
          ),
          hintText:
              AppLocalizations.of(context)!.searchApplicationInputPlaceHolder,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColor.gray,
              ),
          filled: true,
          fillColor: AppColor.border,
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
