import 'dart:async';
import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class DownloadImageView extends StatefulWidget {
  final String? imagePath;
  final Function(String imagePath) onDeleteImage;
  DownloadImageView({super.key, this.imagePath, required this.onDeleteImage});

  @override
  State<DownloadImageView> createState() => _DownloadImageViewState();
}

class _DownloadImageViewState extends State<DownloadImageView> {
  double imageWidth = 1.0;
  double imageHeight = 1.0;

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.delete_20_filled), label: 'Delete'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.arrow_left_20_filled), label: 'Re-post'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.share_20_regular), label: 'Share')
  ];

  Future<void> _shareImage(String imagePath) async {
    try {
      File videoFile = File(Uri.parse(imagePath).toFilePath());
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

  Future<void> _getImageDimensions(String imagePath) async {
    final File imageFile = File(imagePath);
    final Image image = Image.file(imageFile);

    final Completer<void> completer = Completer<void>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          setState(() {
            imageWidth = info.image.width.toDouble();
            imageHeight = info.image.height.toDouble();
          });
          completer.complete();
        },
      ),
    );
    await completer.future;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getImageDimensions(widget.imagePath!);
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
    double aspectRatio = imageWidth / imageHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text(path.basename(widget.imagePath!)),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: FileImage(
                  File(widget.imagePath!),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            onTap: (value) async {
              switch (value) {
                case 0:
                  debugPrint('delete');
                  deleteFile(widget.imagePath!);
                  break;
                case 1:
                  debugPrint('print');
                  String imagePath = widget.imagePath!;
                  await _shareImagesToWA(imagePath);
                  break;
                case 2:
                  debugPrint('share');
                  String imagePath = widget.imagePath!;
                  await _shareImage(imagePath);
                  break;
              }
            },
            items: _bottomNavigationBarItems),
      ),
    );
  }
}
