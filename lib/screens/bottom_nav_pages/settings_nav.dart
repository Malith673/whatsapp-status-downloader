import 'package:flutter/material.dart';
import 'package:whatsapp_status_server/colors/colors.dart%20';
import 'package:whatsapp_status_server/widget/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_status_server/widget/guid_box.dart';
import 'package:whatsapp_status_server/widget/settings_listTile.dart';

class SettingsNav extends StatefulWidget {
  const SettingsNav({super.key});

  @override
  State<SettingsNav> createState() => _SettingsNavState();
}

class _SettingsNavState extends State<SettingsNav> {
  void _showGuideBox() {
    showDialog(
        context: context,
        builder: (context) {
          return const GuideBox();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWA(title: 'Settings'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100.h,
                child: Row(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Whatsapp',
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Status Server',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: _showGuideBox,
              child: SettingsTile(
                mainText: 'How to Use',
                subText: 'Usage Guide',
                subTextSize: 12.sp,
              ),
            ),
            SettingsTile(
              mainText: 'Save Statuses in Folder',
              subText:
                  '/storage/emulated/0/Android/data/com.example.whatsapp_status_server/files/statusDownloader',
              subTextSize: 12.sp,
            ),
            SettingsTile(
              mainText: 'Privacy policy',
              subText: 'Our Terms and conditions',
              subTextSize: 12.sp,
            ),
            SettingsTile(
              mainText: 'Share with others',
              subText: 'Share this app with your beloved friends',
              subTextSize: 12.sp,
            ),
            SettingsTile(
              mainText: 'Rate us',
              subText: 'Please support our work by rating',
              subTextSize: 12.sp,
            ),
            SettingsTile(
              mainText: 'Version',
              subText: 'Version : 1.0.0',
              subTextSize: 12.sp,
            )
          ],
        ),
      ),
    );
  }
}
