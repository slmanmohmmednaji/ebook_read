import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // استخدم رابط فيديو صالح هنا
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    
    // إضافة مستمع لتتبع حالة التشغيل
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشغل الفيديو'),
      ),
      body: Column(
        children: [
          // منطقة عرض الفيديو
          Expanded(
            child: Center(
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // مشغل الفيديو
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              VideoPlayer(_controller),
                              // شريط التحكم
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: const VideoProgressColors(
                                    playedColor: Color(0xFF0D47A1),
                                    bufferedColor: Colors.grey,
                                    backgroundColor: Colors.white24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // معلومات الفيديو
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'فيديو تعليمي - فلاتر',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'مقطع فيديو تعليمي يوضح أساسيات تطوير التطبيقات باستخدام فلاتر',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('جاري تحميل الفيديو...'),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          
          // أزرار التحكم
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر الترجيع
                IconButton(
                  onPressed: () {
                    final currentPosition = _controller.value.position;
                    final newPosition = currentPosition - const Duration(seconds: 10);
                    _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
                  },
                  icon: const Icon(Icons.replay_10),
                  iconSize: 32,
                ),
                
                // زر التشغيل/الإيقاف
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D47A1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _togglePlayPause,
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    iconSize: 32,
                  ),
                ),
                
                // زر التقديم
                IconButton(
                  onPressed: () {
                    final currentPosition = _controller.value.position;
                    final newPosition = currentPosition + const Duration(seconds: 10);
                    final duration = _controller.value.duration;
                    _controller.seekTo(newPosition < duration ? newPosition : duration);
                  },
                  icon: const Icon(Icons.forward_10),
                  iconSize: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

