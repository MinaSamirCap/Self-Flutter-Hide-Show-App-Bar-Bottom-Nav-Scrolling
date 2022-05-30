import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/extendable/full_scrollable_full_custom_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';

class FullScrollableFullDifferentListItemsScreen extends StatefulWidget {
  static const routeName = "full-scrollable-full-different-list-items-screen";

  const FullScrollableFullDifferentListItemsScreen({Key? key})
      : super(key: key);

  @override
  State<FullScrollableFullDifferentListItemsScreen> createState() =>
      _FullScrollableFullDifferentListItemsScreenState();
}

class _FullScrollableFullDifferentListItemsScreenState
    extends State<FullScrollableFullDifferentListItemsScreen>
    with TickerProviderStateMixin {
  final String title = "Full Scrollable Full Different List Items";
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullScrollableFullCustomScreen(
      titleWidget: Text(title),
      delegate: _buildListDelegate(),
      scrollController: null,
      bottomNavigationBar: buildBottomNavigation(),
      bottomAppBarWidget: buildTabBar(_tabController),
      floatActionButton: _buildFloatActionBtn(),
      actions: buildToolbarIcons(),
      showCenterLoading: false,
      showNoData: false,
      supportPaging: false,
      reachedEndOfScroll: () {},
      swipedToRefresh: () {},
    );
  }

  SliverChildListDelegate _buildListDelegate() {
    return SliverChildListDelegate([
      _buildContainerColor(Colors.green),
      _buildContainerIcon(Icons.abc),
      _buildContainerIcon(Icons.clear),
      _buildContainerColor(Colors.black12),
      _buildContainerIcon(Icons.event),
      _buildContainerColor(Colors.yellow),
      _buildContainerColor(Colors.blueGrey),
      _buildContainerIcon(Icons.call),
      _buildContainerColor(Colors.cyan),
    ]);
  }

  FloatingActionButton _buildFloatActionBtn() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: "Refresh",
      child: const Icon(Icons.list),
    );
  }

  Widget _buildContainerColor(Color color) {
    return Container(
      color: color,
      height: 120,
      // check if it the last item in list
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: buildCard("item 1"),
    );
  }

  Widget _buildContainerIcon(IconData icon) {
    return Container(
      height: 80,
      // check if it the last item in list
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Center(child: Icon(icon)),
    );
  }
}
