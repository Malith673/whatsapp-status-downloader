import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_status_server/widget/guid_box.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarWA extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWA({
    super.key,
    required this.title,
  });

  void openWhatsApp() async {
    const url = 'https://wa.me/status';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showGuideBox() {
      showDialog(
          context: context,
          builder: (context) {
            return const GuideBox();
          });
    }

    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
      ),
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: openWhatsApp,
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/waLogo.png'),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: _showGuideBox,
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: Icon(
              Icons.help,
              size: 30.sp,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
