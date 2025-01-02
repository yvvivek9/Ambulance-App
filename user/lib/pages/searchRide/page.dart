import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:user/models/vehicleTypes.dart';
import 'package:user/models/hospital.dart';
import 'controller.dart';
import 'widgets.dart';

class SearchRideScreen extends StatelessWidget {
  SearchRideScreen({super.key, required this.selectedRide, required this.selectedHospital, required this.originLocation});

  final controller = Get.put(SearchRideController());
  final VehicleType selectedRide;
  final Hospital selectedHospital;
  final LatLng originLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Map(
              userLocation: originLocation,
            ),
            BottomPage(
              hospitalName: selectedHospital.name,
              hospitalAddress: selectedHospital.address,
              vehicleType: selectedRide.title,
              cost: selectedRide.cost,
              paymentMode: "Cash",
              onCancel: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
