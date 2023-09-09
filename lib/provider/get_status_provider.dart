import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_status_server/constant/wa_path_constant.dart';

class GetStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];
  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;
  bool get isWhatsappAvailable => _isWhatsappAvailable;

  void getStatus(String ext) async {
    final status = await Permission.storage.request();

    if (status.isDenied) {
      Permission.storage.request();
      debugPrint("permission denied");
      return;
    }

    if (status.isGranted) {
      // Directory? whatsappDirectory = null;

      // if (Directory(AppConstant.WHATSAPP_PATH).existsSync()) {
      //   whatsappDirectory = Directory(AppConstant.WHATSAPP_PATH);
      // } else if (Directory(AppConstant.WHATSAPP_BUSINESS_PATH).existsSync()) {
      //   whatsappDirectory = Directory(AppConstant.WHATSAPP_BUSINESS_PATH);
      // }

      // if (whatsappDirectory == null) {
      //   debugPrint('No WhatsApp found');
      //   _isWhatsappAvailable = false;
      //   notifyListeners();
      //   return;
      // }

      // final items = whatsappDirectory.listSync();
      // debugPrint(items.toString());

      // if (ext == ".mp4") {
      //   _getVideos =
      //       items.where((element) => element.path.endsWith(".mp4")).toList();
      //   notifyListeners();
      // } else {
      //   _getImages =
      //       items.where((element) => element.path.endsWith(".jpg")).toList();
      //   notifyListeners();
      // }

      // _isWhatsappAvailable = true;
      // notifyListeners();
      final directory = Directory(AppConstant.WHATSAPP_PATH);

      debugPrint(directory.toString());

      if (directory.existsSync()) {
        final items = directory.listSync();
        debugPrint(items.toString());
        if (ext == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        } else {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }

        _isWhatsappAvailable = true;
        notifyListeners();
      } else {
        debugPrint('no whatsapp found');
        _isWhatsappAvailable = false;
        notifyListeners();
      }
    }
  }
}
