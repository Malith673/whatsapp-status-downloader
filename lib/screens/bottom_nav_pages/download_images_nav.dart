import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_server/colors/colors.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/download_image_view.dart';

class DownloadImages extends StatefulWidget {
  const DownloadImages({super.key});

  @override
  State<DownloadImages> createState() => _DownloadImagesState();
}

class _DownloadImagesState extends State<DownloadImages> {
  List<File> imageFiles = [];

  Future<void> getImages() async {
    String filePath =
        '/storage/emulated/0/Android/data/com.example.whatsapp_status_server/files/statusDownloader';
    Directory directory = Directory(filePath);

    if (await directory.exists()) {
      List<FileSystemEntity> files = directory.listSync();
      debugPrint('$files');

      for (var file in files) {
        if (file is File) {
          if (file.path.endsWith('.jpg')) {
            imageFiles.add(file);
          }
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  void onDeleteImage(String deletedImagePath) {
    setState(() {
      imageFiles.removeWhere((file) => file.path == deletedImagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: imageFiles.isEmpty
          ? const Center(
              child: Text('No Downloaded Images'),
            )
          : GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              children: List.generate(imageFiles.length, (index) {
                final data = imageFiles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DownloadImageView(
                          imagePath: data.path,
                          onDeleteImage: onDeleteImage,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.mainColor),
                      image: DecorationImage(
                        image: FileImage(
                          File(data.path),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
