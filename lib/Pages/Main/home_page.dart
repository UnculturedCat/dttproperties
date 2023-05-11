import 'package:dttproperties/Pages/Secondary/search_filter_page.dart';
import 'package:dttproperties/SharedWidgets/property_result_widget.dart';
import 'package:dttproperties/AppManagement/Providers.dart';
import 'package:dttproperties/SharedWidgets/searchbar_widget.dart';
import 'package:dttproperties/AppManagement/Shared.dart';
import 'package:dttproperties/assets/Icons/custom_icons_icons.dart';
import 'package:dttproperties/Pages/Secondary/favourite_page.dart';
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
                  onTap: () {},
                ),
              ],
            ),
          ),
          body: hasInternet.when(
              data: (connectedToInternet) {
                return connectedToInternet
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: standardPagePadding,
                            child: Row(
                              children: [
                                Text(
                                  "DTT REAL ESTATE",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.menu),
                                  onPressed: () {
                                    _scarfoldKey.currentState!.openEndDrawer();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SearchBar(),
                          Container(
                            padding: standardPagePadding,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>
                                            SearchFilterPage(),
                                      );
                                    },
                                    icon: Icon(Icons.filter_list)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: PropertyResults(),
                          ),
                        ],
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
