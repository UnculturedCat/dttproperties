import 'package:dttproperties/app_management/Providers/properties_provider.dart';
import 'package:dttproperties/shared_widgets/property_grid_widget.dart';
import 'package:dttproperties/app_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dttproperties/app_management/Providers/user_preferences_provider.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final favoritePropertiesIds = ref.watch(favoritePropertiesProvider);
    final properties = ref.watch(collectedProperties);
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
        body: favoritePropertiesIds.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Images/search_state_empty.png',
                      height: favouriteImageHeight,
                      width: favouriteImageWidth,
                    ),
                    Text(
                        "No loved properties yet?\nKeep looking, there is a home for everyone!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                ),
              )
            : properties.when(
                data: (properties) {
                  final favoriteProperties = properties
                      .where((property) => favoritePropertiesIds
                          .contains(property.id.toString()))
                      .toList();
                  return Container(
                    padding: standardPagePadding,
                    child: GridView.builder(
                      itemCount: favoriteProperties.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridColumns,
                        childAspectRatio: gridChildAspectRatio,
                        crossAxisSpacing: gridCrossAxisSpacing,
                        mainAxisSpacing: gridMainAxisSpacing,
                      ),
                      itemBuilder: (context, index) {
                        return PropertyGridWidget(
                          propertyData: favoriteProperties[index],
                        );
                      },
                    ),
                  );
                },
                error: (error, stack) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline),
                        Text("Error getting saved properties!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge)
                      ],
                    ),
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator())));
  }
}
