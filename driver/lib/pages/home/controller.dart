import 'dart:async';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

import 'package:driver/utils/utils.dart';
import 'package:driver/models/ride.dart';

class HomeController extends GetxController {
  final rides = Rx<List<Ride>>([]);
  final List<Ride> cancelledRides = [];

  late Timer updateRidesFn;
  final audioPlayer = AudioPlayer();

  @override
  void onInit() {
    updateRidesFn = Timer.periodic(Duration(seconds: 5), (timer) {
      getRidesList();
    });
    super.onInit();
  }

  Future<void> getRidesList() async {
    try {
      final old = rides.value;
      final temp = await Ride.getRidesFromServer();
      rides.value = Ride.subtractList(temp, cancelledRides);
      final changes = Ride.subtractList(rides.value, old);
      if (changes.isNotEmpty) {
        audioPlayer.play(AssetSource("sounds/ride-notification.wav"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching rides");
      safePrint("Error fetching rides: $e");
    }
  }

  Future<void> handleAcceptRide(Ride ride) async {
    await Ride.acceptRide(ride);
    final uri = Uri(
      scheme: "google.navigation",
      queryParameters: {
        'q': '${ride.dropLat}, ${ride.dropLng}',
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Fluttertoast.showToast(msg: "Error opening google maps");
    }
  }

  Future<void> handleCancelRide(Ride ride) async {
    cancelledRides.add(ride);
    await getRidesList();
  }

  @override
  void onClose() {
    updateRidesFn.cancel();
    audioPlayer.dispose();
    super.onClose();
  }
}
