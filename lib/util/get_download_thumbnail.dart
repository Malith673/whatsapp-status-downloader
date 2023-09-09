import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_status_server/colors/colors.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/download_video_view.dart';

class GetDownloadVideoThumbnails extends StatefulWidget {
  final String videoFilePath;
  final Function(String imagePath) deleteImage;
  const GetDownloadVideoThumbnails({
    super.key,
    required this.videoFilePath,
    required this.deleteImage,
  });

  @override
  State<GetDownloadVideoThumbnails> createState() =>
      _GetDownloadVideoThumbnailsState();
}

class _GetDownloadVideoThumbnailsState
    extends State<GetDownloadVideoThumbnails> {
  late VideoPlayerController _controller;
  bool _isThumbnailIsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadThumbnail() async {
    _controller = VideoPlayerController.file(File(widget.videoFilePath));

    try {
      await _controller.initialize();
    } catch (e) {
      print('Error initializing video player: $e');
      return;
    }

    setState(() {
      _isThumbnailIsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isThumbnailIsLoaded
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DownloadVideoView(
                          videoController: _controller,
                          onDeleteImage: widget.deleteImage,
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.mainColor)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : const SpinKitCircle(
            color: Colors.white,
            size: 30,
          );
  }
}
