import 'package:connect_me_app/features/home/home_page.dart';
import 'package:connect_me_app/features/list/list_screen.dart';
import 'package:connect_me_app/features/saved/saved_screen.dart';
import 'package:connect_me_app/features/search/search_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const HomePage(),
    const SaavedScreen(),
    const SearchScreen(),
    const ListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Saved'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            ],
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width /
                _pages.length *
                _selectedIndex,
            child: Container(
              width: MediaQuery.of(context).size.width / _pages.length,
              height: 2,
              color: Colors.purple.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
