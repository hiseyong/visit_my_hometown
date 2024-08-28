import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart';

class ContributeScreen extends StatelessWidget {
  const ContributeScreen({super.key});

  Future<void> _checkToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      // token이 없으면 모달 창을 띄움
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Required'),
            content: const Text('You need to log in to contribute.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // 모달 창 닫기
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(
                          initialIndex: 2), // HomeScreen의 인덱스가 2라고 가정
                    ),
                  );
                },
              ),
              TextButton(
                child: const Text('Login'),
                onPressed: () {
                  Navigator.of(context).pop(); // 모달 창 닫기
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(
                          initialIndex: 4), // HomeScreen의 인덱스가 2라고 가정
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build 단계에서 token을 체크합니다.
    _checkToken(context);

    return const Center(
      child: NativePluginWidget(),
    );
  }
}

class NativePluginWidget extends StatefulWidget {
  const NativePluginWidget({super.key});

  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {
  String? latitude;
  String? longitude;

  getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getGeoData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: (<Widget>[
          const Text(
            'MyLocation',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'latitude : $latitude',
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'longitude: $longitude',
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ]),
      ),
    );
  }
}
