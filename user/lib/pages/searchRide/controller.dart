import 'package:get/get.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:user/models/hospital.dart';
import 'package:user/utils/utils.dart';

class SearchRideController extends GetxController {
  late Hospital selectedHospital;
  late LatLng originLocation;

  Future<void> sendRideToServer() async {
    try {
      final response = await httpPostRequest(
        route: "/ride/add",
        body: {
          "ride_id": Random().nextInt(1000000),
          "pickup_lat": originLocation.latitude,
          "pickup_lng": originLocation.longitude,
          "drop_lat": selectedHospital.latitude,
          "drop_lng": selectedHospital.longitude,
          "hospital": "${selectedHospital.name}, ${selectedHospital.address}",
        },
      );
    } catch (e) {
      safePrint("Error adding ride: $e");
    }
  }
}
