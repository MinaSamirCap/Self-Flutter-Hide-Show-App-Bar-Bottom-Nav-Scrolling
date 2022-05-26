import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/full_scrollable_content_screen.dart';

class FullScrollableEnhancedRefreshIndicatorPagingScreen
    extends StatefulWidget {
  static const routeName =
      "full-scrollable-enhanced-refresh-indicator-paging-screen";

  const FullScrollableEnhancedRefreshIndicatorPagingScreen({Key? key})
      : super(key: key);

  @override
  State<FullScrollableEnhancedRefreshIndicatorPagingScreen> createState() =>
      _FullScrollableEnhancedRefreshIndicatorPagingScreenState();
}

class _FullScrollableEnhancedRefreshIndicatorPagingScreenState
    extends State<FullScrollableEnhancedRefreshIndicatorPagingScreen>
    with TickerProviderStateMixin {
  final String title =
      "Full Scrollable Enhanced Refresh Indicator Paging Screen";
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
      actions: buildToolbarIcons(),
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
      tooltip: "Refresh",
      child: const Icon(Icons.refresh),
    );
  }
}
