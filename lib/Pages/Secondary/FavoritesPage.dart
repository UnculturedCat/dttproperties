import 'package:dttproperties/SharedWidgets/PropertyGridWidget.dart';
import 'package:dttproperties/AppManagement/Providers.dart';
import 'package:dttproperties/AppManagement/Shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final favoriteProperties = ref.watch(favoritePropertiesProvider);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: favoriteProperties.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Images/search_state_empty.png',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                      "No loved properties yet?\nKeep looking, there is a home for everyone!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge)
                ],
              ),
            )
          : Container(
              padding: standardPagePadding,
              child: GridView.builder(
                itemCount: favoriteProperties.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return PropertyGridWidget(
                    propertyData: favoriteProperties[index],
                  );
                },
              ),
            ),
    );
  }
}
