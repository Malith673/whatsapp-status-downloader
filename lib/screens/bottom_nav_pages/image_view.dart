import 'dart:async';
import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:path/path.dart' as path;
import 'package:whatsapp_status_server/colors/colors.dart';

class ImageView extends StatefulWidget {
  final String? imagePath;
  const ImageView({super.key, this.imagePath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.arrow_download_20_filled), label: 'Download'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.arrow_left_20_filled), label: 'Re-post'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.share_20_filled), label: 'Share')
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

  double imageWidth = 1.0;
  double imageHeight = 1.0;

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

  Future<void> _saveImage(String uri) async {
    try {
      Directory? directory = await getExternalStorageDirectory();
      debugPrint("$directory");

      Directory saveDir = Directory('${directory!.path}/statusDownloader');
      if (!saveDir.existsSync()) {
        saveDir.createSync(recursive: true);
      }
      debugPrint('$saveDir');

      String filename = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      File saveFile = File(path.join(saveDir.path, filename));

      File sourceFile = File(Uri.parse(uri).toFilePath());
      await sourceFile.copy(saveFile.path);

      await ImageGallerySaver.saveFile(saveFile.path);

      debugPrint('save image');
      Fluttertoast.showToast(
        msg: 'Image Saved to your Gallery',
        backgroundColor: AppColors.mainColor,
        textColor: Colors.white,
      );
    } catch (e) {
      debugPrint('Error while downloading video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = imageWidth / imageHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          path.basename(widget.imagePath!),
        ),
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
                  debugPrint('download');
                  await _saveImage(widget.imagePath!);
                  // ImageGallerySaver.saveFile(widget.imagePath!).then((value) {
                  //   Fluttertoast.showToast(
                  //     msg: 'Image Saved to your Gallery',
                  //     backgroundColor: AppColors.mainColor,
                  //     textColor: Colors.white,
                  //   );

                  // });
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
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 30),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: List.generate(
      //       buttonList.length,
      //       (index) {
      //         return FloatingActionButton(
      //           heroTag: "$index",
      //           onPressed: () async {
      //             switch (index) {
      //               case 0:
      //                 debugPrint('download');
      //                 ImageGallerySaver.saveFile(widget.imagePath!)
      //                     .then((value) {
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     const SnackBar(
      //                       content: Text('image saved'),
      //                     ),
      //                   );
      //                 });
      //                 break;
      //               case 1:
      //                 debugPrint('print');
      //                 String imagePath = widget.imagePath!;
      //                 await _shareImagesToWA(imagePath);
      //                 break;
      //               case 2:
      //                 debugPrint('share');
      //                 String imagePath = widget.imagePath!;
      //                 await _shareImage(imagePath);
      //                 break;
      //             }
      //           },
      //           child: buttonList[index],
      //         );
      //       },
      //     ),
      //   ),
    );
  }
}
