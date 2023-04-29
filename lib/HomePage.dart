import 'package:dttproperties/PropertyResults.dart';
import 'package:dttproperties/Providers.dart';
import 'package:dttproperties/Searchbar.dart';
import 'package:dttproperties/Shared.dart';
import 'package:dttproperties/custom_icons_icons.dart';
import 'package:dttproperties/FavoritesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  final _scarfoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final hasInternet = ref.watch(internetConnectivityStatusProvider);
    super.build;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            key: _scarfoldKey,
            endDrawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 50, child: Icon(Icons.person)),
                        Spacer(),
                        Text(
                          "Useful Padawan",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text("Favorites"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FavoritesPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Profile settings"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(CustomIcons.close),
                    title: Text("sign out"),
                    onTap: () {
                      //ref.read(authServiceProvider).signOut();
                    },
                  ),
                ],
              ),
            ),
            body: hasInternet.when(
                data: (connectedToInternet) {
                  return connectedToInternet
                      ? Container(
                          padding: standardPagePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "DTT REAL ESTATE",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.menu),
                                    onPressed: () {
                                      _scarfoldKey.currentState!
                                          .openEndDrawer();
                                    },
                                  ),
                                ],
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
            floatingActionButton: FloatingActionButton.extended(
              label: Text("Favorites"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavoritesPage()));
              },
              backgroundColor: secondaryColor,
              icon: Icon(Icons.favorite),
            )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
