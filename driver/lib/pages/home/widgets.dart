import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import 'package:driver/pages/login/page.dart';
import 'package:driver/models/ride.dart';

Widget buildCustomDrawer(Size screenSize, ColorScheme colorScheme, TextTheme textTheme) {
  return Drawer(
    backgroundColor: colorScheme.onPrimary,
    width: screenSize.width * 2 / 3,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: colorScheme.primary,
          ),
          child: Image.asset(
            "assets/ambigo/logo_nobg.PNG",
          ),
        ),
        ListTile(
          tileColor: colorScheme.surface,
          textColor: colorScheme.primary,
          iconColor: colorScheme.primary,
          titleTextStyle: textTheme.titleMedium,
          minLeadingWidth: 40,
          leading: Icon(Icons.history),
          title: const Text("History"),
          onTap: () {},
        ),
        ListTile(
          tileColor: colorScheme.surface,
          textColor: colorScheme.primary,
          iconColor: colorScheme.primary,
          titleTextStyle: textTheme.titleMedium,
          minLeadingWidth: 40,
          leading: Icon(Icons.add_chart),
          title: const Text("Status"),
          onTap: () {},
        ),
        ListTile(
          tileColor: colorScheme.surface,
          textColor: colorScheme.primary,
          iconColor: colorScheme.primary,
          titleTextStyle: textTheme.titleMedium,
          minLeadingWidth: 40,
          leading: Icon(Icons.contact_emergency),
          title: const Text("Contact Us"),
          onTap: () {},
        ),
        ListTile(
          tileColor: colorScheme.primary,
          textColor: colorScheme.surface,
          iconColor: colorScheme.surface,
          titleTextStyle: textTheme.titleMedium,
          minLeadingWidth: 40,
          leading: Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () async {
            // final GoogleSignIn googleSignIn = GoogleSignIn(
            //   scopes: <String>[
            //     'email',
            //   ],
            // );
            // await googleSignIn.signOut();
            Get.offAll(() => LoginScreen());
          },
        ),
      ],
    ),
  );
}

class RidesDisplay extends StatelessWidget {
  const RidesDisplay({super.key, required this.rides, required this.handleCancel, required this.handleAccept});

  final List<Ride> rides;
  final Function(Ride) handleCancel;
  final Function(Ride) handleAccept;

  @override
  Widget build(BuildContext context) {
    if (rides.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        child: Center(
          child: Text(
            "No rides found!!",
            style: context.textTheme.labelMedium,
          ),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rides
            .map(
              (ride) => Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 5.0, spreadRadius: 1.0, color: Colors.grey.shade400)],
                ),
                child: Column(
                  children: [
                    FixedTimeline(
                      children: [
                        TimelineTile(
                          nodePosition: 0,
                          node: TimelineNode(
                            endConnector: Connector.solidLine(color: Colors.black87),
                            indicator: DotIndicator(color: Colors.red),
                            indicatorPosition: 0.15,
                          ),
                          contents: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pickup: 2 km",
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
                            indicatorPosition: 0.1,
                          ),
                          contents: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Drop: ${ride.hospital}",
                                  style: context.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Color(0xFF5B5B5B),
                              backgroundColor: Colors.white70,
                              textStyle: context.textTheme.labelMedium,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              minimumSize: Size.zero,
                            ),
                            onPressed: () {
                              handleCancel(ride);
                            },
                            child: Text("Cancel"),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: context.theme.colorScheme.onSecondary,
                              backgroundColor: context.theme.colorScheme.secondary,
                              textStyle: context.textTheme.labelMedium,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              minimumSize: Size.zero,
                            ),
                            onPressed: () {
                              handleAccept(ride);
                            },
                            child: Text("Accept"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );
    }
  }
}
