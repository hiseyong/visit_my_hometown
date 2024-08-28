import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final url = Uri.parse('http://chanovation.store/login');
    final username = _usernameController.text;
    final password = _passwordController.text;
    print('username: $username, password: $password');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // JSON 형식으로 헤더 설정
        },
        body: json.encode({
          'email': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String token = responseData['token']; // 응답에서 토큰 추출

        SharedPreferences prefs = await SharedPreferences.getInstance();

        // 로그인 토큰을 SharedPreferences에 저장
        await prefs.setString('authToken', token);
        await prefs.setString('username', username);

        // 홈 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const MainScreen(initialIndex: 2), // HomeScreen의 인덱스가 2라고 가정
          ),
        );
      } else {
        // 로그인 실패 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 실패: ${response.body}')),
        );
      }
    } catch (error) {
      // 예외 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('에러 발생: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController, // 아이디 입력받기
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: '아이디',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController, // 비밀번호 입력받기
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: '비밀번호',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      _login(context);
                    }, // 로그인 함수 호출
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 80.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // 비밀번호 찾기 로직
                    },
                    child: const Text(
                      '비밀번호를 잊으셨나요?',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
