import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final connectivityStatusStreamProvider =
    StreamProvider((ref) => Connectivity().onConnectivityChanged);

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
