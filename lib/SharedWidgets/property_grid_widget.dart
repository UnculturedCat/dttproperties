import 'package:dttproperties/Models/Property.dart';
import 'package:dttproperties/Pages/Secondary/property_information_page.dart';
import 'package:flutter/material.dart';
import 'package:dttproperties/AppManagement/Shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyGridWidget extends ConsumerWidget {
  final Property propertyData;

  const PropertyGridWidget({required this.propertyData, super.key});

  void _navigateToPropertyPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PropertyInformationPage(propertyData: propertyData)));
  }

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () => _navigateToPropertyPage(context),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Color.fromARGB(74, 0, 0, 0),
              BlendMode.darken,
            ),
            image: Image.network(
              "https://intern.d-tt.nl${propertyData.imageAddress}",
            ).image,
            fit: BoxFit.cover,
          ),
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
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${propertyData.price}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          propertyData.address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
