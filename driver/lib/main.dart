import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'theme.dart';

bool loggedIn = false;

Future<void> checkLogIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  if (token != null) loggedIn = true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkLogIn();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (_) {
        return Center(
          child: SpinKitFadingCube(
            color: colorScheme.primary,
            size: 50.0,
          ),
        );
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        home: Scaffold(),
        // home: LoginScreen(),
        // home: loggedIn ? DashboardScreen() : LoginScreen(),
      ),
    );
  }
}