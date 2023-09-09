import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class DownloadVideoView extends StatefulWidget {
  final VideoPlayerController videoController;
  final Function(String imagePath) onDeleteImage;
  const DownloadVideoView({
    super.key,
    required this.videoController,
    required this.onDeleteImage,
  });

  @override
  State<DownloadVideoView> createState() => _DownloadVideoViewState();
}

class _DownloadVideoViewState extends State<DownloadVideoView> {
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.arrow_left_20_filled), label: 'Re-post'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.share_20_regular), label: 'Share')
  ];

  List<Widget> buttonList = const [
    Icon(Icons.download),
    Icon(Icons.share),
  ];

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    widget.videoController.pause();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    final videoWidth = widget.videoController.value.size.width;
    final videoHeight = widget.videoController.value.size.height;

    _chewieController = ChewieController(
      videoPlayerController: widget.videoController,
      autoInitialize: true,
      looping: false,
      aspectRatio: videoWidth / videoHeight,
      autoPlay: true,
    );
  }

  Future<void> _shareVideo(String videoPath) async {
    try {
      File videoFile = File(Uri.parse(videoPath).toFilePath());
      await Share.shareFiles([videoFile.path]);
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _shareImagesToWA(String videoPath) async {
    try {
      File videoFile = File(Uri.parse(videoPath).toFilePath());
      await WhatsappShare.shareFile(
        phone: '012122122',
        filePath: [(videoFile.path)],
        text: 'Check out this video!',
      );
      debugPrint('share to thw wa');
    } catch (e) {
      debugPrint('Error while sharing video: $e');
    }
  }

  void deleteFile(String filePath) async {
    try {
      File file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        print('File deleted successfully');
        widget.onDeleteImage(filePath); // Step 2: Call the callback function
        Navigator.of(context).pop();
      } else {
        print('File does not exist');
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            path.basename(_chewieController!.videoPlayerController.dataSource),
          ),
        ),
      ),
      body: Center(
          child: _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : const CircularProgressIndicator()),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
            onTap: (value) async {
              switch (value) {
                case 0:
                  debugPrint('delete');
                  String videoPath =
                      _chewieController!.videoPlayerController.dataSource;
                  deleteFile(videoPath);
                  break;
                case 1:
                  debugPrint('print');
                  String videoPath =
                      _chewieController!.videoPlayerController.dataSource;
                  await _shareImagesToWA(videoPath);
                  break;
                case 2:
                  debugPrint('share');
                  String videoPath =
                      _chewieController!.videoPlayerController.dataSource;
                  await _shareVideo(videoPath);
                  break;
              }
            },
            items: _bottomNavigationBarItems),
      ),
    );
  }
}
