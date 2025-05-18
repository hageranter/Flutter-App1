import 'package:flutter/material.dart';
import 'package:myapp/dashboard/dashboard_screen.dart';
import 'package:myapp/favourite/favourite_screen.dart';
import 'package:myapp/new.dart';
import 'package:myapp/qoute/quote_screen.dart';

import '../profile_page/profile_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    QuoteScreen(), // ✅ class name matches fixed spelling
    FavouriteScreen(),
    ProfilePage(),
    AboutUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.format_quote),
            label: "Quote", // ✅ fix spelling from "Qoute"
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Favourite",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.info),
            label: "About Us",
          ),
        ],
      ),
    );
  }
}
