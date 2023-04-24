import 'dart:convert';
import 'package:dttproperties/Property.dart';
import 'package:dttproperties/api_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final collectedProperties = FutureProvider<List<Property>>((ref) async {
  final List<Property> collectedPropertiesData = [];
  final query = ref.watch(searchQuery);
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
        latitude: property['latitude'] ?? '',
        longitude: property['longitude'] ?? '',
        dateCreated: property['date_created'] ?? '',
      ));
    }
  }
  return collectedPropertiesData
      .where((property) =>
          property.city.toLowerCase().contains(query.trim().toLowerCase()))
      .toList();
});

final searchQuery = StateProvider<String>((ref) => '');
