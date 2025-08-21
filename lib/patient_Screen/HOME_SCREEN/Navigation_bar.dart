import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_application_1/patient_Screen/HOME_SCREEN/HOME_PAGE.dart';
import 'package:flutter_application_1/patient_Screen/HOME_SCREEN/Profile_SCreen.dart';
import 'package:flutter_application_1/patient_Screen/HOME_SCREEN/TIMES_DATE/ScheduleScreen.dart';

class NavigationBarrr extends StatefulWidget {
  const NavigationBarrr({super.key});

  @override
  NavigationBarrrrrState createState() => NavigationBarrrrrState();
}

class NavigationBarrrrrState extends State<NavigationBarrr> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    ProfileScreen(),
    HOME_SCREEN(),
     ScheduleScreen(),
    Center(child: Text('المتجر الالكتروني')),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.deepPurple,
        items: [
          TabItem(icon: Icons.person),
          TabItem(icon: Icons.home),

          TabItem(icon: Icons.notifications),
          TabItem(icon: Icons.store),
        ],
        initialActiveIndex: 1,
        onTap: (int index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
