import 'package:flutter/material.dart';

Widget buildSeparator(int index) {
  return const SizedBox(height: 8);
}

Widget buildCard(String txt) {
  return Card(
      child: Container(padding: const EdgeInsets.all(15), child: Text(txt)));
}

TabBar buildTabBar() {
  return const TabBar(
      indicatorColor: Colors.white,
      indicatorWeight: 5,
      tabs: [
        Tab(icon: Icon(Icons.home), text: "Home"),
        Tab(icon: Icon(Icons.list_alt), text: "Feed"),
        Tab(icon: Icon(Icons.person), text: "Profile"),
        Tab(icon: Icon(Icons.settings), text: "Settings"),
      ]);
}

Widget buildBottomNavigation() {
  return BottomNavigationBar(items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Fav"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
  ]);
}
