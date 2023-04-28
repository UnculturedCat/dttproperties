import 'package:dttproperties/PropertyResults.dart';
import 'package:dttproperties/Providers.dart';
import 'package:dttproperties/Searchbar.dart';
import 'package:dttproperties/Shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final hasInternet = ref.watch(internetConnectivityStatusProvider);
    super.build;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff7f7f7),
          body: hasInternet.when(
              data: (connectedToInternet) {
                return connectedToInternet
                    ? Container(
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
                      )
                    : Center(
                        child: Text("No internet connection"),
                      );
              },
              error: (error, stack) => Center(child: Text(error.toString())),
              loading: () => Center(child: CircularProgressIndicator())),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
