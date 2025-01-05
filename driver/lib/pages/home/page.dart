import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import 'controller.dart';
import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text(
            "ambigo",
            style: context.textTheme.headlineLarge!.copyWith(fontSize: 23),
          ),
          actions: [
            Text(
              "Driver App",
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(width: 20),
          ],
        ),
        drawer: buildCustomDrawer(
          MediaQuery.of(context).size,
          context.theme.colorScheme,
          context.textTheme,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RidesDisplay(
                rides: controller.rides.value,
                handleCancel: controller.handleCancelRide,
                handleAccept: controller.handleAcceptRide,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
