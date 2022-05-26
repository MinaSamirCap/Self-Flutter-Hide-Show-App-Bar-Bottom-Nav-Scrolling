import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/full_scrollable_content_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/scroll_to_hide_widget.dart';

class ScrollingListenerScreen extends StatefulWidget {
  static const routeName = "scrolling-listener-screen";

  const ScrollingListenerScreen({Key? key}) : super(key: key);

  @override
  State<ScrollingListenerScreen> createState() =>
      _ScrollingListenerScreenState();
}

class _ScrollingListenerScreenState extends State<ScrollingListenerScreen>
    with TickerProviderStateMixin {
  final String title = "Scrolling Listener Screen";
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullScrollableContentScreen(
        titleWidget: Text(title),
        delegate: _buildListDelegate(),
        scrollController: _scrollController,
        bottomAppBarWidget: buildTabBar(_tabController),
        bottomNavigationBar: null,
        floatActionButton: null,
      ),
      bottomNavigationBar: _buildBottomNavigation(),
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

  Widget _buildBottomNavigation() {
    return ScrollToHideWidget(
      scrollController: _scrollController,
      child: buildBottomNavigation(),
    );
  }
}
