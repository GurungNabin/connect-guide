

import 'package:connect_me_app/presentation/view/features/home/home_page.dart';
import 'package:connect_me_app/presentation/view/features/list/list_screen.dart';
import 'package:connect_me_app/presentation/view/features/saved/saved_screen.dart';
import 'package:connect_me_app/presentation/view/features/search/search_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SavedScreen(),
    const SearchScreen(),
    const ListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / _pages.length;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF785ef6),
            unselectedItemColor: Colors.grey,
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
            left: itemWidth * _selectedIndex + itemWidth / 2 - (itemWidth / 4),
            child: Container(
              width: itemWidth / 2,
              height: 2,
              color: const Color(0xFF785ef6),
            ),
          ),
        ],
      ),
    );
  }
}
