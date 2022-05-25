import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/app_bar_with_tabs_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "home-screen";

  const HomeScreen({Key? key}) : super(key: key);
  final String title = "Hide Show Appbar Bottom Nav";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) => _buildTutorialCard(ctx, index),
          separatorBuilder: (ctx, index) => _buildSeparator(index),
          itemCount: 3),
    );
  }

  Widget _buildTutorialCard(BuildContext ctx, int index) {
    return InkWell(
        onTap: () {
          _openScreen(ctx, getRootName(index));
        },
        child: buildCard(getRootName(index)));
  }

  Widget _buildSeparator(int index) {
    return buildSeparator(index);
  }

  String getRootName(int index) {
    if (index == 0) {
      return AppBarWithTabsScreen.routeName;
    } else if (index == 1) {
      return AppBarWithTabsScreen.routeName;
    } else {
      return AppBarWithTabsScreen.routeName;
    }
  }

  void _openScreen(BuildContext ctx, String name) async {
    await Navigator.of(ctx).pushNamed(name);
  }
}
