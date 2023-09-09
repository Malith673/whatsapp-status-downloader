import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:whatsapp_status_server/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: const SpinKitCircle(
                  color: Colors.green,
                  size: 60,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Whatsapp Status Server',
                      textStyle: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w700),
                      colors: [
                        Colors.green,
                        Colors.yellow,
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
