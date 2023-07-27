import 'dart:convert';

import 'package:dttproperties/Models/property.dart';
import 'package:dttproperties/Models/search_filter.dart';
import 'package:dttproperties/app_management/Providers/search_filter_provider.dart';
import 'package:dttproperties/app_management/api_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final collectedProperties = FutureProvider<List<Property>>((ref) async {
  final List<Property> collectedPropertiesData = [];
  final query = ref.watch(searchQueryProvider);
  final searchFilter = ref.watch(searchFilterProvider);
  Uri url = Uri.parse('https://intern.d-tt.nl/api/house');
  final response = await http.get(url, headers: {'Access-Key': houseAPIKey});
  if (response.statusCode == 200) {
    final List<dynamic> properties = jsonDecode(response.body);
    for (var property in properties) {
      collectedPropertiesData.add(Property(
        id: property['id'] ?? 0,
        imageAddress: property['image'] ?? '',
        price: property['price'] ?? 0,
        numberOfBedrooms: property['bedrooms'] ?? 0,
        numberOfBathrooms: property['bathrooms'] ?? 0,
        size: property['size'] ?? 0,
        description: property['description'] ?? '',
        zip: property['zip'] ?? '',
        city: property['city'] ?? '',
        latitude: property['latitude'] ?? 0,
        longitude: property['longitude'] ?? 0,
        dateCreated: property['date_created'] ?? '',
      ));
    }
  }
  return filterProperties(collectedPropertiesData, searchFilter, query);
});

///Filter the properties based on the search filter and search query
List<Property> filterProperties(
    List<Property> properties, SearchFilter filter, String query) {
  List<Property> filteredProperties = properties;

  if (filter.priceSort == PriceSort.lowToHigh) {
    filteredProperties.sort((a, b) => a.price.compareTo(b.price));
  } else if (filter.priceSort == PriceSort.highToLow) {
    filteredProperties.sort((a, b) => b.price.compareTo(a.price));
  }

  return filteredProperties
      .where((property) =>
          property.numberOfBedrooms >= filter.minNumberOfBedrooms &&
          property.city.toLowerCase().contains(query.trim().toLowerCase()))
      .toList();
}
