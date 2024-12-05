import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'controller.dart';

class BookedScreen extends StatelessWidget {
  BookedScreen({super.key, required this.startX, required this.startY, required this.endX, required this.endY});

  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final controller = Get.put(BookedPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Arriving in 10mins..."),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                buildingsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(startX, startY),
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId("Ambulance"),
                    position: LatLng(endX, endY),
                  )
                },
                polylines: {
                  Polyline(
                    polylineId: PolylineId("Route"),
                    width: 3,
                    patterns: [
                      PatternItem.dash(8),
                      PatternItem.gap(15),
                    ],
                    points: [
                      LatLng(startX, startY),
                      LatLng(endX, endY),
                    ],
                  ),
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "KA 05 AM 6671",
                              style: context.textTheme.titleMedium,
                            ),
                            Text(
                              "Force Traveller",
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 50,
                            ),
                            Text(
                              "4.7 / 5",
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            hintText: "Message Driver",
                            hintStyle: context.textTheme.bodyMedium,
                            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_circle_right),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      IconButton.filled(
                        onPressed: () {},
                        icon: Icon(Icons.phone),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Cancel ride"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
