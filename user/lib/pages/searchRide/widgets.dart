import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:device_scan_animation/device_scan_animation.dart';
import 'package:timelines/timelines.dart';

class Map extends StatelessWidget {
  const Map({super.key, required this.userLocation});

  final LatLng userLocation;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * (1 / 2),
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              rotateGesturesEnabled: false,
              buildingsEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: CameraPosition(
                target: userLocation,
                zoom: 13.5,
              ),
            ),
            Center(
              child: DeviceScanWidget(
                hideNodes: true,
                scanColor: context.theme.colorScheme.primary,
                ringColor: Colors.transparent,
                centerNodeColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomPage extends StatelessWidget {
  const BottomPage(
      {super.key,
      required this.hospitalName,
      required this.hospitalAddress,
      required this.vehicleType,
      required this.cost,
      required this.paymentMode,
      required this.onCancel});

  final String hospitalName;
  final String hospitalAddress;
  final String vehicleType;
  final String cost;
  final String paymentMode;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: (MediaQuery.of(context).size.height * (1 / 2)) + 20,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              color: context.theme.colorScheme.secondary,
              child: Center(
                child: Text(
                  "Searching for a Ride",
                  style: context.textTheme.titleMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: FixedTimeline(
                children: [
                  TimelineTile(
                    nodePosition: 0,
                    node: TimelineNode(
                      endConnector: Connector.solidLine(color: Colors.black87),
                      indicator: DotIndicator(color: Colors.red),
                      indicatorPosition: 0.2,
                    ),
                    contents: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Location",
                            style: context.textTheme.titleMedium,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  TimelineTile(
                    nodePosition: 0,
                    node: TimelineNode(
                      startConnector: Connector.solidLine(color: Colors.black87),
                      indicator: DotIndicator(color: Colors.green),
                      indicatorPosition: 0.2,
                    ),
                    contents: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hospitalName,
                            style: context.textTheme.titleMedium,
                          ),
                          Text(
                            hospitalAddress,
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Vehicle:",
                        style: context.textTheme.bodyMedium,
                      ),
                      Spacer(),
                      Text(
                        vehicleType,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Cost:",
                        style: context.textTheme.bodyMedium,
                      ),
                      Spacer(),
                      Text(
                        cost,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Payment:",
                        style: context.textTheme.bodyMedium,
                      ),
                      Spacer(),
                      Text(
                        paymentMode,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: onCancel,
                child: Text("Cancel"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
