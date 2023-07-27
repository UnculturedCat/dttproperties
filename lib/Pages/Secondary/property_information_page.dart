import 'package:dttproperties/Pages/secondary/maps_page.dart';
import 'package:dttproperties/Models/property.dart';
import 'package:dttproperties/app_management/Providers/user_preferences_provider.dart';
import 'package:dttproperties/shared_widgets/property_detail_widget.dart';
import 'package:dttproperties/app_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyInformationPage extends ConsumerWidget {
  final Property propertyData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PropertyInformationPage({required this.propertyData, super.key});

  void callHouseAgent() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProperties = ref.watch(favoritePropertiesProvider);
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          !favoriteProperties.contains(propertyData.id.toString())
              ? IconButton(
                  onPressed: () async {
                    final userPreferences =
                        await SharedPreferences.getInstance();
                    // for the sake of uniformity we will use the same method to add and remove properties from the favorite list
                    ref
                        .read(favoritePropertiesProvider)
                        .add(propertyData.id.toString());
                    ref.read(favoritePropertiesProvider.notifier).state =
                        ref.read(favoritePropertiesProvider) + [];
                    // the [] operator is added to force the provider to notify the listeners
                    await userPreferences.setStringList(favoritePropertiesKey,
                        ref.read(favoritePropertiesProvider.notifier).state);
                  },
                  icon: Icon(Icons.favorite_border),
                  color: Colors.white,
                )
              : IconButton(
                  onPressed: () async {
                    final userPreferences =
                        await SharedPreferences.getInstance();
                    ref
                        .read(favoritePropertiesProvider)
                        .remove(propertyData.id.toString());
                    ref.read(favoritePropertiesProvider.notifier).state =
                        ref.read(favoritePropertiesProvider) + [];
                    await userPreferences.setStringList(favoritePropertiesKey,
                        ref.read(favoritePropertiesProvider.notifier).state);
                  },
                  icon: Icon(Icons.favorite),
                  color: Colors.red,
                ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: propertyData.imageAddress,
                child: Image.network(
                  "https://intern.d-tt.nl${propertyData.imageAddress}",
                  fit: BoxFit.cover,
                  color: Color.fromARGB(74, 0, 0, 0),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                color: backgroundColor,
                height: MediaQuery.of(context).size.height * 0.65,
                padding: standardPagePadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: contentPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${propertyData.formattedPriceString}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            PropertyDetail(
                              propertyData: propertyData,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: contentPadding,
                        child: Text("Description",
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          propertyData.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        padding: contentPadding,
                        child: Text("Location",
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(propertyData.latitude.toDouble(),
                                propertyData.longitude.toDouble()),
                            zoom: 10.0,
                          ),
                          zoomGesturesEnabled: true,
                          markers: {
                            Marker(
                              markerId: MarkerId("propertyLocation"),
                              position: LatLng(
                                propertyData.latitude.toDouble(),
                                propertyData.longitude.toDouble(),
                              ),
                            )
                          },
                          onTap: (latLng) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapsPage(
                                  latitude: propertyData.latitude.toDouble(),
                                  longitude: propertyData.longitude.toDouble(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: contentPadding.copyWith(
                            bottom: bottomPageWidgetPadding),
                        child: ElevatedButton.icon(
                          onPressed: callHouseAgent,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                          ),
                          icon: Icon(Icons.call),
                          label: Text("Contact Agent"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
