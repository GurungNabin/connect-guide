import 'package:flutter/material.dart';

class SearchBarList extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchBarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0, // Set the elevation
      borderRadius: BorderRadius.circular(8.0), // Set the border radius
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Set the background color to white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search',
        ),
      ),
    );
  }
}
