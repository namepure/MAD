import 'package:flutter/material.dart';
import 'package:ui/project/professor.dart';

import '../firebase/crud_demo.dart';
import 'Contact_Screen.dart';
import 'ProfileProfessor.dart';
import 'calendar.dart';

class ProfessorNavr extends StatefulWidget {
  @override
  _ProfessorNavrState createState() => _ProfessorNavrState();
}

class _ProfessorNavrState extends State<ProfessorNavr> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ProfessorPage(),
    Calendar(),
    Contact_Page(),
    ProfileProfessor(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            backgroundColor: Color(0xFF7d2923),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
            ),
            backgroundColor: Color(0xFF7d2923),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper,
            ),
            backgroundColor: Color(0xFF7d2923),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            backgroundColor: Color(0xFF7d2923),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
