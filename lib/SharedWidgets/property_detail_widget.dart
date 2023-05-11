import 'package:dttproperties/Models/Property.dart';
import 'package:dttproperties/AppManagement/Providers.dart';
import 'package:dttproperties/assets/Icons/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dttproperties/SharedWidgets/labelled_icon_widget.dart';

class PropertyDetail extends ConsumerWidget {
  final Property propertyData;
  const PropertyDetail({required this.propertyData, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPosition = ref.watch(currentPositionFutureProvider);
    return currentPosition.when(
      data: (position) {
        final distance = (Geolocator.distanceBetween(
                    position.latitude,
                    position.longitude,
                    propertyData.latitude.toDouble(),
                    propertyData.longitude.toDouble()) /
                1000) // convert to km
            .toStringAsFixed(1);
        return FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LabelledIcon(
                  icon: CustomIcons.bed,
                  label: "${propertyData.numberOfBedrooms}"),
              LabelledIcon(
                  icon: CustomIcons.bath,
                  label: "${propertyData.numberOfBathrooms}"),
              LabelledIcon(
                  icon: CustomIcons.layers, label: "${propertyData.size}"),
              LabelledIcon(icon: CustomIcons.location, label: "$distance km"),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LabelledIcon(
                  icon: CustomIcons.bed,
                  label: "${propertyData.numberOfBedrooms}"),
              LabelledIcon(
                  icon: CustomIcons.bath,
                  label: "${propertyData.numberOfBathrooms}"),
              LabelledIcon(
                  icon: CustomIcons.layers, label: "${propertyData.size}"),
            ],
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
