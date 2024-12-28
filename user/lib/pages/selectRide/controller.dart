import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:user/models/ride.dart';
import 'package:user/models/hospital.dart';
import 'package:user/pages/searchRide/page.dart';

class SelectRideController extends GetxController {
  final selectedRide = Rx<Ride?>(null);
  late Hospital selectedHospital;
  late LatLng originLocation;

  Future<void> handleNext() async {
    Get.to(() => SearchRideScreen(
          selectedRide: selectedRide.value!,
          selectedHospital: selectedHospital,
          originLocation: originLocation,
        ));
  }
}
