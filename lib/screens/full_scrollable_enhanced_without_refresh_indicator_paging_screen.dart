import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/extendable/full_scrollable_content_refresh_indicator_paging_screen.dart';

class FullScrollableEnhancedWithoutRefreshIndicatorPagingScreen
    extends StatefulWidget {
  static const routeName =
      "full-scrollable-enhanced-without-refresh-indicator-paging-screen";

  const FullScrollableEnhancedWithoutRefreshIndicatorPagingScreen({Key? key})
      : super(key: key);

  @override
  State<FullScrollableEnhancedWithoutRefreshIndicatorPagingScreen>
      createState() =>
          _FullScrollableEnhancedWithoutRefreshIndicatorPagingScreenState();
}

class _FullScrollableEnhancedWithoutRefreshIndicatorPagingScreenState
    extends State<FullScrollableEnhancedWithoutRefreshIndicatorPagingScreen>
    with TickerProviderStateMixin {
  final String title = "With Refresh Indicator Paging Screen";
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullScrollableContentRefreshIndicatorPagingScreen(
      titleWidget: Text(title),
      delegate: _buildListDelegate(),
      supportPaging: false,
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
