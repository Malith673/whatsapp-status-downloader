import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_server/provider/get_status_provider.dart';
import 'package:whatsapp_status_server/util/get_thumbnail.dart';
import 'package:whatsapp_status_server/widget/appbar.dart';

class VideoNavPage extends StatefulWidget {
  const VideoNavPage({Key? key}) : super(key: key);

  @override
  State<VideoNavPage> createState() => _VideoNavPageState();
}

class _VideoNavPageState extends State<VideoNavPage> {
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWA(title: 'Status Server'),
      body: Consumer<GetStatusProvider>(
        builder: (context, file, child) {
          if (_isFetched == false) {
            file.getStatus(".mp4");
            Future.delayed(const Duration(microseconds: 1), () {
              _isFetched = true;
            });
          }
          return file.isWhatsappAvailable == false
              ? const Center(
                  child: Text("Whatsapp not available"),
                )
              : file.getVideos.isEmpty
                  ? const Center(
                      child: Text("No Video available"),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4),
                        itemCount: file.getVideos.length,
                        itemBuilder: (context, index) {
                          final data = file.getVideos[index];
                          return GetThumbnails(
                            videoFilePath: data.path,
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
