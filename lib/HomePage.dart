import 'package:dttproperties/PropertyResults.dart';
import 'package:dttproperties/Searchbar.dart';
import 'package:dttproperties/Shared.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff7f7f7),
          body: Container(
            padding: standardPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DTT REAL ESTATE",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SearchBar(),
                Expanded(
                  child: PropertyResults(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
