import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_server/colors/colors.dart';
import 'package:whatsapp_status_server/provider/botttom_nav_provider.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/download_nav..dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/image_nav.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/settings_nav.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/video_nav.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = const [
    ImageNavPage(),
    VideoNavPage(),
    Downloads(),
    SettingsNav(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, nav, child) {
        return Scaffold(
          body: pages[nav.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 30,
            selectedItemColor: AppColors.mainColor,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              nav.changeIndex(value);
            },
            currentIndex: nav.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    FluentIcons.image_20_filled,
                    size: 25,
                  ),
                  label: 'Images'),
              BottomNavigationBarItem(
                  icon: Icon(
                    FluentIcons.video_20_filled,
                    size: 25,
                  ),
                  label: 'Videos'),
              BottomNavigationBarItem(
                  icon: Icon(
                    FluentIcons.arrow_download_20_filled,
                    size: 25,
                  ),
                  label: 'Downloads'),
              BottomNavigationBarItem(
                  icon: Icon(
                    FluentIcons.settings_20_filled,
                    size: 25,
                  ),
                  label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
