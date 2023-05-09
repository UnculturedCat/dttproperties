import 'package:intl/intl.dart';

class Property {
  final int id;
  final String imageAddress;
  final int price;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int size;
  final String description;
  final String zip;
  final String city;
  final int latitude;
  final int longitude;
  final String dateCreated;
  Property({
    required this.id,
    required this.imageAddress,
    required this.price,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.size,
    required this.description,
    required this.zip,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.dateCreated,
  });

  get address {
    return "$formatedZipCode $city";
  }

  get formattedPriceString {
    NumberFormat priceformat = NumberFormat.decimalPattern("en_US");
    return priceformat.format(price);
  }

  get formatedZipCode {
    return zip.replaceAll(RegExp(r' '), "");
  }
}
