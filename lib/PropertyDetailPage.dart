import 'package:dttproperties/shared.dart';
import 'package:flutter/material.dart';
import 'custom_icons_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyDetailPage extends StatelessWidget {
  final String price = "45,000";
  final String address = "1011KH Raamgrach";
  final numberOfBedrooms = 3;
  final numberOfBathrooms = 2;
  final double distance = 1800.66;
  final int size = 54;
  const PropertyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
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
              child: Image.asset(
                "assets/Images/download.jpg",
                fit: BoxFit.cover,
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
                              "\$$price",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            FittedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  LabelledIcon(
                                      icon: CustomIcons.bed,
                                      label: "$numberOfBedrooms"),
                                  LabelledIcon(
                                      icon: CustomIcons.bath,
                                      label: "$numberOfBathrooms"),
                                  LabelledIcon(
                                      icon: CustomIcons.layers, label: "$size"),
                                  LabelledIcon(
                                      icon: CustomIcons.location,
                                      label: "$distance km"),
                                ],
                              ),
                            )
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
                          "Lremm oinaso incoasinocnoauscbkvidak dspofuvhbfduvnlksjac  adusbvkdvsbnvkds  ohiubdskhjvbkudsbluibvdsiu oubdsv pbnodvsubiuvdsbo dvsbioubdosiubouzdsboiubasdouidbviuzbvdsouzu  oiuobubdskvuzbouzbdsvou  oiuhbdvoisoiubokasdbuo o ubsdoiuvbo oibijdsvbohbdsikbdv obdkvhjbvadphnasdov ",
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
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(45.521563, -122.677433),
                            zoom: 10.0,
                          ),
                        ),
                      )
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
