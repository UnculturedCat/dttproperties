import 'package:dttproperties/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:dttproperties/shared.dart';

class House extends StatelessWidget {
  final String price = "45,000";
  final String address = "1011KH Raamgrach";
  final numberOfBedrooms = 3;
  final numberOfBathrooms = 2;
  final double distance = 1800.66;
  final int size = 54;
  const House({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: cardShadowColor,
                spreadRadius: 5,
                blurRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 20),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/Images/download.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$$price",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            address,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      FittedBox(
                        child: Column(
                          children: [
                            Row(
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
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
