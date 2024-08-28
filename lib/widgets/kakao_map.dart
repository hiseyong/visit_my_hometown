import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KakaoMapWidget extends StatefulWidget {
  const KakaoMapWidget({super.key});

  @override
  _KakaoMapWidgetState createState() => _KakaoMapWidgetState();
}

class _KakaoMapWidgetState extends State<KakaoMapWidget> {
  @override
  void initState() {
    super.initState();
    _initializeKakaoMap();
  }

  Future<void> _initializeKakaoMap() async {
    AuthRepository.initialize(
      appKey: '5067b7fa2d8bf5607ac6dcfaf2fab53c',
      baseUrl: 'http://localhost',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kakao Map'),
      ),
      body: const Center(
        child: KakaoMap(), // Kakao Map 표시
      ),
    );
  }
}
