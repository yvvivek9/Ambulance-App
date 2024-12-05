import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'dart:async';

import 'controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    //context.loaderOverlay.show();
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: context.theme.colorScheme.onPrimary,
          width: MediaQuery.of(context).size.width * 2 / 3,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                child: Icon(
                  Icons.local_hospital_rounded,
                  color: context.theme.colorScheme.primary,
                  size: 50,
                ),
              ),
              ListTile(
                tileColor: context.theme.colorScheme.primary,
                textColor: context.theme.colorScheme.onPrimary,
                iconColor: context.theme.colorScheme.onPrimary,
                titleTextStyle: context.textTheme.titleMedium,
                minLeadingWidth: 40,
                leading: Icon(Icons.work),
                title: const Text("Service's"),
                onTap: () {},
              ),
              ListTile(
                tileColor: context.theme.colorScheme.primary,
                textColor: context.theme.colorScheme.onPrimary,
                iconColor: context.theme.colorScheme.onPrimary,
                titleTextStyle: context.textTheme.titleMedium,
                minLeadingWidth: 40,
                leading: Icon(Icons.lock_clock),
                title: const Text("Rental"),
                onTap: () {},
              ),
              ListTile(
                tileColor: context.theme.colorScheme.primary,
                textColor: context.theme.colorScheme.onPrimary,
                iconColor: context.theme.colorScheme.onPrimary,
                titleTextStyle: context.textTheme.titleMedium,
                minLeadingWidth: 40,
                leading: Icon(Icons.medical_information),
                title: const Text("ICU's"),
                onTap: () {},
              ),
              ListTile(
                tileColor: context.theme.colorScheme.primary,
                textColor: context.theme.colorScheme.onPrimary,
                iconColor: context.theme.colorScheme.onPrimary,
                titleTextStyle: context.textTheme.titleMedium,
                minLeadingWidth: 40,
                leading: Icon(Icons.local_hospital_rounded),
                title: const Text("Hospitals"),
                onTap: () {},
              ),
              ListTile(
                tileColor: context.theme.colorScheme.onPrimary,
                textColor: context.theme.colorScheme.primary,
                iconColor: context.theme.colorScheme.primary,
                titleTextStyle: context.textTheme.titleMedium,
                minLeadingWidth: 40,
                leading: Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              GoogleMap(
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
                          infoWindow: InfoWindow(
                            title: e.name,
                            snippet: e.address,
                          ),
                        ))
                    .toSet(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: context.theme.colorScheme.surface,
                          border: OutlineInputBorder(),
                          prefixIcon: Builder(
                            builder: (context) => IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(Icons.menu),
                            ),
                          ),
                          hintText: "Search a hospital, medic center",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Spacer(),
                            Icon(Icons.electric_bolt),
                            SizedBox(width: 20),
                            Text("Instant Booking"),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.theme.colorScheme.onPrimary,
                          foregroundColor: context.theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Spacer(),
                            Icon(Icons.timer),
                            SizedBox(width: 20),
                            Text("Custom Booking"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
