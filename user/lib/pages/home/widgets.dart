import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:user/models/hospital.dart';
import 'package:user/pages/login/page.dart';

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
          leading: Icon(Icons.work),
          title: const Text("Service's"),
          onTap: () {},
        ),
        ListTile(
          tileColor: colorScheme.surface,
          textColor: colorScheme.primary,
          iconColor: colorScheme.primary,
          titleTextStyle: textTheme.titleMedium,
          minLeadingWidth: 40,
          leading: Icon(Icons.lock_clock),
          title: const Text("Rental"),
          onTap: () {},
        ),
        ListTile(
          tileColor: colorScheme.surface,
          textColor: colorScheme.primary,
          iconColor: colorScheme.primary,
          titleTextStyle: textTheme.titleMedium,
          minLeadingWidth: 40,
          leading: Icon(Icons.medical_information),
          title: const Text("ICU's"),
          onTap: () {},
        ),
        ListTile(
          tileColor: colorScheme.surface,
          textColor: colorScheme.primary,
          iconColor: colorScheme.primary,
          titleTextStyle: textTheme.titleMedium,
          minLeadingWidth: 40,
          leading: Icon(Icons.local_hospital_rounded),
          title: const Text("Hospitals"),
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
            final GoogleSignIn googleSignIn = GoogleSignIn(
              scopes: <String>[
                'email',
              ],
            );
            await googleSignIn.signOut();
            Get.offAll(() => LoginScreen());
          },
        ),
      ],
    ),
  );
}

class TopRow extends StatelessWidget {
  const TopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: context.theme.colorScheme.onSurface,
                  backgroundColor: context.theme.colorScheme.surface,
                  iconSize: 30,
                  padding: EdgeInsets.all(10),
                  // side: BorderSide(
                  //   color: context.theme.colorScheme.onSurface,
                  //   width: 2,
                  // ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                readOnly: true,
                style: context.textTheme.titleMedium,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.theme.colorScheme.surface,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(
                    Icons.gps_fixed,
                    color: context.theme.colorScheme.primary,
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 70),
                  hintText: "Current Location",
                  hintStyle: context.textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomRow extends StatelessWidget {
  const BottomRow({super.key, required this.hospitalList, required this.handleSelect});

  final List<Hospital> hospitalList;
  final void Function(Hospital) handleSelect;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: (MediaQuery.of(context).size.height / 2) + 100,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.theme.colorScheme.primary,
                    width: 5,
                  ),
                ),
                child: TextField(
                  readOnly: true,
                  style: context.textTheme.labelMedium,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.theme.colorScheme.surface,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    prefixIconConstraints: BoxConstraints(minWidth: 80),
                    hintText: "Drop Location",
                    hintStyle: context.textTheme.labelMedium,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildHospitalList(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildHospitalList(BuildContext context) {
    List<Widget> temp = [];
    for (final hsp in hospitalList) {
      temp.add(Material(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            handleSelect(hsp);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hsp.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  hsp.address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelMedium,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.medical_information,
                            size: 13,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "ICU",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_hospital_rounded,
                            size: 13,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Emergency",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
      temp.add(SizedBox(height: 10));
    }
    return temp;
  }
}
