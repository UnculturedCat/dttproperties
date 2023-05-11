import 'dart:io';

import 'package:dttproperties/AppManagement/Shared.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MapsPage({required this.latitude, required this.longitude, super.key});

  void openMaps() async {
    String mapUrl = "";
    if (Platform.isAndroid) {
      mapUrl =
          "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    } else if (Platform.isIOS) {
      mapUrl = "https://maps.apple.com/?q=$latitude,$longitude";
    }
    Uri mapUri = Uri.parse(mapUrl);
    if (await canLaunchUrl(mapUri)) {
      try {
        await launchUrl(mapUri);
      } catch (e) {
        showDialog(
          context: _scaffoldKey.currentState!.context,
          builder: (context) => AlertDialog(
            title: Text("Could not open maps"),
            content: Text("Please try again later"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Property Location"),
        backgroundColor: secondaryColor,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.map),
                        title: Text("Open in Maps"),
                        onTap: () {
                          openMaps();
                        },
                        contentPadding: EdgeInsets.only(
                          bottom: 40.0,
                          left: 10,
                          right: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.menu)),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 10.0,
        ),
        zoomGesturesEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId("propertyLocation"),
            position: LatLng(
              latitude,
              longitude,
            ),
          )
        },
      ),
    );
  }
}
