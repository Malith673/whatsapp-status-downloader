import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_status_server/colors/colors.dart';

class GuideBox extends StatelessWidget {
  const GuideBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        height: 500.h,
        width: 200.w,
        decoration: const BoxDecoration(
            color: Color(0xFF2C3333),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'How to use this App',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 200.w,
              height: 350.h,
              decoration: const BoxDecoration(
                color: Color(0xFF2C3333),
                image: DecorationImage(
                  image: AssetImage('assets/usageGuide.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: 120.w,
                height: 30.h,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: const Text(
                  'Got it',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
