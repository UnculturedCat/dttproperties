import 'package:dttproperties/AppManagement/Providers.dart';
import 'package:dttproperties/Icons/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../AppManagement/Shared.dart';

class SearchBar extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    return Container(
      padding: standardPagePadding.copyWith(top: 30, bottom: 20),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textEditingController,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Enter a location",
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: hintColor,
                ),
            filled: true,
            fillColor: inactiveColor,
            prefixIcon: IconButton(
              onPressed: () => FocusScope.of(context).unfocus(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      ref.read(searchQueryProvider.notifier).state = "";
                      _textEditingController.clear();
                    },
                    icon: Icon(
                      CustomIcons.close,
                      color: Colors.black,
                      size: 16,
                    ),
                  )
                : Icon(
                    Icons.search,
                    color: hintColor,
                  ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.all(10),
          ),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}
