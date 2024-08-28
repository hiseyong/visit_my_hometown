import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onSearchIconTapped;
  final VoidCallback onMenuIconTapped;

  const CustomAppBar({
    super.key,
    required this.onSearchIconTapped,
    required this.onMenuIconTapped,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Welcome, $_username!'),
      elevation: 4.0, // 박스 그림자 효과
      shadowColor: Colors.grey, // 그림자 색깔
      backgroundColor: const Color(0xFFF3E9DC), // 앱바 배경색
      titleTextStyle: const TextStyle(
        color: Colors.black, // 제목 텍스트 색깔
        fontWeight: FontWeight.bold, // 제목 텍스트 두께
      ),
      iconTheme: const IconThemeData(color: Colors.black), // 아이콘 색깔
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: widget.onSearchIconTapped,
        ),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: widget.onMenuIconTapped,
        ),
      ],
    );
  }
}
