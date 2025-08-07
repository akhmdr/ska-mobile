import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class VideoTutorialPage extends StatefulWidget {
  const VideoTutorialPage({super.key});

  @override
  State<VideoTutorialPage> createState() => _VideoTutorialPageState();
}

class _VideoTutorialPageState extends State<VideoTutorialPage> {
  final List<Map<String, String>> allVideos = [
    {
      'title': 'Cara Pengajuan SKA',
      'url': 'https://www.youtube.com/watch?v=1xQeXOz0Ncs',
      'category': 'Pengajuan',
    },
    {
      'title': 'Cara Tracking SKA',
      'url': 'https://www.youtube.com/watch?v=Uddk6FyNn20',
      'category': 'Tracking',
    },
    {
      'title': 'Cara Cetak Dokumen',
      'url': 'https://www.youtube.com/watch?v=OXaSof6tt9k',
      'category': 'Pencetakan',
    },
  ];

  final List<String> categories = [
    'Semua',
    'Pengajuan',
    'Tracking',
    'Pencetakan',
  ];
  String selectedCategory = 'Semua';

  List<Map<String, String>> get filteredVideos {
    if (selectedCategory == 'Semua') return allVideos;
    return allVideos
        .where((video) => video['category'] == selectedCategory)
        .toList();
  }

  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers =
        allVideos.map((video) {
          return YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(video['url']!)!,
            flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Video Tutorial'),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pilih Kategori', style: AppTheme.textBold14),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.whiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items:
                    categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category, style: AppTheme.textRegular14),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredVideos.length,
                  itemBuilder: (context, index) {
                    final video = filteredVideos[index];
                    final controllerIndex = allVideos.indexWhere(
                      (v) => v['url'] == video['url'],
                    );
                    final controller = _controllers[controllerIndex];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom: 8,
                            ),
                            child: Text(
                              video['title'] ?? '',
                              style: AppTheme.textBold14,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                            child: YoutubePlayer(
                              controller: controller,
                              showVideoProgressIndicator: true,
                              progressColors: const ProgressBarColors(
                                playedColor: AppTheme.primaryColor,
                                handleColor: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
