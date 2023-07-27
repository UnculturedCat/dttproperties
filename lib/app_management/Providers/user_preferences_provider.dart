import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dttproperties/app_management/constants.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
    (ref) async => await SharedPreferences.getInstance());

final favoritePropertiesProvider = StateProvider<List<String>>((ref) {
  List<String> favoritePropertiesIds = [];
  ref.watch(sharedPreferencesProvider).whenData((sharedPreferences) {
    favoritePropertiesIds =
        sharedPreferences.getStringList(favoritePropertiesKey) ?? [];
  });
  return favoritePropertiesIds;
});
