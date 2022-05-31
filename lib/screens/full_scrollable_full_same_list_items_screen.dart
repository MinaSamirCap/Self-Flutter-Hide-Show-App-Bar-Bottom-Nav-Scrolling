import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/extendable/full_scrollable_full_custom_fixed_item_list_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';

class FullScrollableFullSameListItemsScreen extends StatefulWidget {
  static const routeName = "full-scrollable-full-same-list-items-screen";

  const FullScrollableFullSameListItemsScreen({Key? key}) : super(key: key);

  @override
  State<FullScrollableFullSameListItemsScreen> createState() =>
      _FullScrollableFullSameListItemsScreenState();
}

class _FullScrollableFullSameListItemsScreenState
    extends State<FullScrollableFullSameListItemsScreen>
    with TickerProviderStateMixin {
  final String title = "Full Scrollable Full Same List Items";
  late TabController _tabController;

  List<String> listOfData = [];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    listOfData.addAll(generateItems(100));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullScrollableFullCustomFixedItemListScreen(
      titleWidget: Text(title),
      sliverMultiBoxAdaptorWidget: _buildListDelegate(),
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

  SliverFixedExtentList _buildListDelegate() {
    return SliverFixedExtentList(
        itemExtent: 178,
        delegate: SliverChildBuilderDelegate((ctx, index) {
          return Container(
            // check if it the last item in list
            margin:
                EdgeInsets.only(bottom: index == listOfData.length - 1 ? 0 : 8),
            child: buildCard("item ${listOfData[index]}"),
          );
        }, childCount: listOfData.length));
  }

  FloatingActionButton _buildFloatActionBtn() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: "Refresh",
      child: const Icon(Icons.list),
    );
  }

  List<String> generateItems(int size) {
    List<String> list = [];
    for (int i = 0; i < size; i++) {
      list.add(i.toString());
    }
    return list;
  }
}
