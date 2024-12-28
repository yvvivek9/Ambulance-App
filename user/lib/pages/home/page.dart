import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:strings/strings.dart';
import 'dart:async';

import 'controller.dart';
import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    //context.loaderOverlay.show();
    return SafeArea(
      child: Scaffold(
        drawer: buildCustomDrawer(
          MediaQuery.of(context).size,
          context.theme.colorScheme,
          context.textTheme,
        ),
        body: Obx(
          () => Stack(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height / 2) - 80,
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  buildingsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(20.5937, 78.9629),
                    zoom: 5,
                  ),
                  onMapCreated: (GoogleMapController c) {
                    controller.mapController = c;
                  },
                  markers: controller.hospitalList.value
                      .map((e) => Marker(
                            markerId: MarkerId(e.name),
                            position: LatLng(e.latitude, e.longitude),
                            icon: controller.customMapIcon.value,
                            infoWindow: InfoWindow(
                              title: Strings.abbreviate(e.name, 20),
                              snippet: Strings.abbreviate(e.address, 20),
                            ),
                          ))
                      .toSet(),
                ),
              ),
              TopRow(),
              BottomRow(
                hospitalList: controller.hospitalList.value,
                handleSelect: controller.onHospitalSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
