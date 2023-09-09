import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsapp_status_server/util/get_download_thumbnail.dart';

class DownloadsVideos extends StatefulWidget {
  const DownloadsVideos({super.key});

  @override
  State<DownloadsVideos> createState() => _DownloadsVideosState();
}

class _DownloadsVideosState extends State<DownloadsVideos> {
  List<File> videoFiles = [];

  Future<void> getVideos() async {
    String filePath =
        '/storage/emulated/0/Android/data/com.example.whatsapp_status_server/files/statusDownloader';
    Directory directory = Directory(filePath);

    if (await directory.exists()) {
      List<FileSystemEntity> files = directory.listSync();
      debugPrint('$files');

      for (var file in files) {
        if (file is File) {
          if (file.path.endsWith('.mp4')) {
            videoFiles.add(file);
          }
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  void onDeleteVideo(String deletedImagePath) {
    setState(() {
      videoFiles.removeWhere((file) => file.path == deletedImagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: videoFiles.isEmpty
          ? const Center(
              child: Text('No Downloaded Videos'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: videoFiles.length,
              itemBuilder: (context, index) {
                final data = videoFiles[index];
                return GetDownloadVideoThumbnails(
                  videoFilePath: data.path,
                  deleteImage: (String imagePath) {
                    onDeleteVideo(data.path);
                  },
                );
              },
            ),
    );
  }
}
