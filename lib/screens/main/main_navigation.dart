import 'package:flutter/material.dart';
import 'package:personal_area_app/screens/cabinet/screen.dart';
import 'package:personal_area_app/screens/list/screen.dart';

class MainNavigation extends StatefulWidget {
  final String email;
  MainNavigation({required this.email});
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  var _currentIndex = 0;
  var _pages;

  @override
  void initState() {
    _pages = [
      ListScreen(),
      CabinetScreen(
        email: widget.email,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dehaze),
            label: "Список",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Кабинет",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}
