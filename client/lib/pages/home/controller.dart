import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:client/utils/utils.dart';
import 'package:client/models/hospital.dart';
import 'package:client/pages/booked/page.dart';

class HomeController extends GetxController {
  GoogleMapController? mapController;
  LocationData? locationData;

  final hospitalList = Rx<List<Hospital>>([]);

  @override
  void onInit() {
    super.onInit();
    initFunctions();
  }

  Future<void> initFunctions() async {
    try {
      locationData = await getLocationData();

      // Setting map camera
      if (mapController != null && locationData != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(locationData!.latitude!, locationData!.longitude!),
              zoom: 15,
            ),
          ),
        );
      }

      // Getting hospital list
      hospitalList.value = await Hospital.getHospitalsList(locationData!.latitude!, locationData!.longitude!);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      safePrint(e);
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  Future<void> instantBooking() async {
    try {
      Get.context!.loaderOverlay.show();
      if (locationData == null) throw "Location null";

      final url = "https://ambulance.zapto.org/ws/user";
      final channel = WebSocketChannel.connect(Uri.parse(url));
      await channel.ready;
      channel.sink.add("${locationData!.latitude!},${locationData!.longitude!}");

      channel.stream.listen((message) {
        if (message is String) {
          final split = message.split(",");
          Get.to(() => BookedScreen(
                startX: locationData!.latitude!,
                startY: locationData!.longitude!,
                endX: double.parse(split[0]),
                endY: double.parse(split[1]),
              ));
          Get.context!.loaderOverlay.hide();
          channel.sink.close();
        }
      });
    } catch (e) {
      Get.context!.loaderOverlay.hide();
      Fluttertoast.showToast(msg: "Error booking the ride");
      safePrint(e);
    }
  }
}

Future<LocationData?> getLocationData() async {
  try {
    Location location = Location();

    // checking for location access
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw "Location access denied";
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw "Location access denied";
      }
    }

    // checking if location is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw "Location Service turned off";
      }
    }

    // getting local user location
    final data = await location.getLocation();
    if (data.latitude != null && data.longitude != null) return data;
    throw "Unable to find location";
  } catch (e) {
    safePrint("Error accessing location: $e");
    throw "Unexpected error fetching location";
  }
}
