import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:whatsapp_status_server/colors/colors.dart';

class VideoView extends StatefulWidget {
  final VideoPlayerController videoController;
  const VideoView({super.key, required this.videoController});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.arrow_download_20_filled), label: 'Download'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.arrow_left_20_filled), label: 'Re-post'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.share_20_filled), label: 'Share')
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

  Future<void> _saveVideo(String uri) async {
    try {
      Directory? directory = await getExternalStorageDirectory();
      debugPrint("$directory");

      Directory saveDir = Directory('${directory!.path}/statusDownloader');
      if (!saveDir.existsSync()) {
        saveDir.createSync(recursive: true);
      }
      debugPrint('$saveDir');

      String filename = '${DateTime.now().millisecondsSinceEpoch}.mp4';
      File saveFile = File(path.join(saveDir.path, filename));

      File sourceFile = File(Uri.parse(uri).toFilePath());
      await sourceFile.copy(saveFile.path);

      await ImageGallerySaver.saveFile(saveFile.path);

      debugPrint('save');
      Fluttertoast.showToast(
        msg: 'Video Saved to your Gallery',
        backgroundColor: AppColors.mainColor,
        textColor: Colors.white,
      );
    } catch (e) {
      debugPrint('Error while downloading video: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          path.basename(_chewieController!.videoPlayerController.dataSource),
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
                  debugPrint('download');
                  String videoPath =
                      _chewieController!.videoPlayerController.dataSource;
                  await _saveVideo(videoPath);
                  break;
                case 1:
                  debugPrint('print');
                  String imagePath =
                      _chewieController!.videoPlayerController.dataSource;
                  await _shareImagesToWA(imagePath);
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
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 30),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: List.generate(buttonList.length, (index) {
      //       return FloatingActionButton(
      //         heroTag: "$index",
      //         onPressed: () async {
      //           switch (index) {
      //             case 0:
      //               debugPrint('download');
      //               String videoPath =
      //                   _chewieController!.videoPlayerController.dataSource;
      //               await _saveVideo(videoPath);
      //               break;
      //             case 1:
      //               debugPrint('share');
      //               String videoPath =
      //                   _chewieController!.videoPlayerController.dataSource;
      //               await _shareVideo(videoPath);
      //               break;
      //           }
      //         },
      //         child: buttonList[index],
      //       );
      //     }),
      //   ),
    );
  }
}
