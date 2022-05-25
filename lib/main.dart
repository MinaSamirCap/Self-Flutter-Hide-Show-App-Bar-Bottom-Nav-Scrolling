import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "Hide Show Appbar Bottom Nav";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (ctx, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(title),
            floating: true,
            snap: true,
          ),
        ],
        body: _buildListBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Dummy",
        child: const Icon(Icons.title),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildListBody() {
    return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (ctx, index) => _buildCard(index),
        separatorBuilder: (ctx, index) => _buildSeparator(index),
        itemCount: 60);
  }

  Widget _buildCard(int index) {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Text("item ${index + 1}")));
  }

  Widget _buildSeparator(int index) {
    return const SizedBox(height: 8);
  }
}

/// main steps
/// 1- wrap the body of scaffold in a NestedScrollView ...
/// 2- convert AppBar to SliverAppBar ...
///
/// to enable the app bar to float while we are scrolling
/// 1- in the SliverAppBar we need to set [floating: true]
/// 2- Also in NestedScrollView we need to set [floatHeaderSlivers: true]
///
/// if we want the app bar to snap we need to set [snap: true]
/// if we need to set snap to true we have to set float to true also ...
///
/// if we want the app bar only snip after user leave the touch of the scrolling
/// in NestedScrollView we need to remove [floatHeaderSlivers: true]
