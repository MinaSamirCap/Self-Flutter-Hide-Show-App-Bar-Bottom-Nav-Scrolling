import 'package:flutter/material.dart';

Widget buildSeparator(int index) {
  return const SizedBox(height: 8);
}

Widget buildCard(String txt) {
  return Card(
      child: Container(padding: const EdgeInsets.all(15), child: Text(txt)));
}

Widget buildBottomNavigation() {
  return BottomNavigationBar(items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Fav"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
  ]);
}
