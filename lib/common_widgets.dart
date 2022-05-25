import 'package:flutter/material.dart';

Widget buildSeparator(int index) {
  return const SizedBox(height: 8);
}

Widget buildCard(String txt) {
  return Card(
      child: Container(padding: const EdgeInsets.all(15), child: Text(txt)));
}
