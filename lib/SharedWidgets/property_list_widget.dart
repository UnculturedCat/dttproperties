import 'package:dttproperties/Models/Property.dart';
import 'package:dttproperties/SharedWidgets/property_detail_widget.dart';
import 'package:dttproperties/Pages/Secondary/property_information_page.dart';
import 'package:flutter/material.dart';
import 'package:dttproperties/AppManagement/Shared.dart';

class PropertyWidget extends StatelessWidget {
  final Property propertyData;

  const PropertyWidget({required this.propertyData, super.key});

  void _navigateToPropertyPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PropertyInformationPage(propertyData: propertyData)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: standardPagePadding,
      child: InkWell(
        onTap: () => _navigateToPropertyPage(context),
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
                        child: Hero(
                          tag: propertyData.imageAddress,
                          child: Image.network(
                            "https://intern.d-tt.nl${propertyData.imageAddress}",
                            fit: BoxFit.cover,
                          ),
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
                            "\$${propertyData.formattedPriceString}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            propertyData.address,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      PropertyDetail(
                        propertyData: propertyData,
                      ),
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
