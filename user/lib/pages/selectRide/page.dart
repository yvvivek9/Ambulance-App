import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:user/models/hospital.dart';
import 'widgets.dart';
import 'controller.dart';

class SelectRideScreen extends StatelessWidget {
  SelectRideScreen({super.key, required this.originLocation, required this.selectedHospital}) {
    controller.selectedHospital = selectedHospital;
    controller.originLocation = originLocation;
  }

  final controller = Get.put(SelectRideController());
  final LatLng originLocation;
  final Hospital selectedHospital;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => Stack(
              children: [
                Map(
                  originLocation: originLocation,
                  selectedHospital: selectedHospital,
                ),
                TopRow(
                  destination: "${selectedHospital.name}, ${selectedHospital.address}",
                ),
                BottomPage(
                  selectedRide: controller.selectedRide,
                  temp: controller.selectedRide.value,
                  handleClick: controller.handleNext,
                ),
              ],
            )),
      ),
    );
  }
}
