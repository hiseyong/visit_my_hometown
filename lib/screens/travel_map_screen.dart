import 'package:flutter/material.dart';
import '../widgets/kakao_map.dart';

class TravelMapScreen extends StatelessWidget {
  const TravelMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: KakaoMapWidget(),
    );
  }
}
