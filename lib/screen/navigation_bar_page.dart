import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/screen/add_project_page.dart';
import 'package:small_business_app/screen/home_page.dart';
import 'package:small_business_app/screen/message_page.dart';
import 'package:small_business_app/screen/show_clients_page.dart';
import 'package:small_business_app/screen/statistically_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int selectedIndex = 0;

  final List<Widget> _page = const [
    HomePage(),
    StatisticallyPage(),
    AddProjectPage(),
    MessagePage(),
    ShowClientsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: backgroundColor, boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ]),
        child: BottomNavigationBar(
          backgroundColor: backgroundColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: fillColor,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
