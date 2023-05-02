import 'package:dttproperties/Icons/custom_icons_icons.dart';
import 'package:dttproperties/AppManagement/Shared.dart';
import 'package:flutter/material.dart';

import '../../Pages/Main/HomePage.dart';
import '../../Pages/Main/InformationPage.dart';

class NavigationManager extends StatefulWidget {
  const NavigationManager({super.key});

  @override
  State<NavigationManager> createState() => _NavigationManagerState();
}

class _NavigationManagerState extends State<NavigationManager> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Colors.transparent),
        child: NavigationBar(
          backgroundColor: primaryColor,
          elevation: 5,
          height: MediaQuery.of(context).size.height * 0.08,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(CustomIcons.home, color: inactiveColor),
              selectedIcon: Icon(CustomIcons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(CustomIcons.info, color: inactiveColor),
              selectedIcon: Icon(CustomIcons.info),
              label: 'Information',
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) => setState(() {
            _selectedIndex = index;
          }),
        ),
      ),
      body: [
        const HomePage(),
        const InformationPage(),
      ][_selectedIndex],
    );
  }
}