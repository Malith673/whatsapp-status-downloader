import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_server/colors/colors.dart%20';
import 'package:whatsapp_status_server/provider/get_status_provider.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/image_view.dart';
import 'package:whatsapp_status_server/widget/appbar.dart';

class ImageNavPage extends StatefulWidget {
  const ImageNavPage({super.key});

  @override
  State<ImageNavPage> createState() => _ImageNavPageState();
}

class _ImageNavPageState extends State<ImageNavPage> {
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetStatusProvider>(builder: (context, file, child) {
      if (_isFetched == false) {
        file.getStatus(".jpg");
        Future.delayed(const Duration(microseconds: 1), () {
          _isFetched = true;
        });
      }

      return Scaffold(
        appBar: const AppBarWA(title: 'Status Server'),
        body: file.isWhatsappAvailable == false
            ? const Center(
                child: Text("Whatsapp is not available"),
              )
            : file.getImages.isEmpty
                ? const Center(
                    child: Text('No images found'),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      children: List.generate(file.getImages.length, (index) {
                        final data = file.getImages[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageView(
                                  imagePath: data.path,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: AppColors.mainColor),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(data.path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
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
                        );
                      }),
                    ),
                  ),
      );
    });
  }
}
