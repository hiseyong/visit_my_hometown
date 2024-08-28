import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); // 저장된 유저네임 삭제
    await prefs.remove('authToken'); // 저장된 유저네임 삭제

    // 로그아웃 후 로그인 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const MainScreen(initialIndex: 2), // HomeScreen의 인덱스가 2라고 가정
      ),
    );
  }

  Future<String> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Info'),
      ),
      body: FutureBuilder<String>(
        future: _getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load user info'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username: ${snapshot.data}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
