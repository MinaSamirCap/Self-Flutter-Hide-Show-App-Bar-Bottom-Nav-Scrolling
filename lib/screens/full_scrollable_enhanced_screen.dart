import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/full_scrollable_content_screen.dart';

class FullScrollableEnhancedScreen extends StatefulWidget {
  static const routeName = "full-scrollable-enhanced-screen";

  const FullScrollableEnhancedScreen({Key? key}) : super(key: key);

  @override
  State<FullScrollableEnhancedScreen> createState() =>
      _FullScrollableEnhancedScreenState();
}

class _FullScrollableEnhancedScreenState
    extends State<FullScrollableEnhancedScreen> with TickerProviderStateMixin {
  final String title = "Full Scrollable Enhanced Screen";
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullScrollableContentScreen(
      titleWidget: Text(title),
      delegate: _buildListDelegate(),
      scrollController: null,
      bottomNavigationBar: buildBottomNavigation(),
      bottomAppBarWidget: buildTabBar(_tabController),
      floatActionButton: _buildFloatActionBtn(),
    );
  }

  SliverChildBuilderDelegate _buildListDelegate() {
    return SliverChildBuilderDelegate((ctx, index) {
      return Container(
        // check if it the last item in list
        margin: EdgeInsets.only(bottom: index == 59 ? 0 : 8),
        child: buildCard("item $index"),
      );
    }, childCount: 60);
  }

  FloatingActionButton _buildFloatActionBtn() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: "LOL P:",
      child: const Icon(Icons.height),
    );
  }
}
