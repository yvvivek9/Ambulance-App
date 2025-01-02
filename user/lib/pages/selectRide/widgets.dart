import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:user/models/vehicleTypes.dart';
import 'package:user/models/hospital.dart';

class Map extends StatelessWidget {
  const Map({super.key, required this.originLocation, required this.selectedHospital});

  final LatLng originLocation;
  final Hospital selectedHospital;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height / 2) - 80,
      // height: MediaQuery.of(context).size.height,
      child: FutureBuilder<BitmapDescriptor>(
        initialData: BitmapDescriptor.defaultMarker,
        future: BitmapDescriptor.asset(
          ImageConfiguration(size: Size(24, 24)),
          'assets/map_icon.png',
        ),
        builder: (ctx, snapshot) => GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          buildingsEnabled: false,
          mapToolbarEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(originLocation.latitude + 0.005, originLocation.longitude),
            zoom: 13.5,
          ),
          markers: {
            Marker(
              markerId: MarkerId("Self"),
              position: originLocation,
              icon: snapshot.data!,
              infoWindow: InfoWindow(
                title: "Your Location",
              ),
            ),
            Marker(
              markerId: MarkerId("Hospital"),
              position: LatLng(selectedHospital.latitude, selectedHospital.longitude),
              icon: snapshot.data!,
              infoWindow: InfoWindow(
                title: selectedHospital.name,
              ),
            ),
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
                originLocation,
                LatLng(selectedHospital.latitude, selectedHospital.longitude),
              ],
            ),
          },
        ),
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({super.key, required this.destination});

  final String destination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      child: Column(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: "Your Location"),
                  style: context.textTheme.bodySmall,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.theme.colorScheme.surface,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 10,
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: DottedLine(),
                ),
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: destination),
                  style: context.textTheme.bodySmall,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.theme.colorScheme.surface,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 10,
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 70),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class BottomPage extends StatelessWidget {
  const BottomPage({super.key, required this.selectedRide, this.temp, required this.handleClick});

  final Rx<VehicleType?> selectedRide;
  final VehicleType? temp;
  final Function handleClick;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 500,
        child: Container(
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
                    "Select Ride Type",
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Material(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: VehicleType.list
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                if (selectedRide.value == e) {
                                  selectedRide.value = null;
                                } else {
                                  selectedRide.value = e;
                                }
                              },
                              child: Ink(
                                height: 80,
                                color: selectedRide.value == e ? context.theme.colorScheme.tertiary : context.theme.colorScheme.surface,
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                child: Row(
                                  children: [
                                    Image.asset(e.image),
                                    SizedBox(width: 30),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title,
                                            style: context.textTheme.titleMedium,
                                          ),
                                          Text(
                                            e.cost,
                                            style: context.textTheme.labelMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
                child: Material(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Spacer(),
                              Image.asset("assets/cash_icon.png", height: 25),
                              SizedBox(width: 10),
                              Text(
                                "Cash",
                                style: context.textTheme.titleMedium,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Spacer(),
                              Image.asset("assets/coupon_icon.png", height: 25),
                              SizedBox(width: 10),
                              Text(
                                "Coupon",
                                style: context.textTheme.titleMedium,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.theme.colorScheme.primary,
                  foregroundColor: context.theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  textStyle: context.textTheme.titleMedium!.copyWith(fontSize: 16),
                ),
                onPressed: selectedRide.value == null
                    ? null
                    : () {
                        handleClick();
                      },
                child: Text("Book  Ride"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
