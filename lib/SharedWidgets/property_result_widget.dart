import 'package:dttproperties/AppManagement/Providers.dart';
import 'package:dttproperties/SharedWidgets/property_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyResults extends ConsumerWidget {
  const PropertyResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(collectedProperties);
    return properties.when(
      data: (properties) {
        return properties.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Images/search_state_empty.png',
                      height: 200,
                      width: 200,
                    ),
                    Text("No results found!\nPerhaps try another search?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.only(
                    bottom: 70), // extra space for the last item to be visible
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  return PropertyWidget(
                    propertyData: properties[index],
                  );
                },
              );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
