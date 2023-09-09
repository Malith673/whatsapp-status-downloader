import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_status_server/colors/colors.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/video_view.dart';

class GetThumbnails extends StatefulWidget {
  final String videoFilePath;
  const GetThumbnails({super.key, required this.videoFilePath});

  @override
  State<GetThumbnails> createState() => _GetThumbnailsState();
}

class _GetThumbnailsState extends State<GetThumbnails> {
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
                    builder: (_) => VideoView(
                          videoController: _controller,
                        )),
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.mainColor)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoPlayer(_controller),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 80,
                  child: Icon(
                    Icons.download_for_offline,
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          )
        : const SpinKitCircle(
            color: Colors.white,
            size: 30,
          );
  }
}
