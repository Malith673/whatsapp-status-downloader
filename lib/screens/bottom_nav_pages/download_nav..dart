import 'package:flutter/material.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/download_images_nav.dart';
import 'package:whatsapp_status_server/widget/appbar.dart';
import 'package:whatsapp_status_server/screens/bottom_nav_pages/download_videos_nav.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  bool showImageTab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWA(title: 'Downloads'),
      body: _DownloadsContent(
        showImageTab: showImageTab,
        onToggleTab: () {
          setState(
            () {
              showImageTab = !showImageTab;
            },
          );
        },
      ),
    );
  }
}

class _DownloadsContent extends StatelessWidget {
  final bool showImageTab;
  final VoidCallback onToggleTab;

  const _DownloadsContent({
    required this.showImageTab,
    required this.onToggleTab,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 70),
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print('image tab');
                  if (!showImageTab) {
                    onToggleTab();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: const Text('Images'),
                ),
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
              GestureDetector(
                onTap: () {
                  print('video tab');
                  if (showImageTab) {
                    onToggleTab();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Videos'),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: showImageTab ? const ImageTab() : const VideoTab())
      ],
    );
  }
}

class VideoTab extends StatelessWidget {
  const VideoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const DownloadsVideos(),
    );
  }
}

class ImageTab extends StatelessWidget {
  const ImageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const DownloadImages(),
    );
  }
}
