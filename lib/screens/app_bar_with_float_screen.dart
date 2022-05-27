import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';

class AppBarWithFloatScreen extends StatefulWidget {
  static const routeName = "app-bar-with-float-screen";

  const AppBarWithFloatScreen({Key? key}) : super(key: key);

  @override
  State<AppBarWithFloatScreen> createState() => _AppBarWithFloatScreenState();
}

class _AppBarWithFloatScreenState extends State<AppBarWithFloatScreen> {
  final String title = "App Bar With Tabs";

  bool isFabVisible = true;

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
        )
      ],
      body: Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            _applyLogicToHideFloatActionBtn(notification);
            /// Return true to cancel the notification bubbling. Return false to allow the
            /// notification to continue to be dispatched to further ancestors.
            return false;
          },
          child: ListView.separated(
              itemBuilder: (ctx, index) => buildCard("Item: $index"),
              separatorBuilder: (ctx, index) => buildSeparator(index),
              itemCount: 100),
        ),
        floatingActionButton: isFabVisible ? _buildFloatActionBtn() : null,
      ),
    ));
  }

  Widget _buildFloatActionBtn() {
    return FloatingActionButton(
      child: const Icon(Icons.ac_unit_sharp),
      onPressed: () {},
    );
  }

  void _applyLogicToHideFloatActionBtn(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.forward) {
      if (!isFabVisible) setState(() => isFabVisible = true);
    } else if (notification.direction == ScrollDirection.reverse) {
      if (isFabVisible) setState(() => isFabVisible = false);
    }
  }
}


/// reference ...
/// https://www.youtube.com/watch?v=Zs3D6vs7h-k