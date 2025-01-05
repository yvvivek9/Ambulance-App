import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: Stack(
            children: [
              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: BackgroundPaint(),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        "assets/ambigo/logo_nobg.PNG",
                        height: 200,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      keyboardType: TextInputType.phone,
                      style: context.textTheme.titleMedium,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          gapPadding: 0,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE7E7E7),
                        prefixIcon: Icon(Icons.phone_iphone),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 60,
                        ),
                        prefixIconColor: Colors.black54,
                        labelText: "Enter Mobile Number",
                        labelStyle: context.textTheme.labelMedium,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "By signing up, you are agreeing to our terms and conditions, privacy policy and user agreement. Click to view.",
                      style: context.textTheme.labelSmall,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.handleNormalLogin,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: context.theme.colorScheme.onPrimary,
                        backgroundColor: context.theme.colorScheme.primary,
                        textStyle: context.textTheme.bodyMedium,
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Text("Get OTP"),
                          SizedBox(width: 20),
                          Icon(Icons.timer),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("OR"),
                        ),
                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.handleGoogleLogin,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFF5B5B5B),
                        backgroundColor: Colors.white70,
                        textStyle: context.textTheme.bodyMedium,
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Image(
                            width: 20,
                            height: 20,
                            image: AssetImage('assets/icons/google.png'),
                          ),
                          SizedBox(width: 15),
                          Text("Continue with Google"),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Use the canvas to draw something
    var paint = Paint();
    paint.color = Color(0xFFFF520D);
    var center = Offset(0, 0);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: (size.width * 3),
        height: size.height + 100,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
