import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/contribute_screen.dart';
import 'screens/travel_map_screen.dart';
import 'screens/myinfo_screen.dart';
import 'screens/login_screen.dart';
import 'widgets/bottom_nav_bar.dart'; // 하단 네비게이션 바
import 'widgets/custom_app_bar.dart'; // 앱바
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  AuthRepository.initialize(
      appKey: '5067b7fa2d8bf5607ac6dcfaf2fab53c', baseUrl: 'http://localhost');
  runApp(const VisitMyHometownApp());
}

class VisitMyHometownApp extends StatelessWidget {
  const VisitMyHometownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visit My Hometown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex; // 초기 선택된 탭 인덱스를 받기 위한 변수

  const MainScreen({super.key, this.initialIndex = 2});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _selectedIndex = widget.initialIndex;
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getString('username') != null;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchIconTapped() {
    setState(() {
      _selectedIndex = 1; // Search Screen으로 이동
    });
  }

  void _onMenuIconTapped() {
    // Menu 아이콘을 탭했을 때 수행할 동작 (예: Drawer 열기)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menu icon tapped')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const ContributeScreen(),
      const SearchScreen(),
      const HomeScreen(),
      const TravelMapScreen(),
      _isLoggedIn ? const MyInfoScreen() : const LoginScreen(),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        onSearchIconTapped: _onSearchIconTapped,
        onMenuIconTapped: _onMenuIconTapped,
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
