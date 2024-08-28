import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getString('username') != null;
    });
  }

  void _permission() async {
    print(await Permission.location.isGranted); // 위치 권한 요청
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Contribute',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Travel Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(_isLoggedIn ? Icons.person : Icons.login),
          label: _isLoggedIn ? 'My Info' : 'Login',
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[800], // 기본 색깔을 진한 회색으로 설정
      onTap: (index) {
        if (index == 4 && _isLoggedIn) {
          // My Info (index가 4인 탭) 클릭 시 MyInfoScreen으로 이동
          widget.onTap(4);
        } else {
          widget.onTap(index); // 인덱스 전달
        }
      },
    );
  }
}
