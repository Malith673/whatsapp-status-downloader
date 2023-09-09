import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTile extends StatefulWidget {
  final String mainText;
  final String subText;
  final double subTextSize;
  const SettingsTile({
    super.key,
    required this.mainText,
    required this.subText,
    required this.subTextSize,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.white),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.mainText,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            widget.subText,
            style: TextStyle(fontSize: widget.subTextSize),
          ),
        ],
      ),
    );
  }
}
