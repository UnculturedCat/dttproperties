import 'package:dttproperties/AppManagement/Providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../AppManagement/Shared.dart';

class SearchBar extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 20),
      child: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Enter a location",
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: detailColor,
                ),
            filled: true,
            fillColor: inactiveColor,
            suffixIcon: Icon(Icons.search),
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
