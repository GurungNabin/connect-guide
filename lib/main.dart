import 'package:connect_me_app/presentation/view/features/bottom_navigation/mybottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primaryColor:Colors.purple),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: BottomNavBar(),
    );
  }
}
