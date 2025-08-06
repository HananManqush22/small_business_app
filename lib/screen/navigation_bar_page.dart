import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/screen/add_project_page.dart';
import 'package:small_business_app/screen/home_page.dart';
import 'package:small_business_app/screen/calendar_page.dart';
import 'package:small_business_app/screen/show_clients_page.dart';
import 'package:small_business_app/screen/statistically_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key, this.selectedIndex = 0});
  final int selectedIndex;
  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  final List<Widget> _page = const [
    HomePage(),
    StatisticallyPage(),
    AddProjectPage(),
    CalendarPage(),
    ShowClientsPage(),
  ];
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: primaryFont,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.pie_chart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
