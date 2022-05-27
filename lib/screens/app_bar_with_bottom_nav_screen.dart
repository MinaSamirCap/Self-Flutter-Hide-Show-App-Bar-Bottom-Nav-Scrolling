import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/scroll_to_hide_widget.dart';

class AppBarWithBottomNavScreen extends StatefulWidget {
  static const routeName = "app-bar-with-bottom-nav-screen";

  const AppBarWithBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<AppBarWithBottomNavScreen> createState() =>
      _AppBarWithBottomNavScreenState();
}

class _AppBarWithBottomNavScreenState extends State<AppBarWithBottomNavScreen> {
  final String title = "App Bar With Bottom Nav";

  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
          controller: scrollController,
          itemBuilder: (ctx, index) => buildCard("Item: $index"),
          separatorBuilder: (ctx, index) => buildSeparator(index),
          itemCount: 100),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return ScrollToHideWidget(
      scrollController: scrollController,
      child: buildBottomNavigation(),
    );
  }
}

/// the main idea here is to enable the list view and bottom navigation
/// to have the same controller ...
/// with another format, we need to enable the bottom navigation to listen
/// to the scrolling of the list to hide and show it ...
