import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dttproperties/Models/Property.dart';
import 'package:dttproperties/AppManagement/api_keys.dart';
import 'package:dttproperties/Models/SearchFilter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final favoritePropertiesProvider = StateProvider<List<Property>>((ref) => []);
final searchQueryProvider = StateProvider<String>((ref) => '');
final locationPermissionProvider = StateProvider<bool>((ref) => false);
final appLoadingProvider = StateProvider<bool>((ref) => false);
final connectivityStatusStreamProvider =
    StreamProvider((ref) => Connectivity().onConnectivityChanged);

final searchFilterProvider = StateProvider<SearchFilter>((ref) {
  return SearchFilter();
});

final internetConnectivityStatusProvider = FutureProvider<bool>(
  (ref) async {
    bool connectedToInternet = false;
    final connectivityStatus =
        ref.watch(connectivityStatusStreamProvider).value;
    if (connectivityStatus != ConnectivityResult.none) {
      connectedToInternet = await InternetConnectionChecker().hasConnection;
    }
    return connectedToInternet;
  },
);

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

//Filter the properties based on the search filter and search query
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

final currentPositionFutureProvider = FutureProvider<Position>(
  (ref) async {
    bool permissionGiven = false;
    await Geolocator.checkPermission().then((permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
        //no need to check the result of the requestPermission() call since the app will be restarted
      }
      permissionGiven = true;
    });
    if (!permissionGiven) {
      return Future.error('Permission not given');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  },
);

final currentPositionStreamProvider = StreamProvider(
  (ref) {
    final permissionGiven = ref.watch(locationPermissionProvider);
    if (!permissionGiven) {
      return Stream.error('Permission not given');
    }
    return Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ));
  },
);

Future<bool> locationPermissionGiven() async {
  bool permissionGiven = false;
  await Geolocator.checkPermission().then(
    (permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
        //no need to check the result of the requestPermission() call since the app will be restarted
      }
      permissionGiven = true;
    },
  );
  return permissionGiven;
}
