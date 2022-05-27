import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/extendable/full_scrollable_full_custom_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/extendable/full_scrollable_content_refresh_indicator_paging_screen.dart';

class FullScrollableFullCustomSampleScreen extends StatefulWidget {
  static const routeName = "full-scrollable-full-custom-sample-screen";

  const FullScrollableFullCustomSampleScreen({Key? key}) : super(key: key);

  @override
  State<FullScrollableFullCustomSampleScreen> createState() =>
      _FullScrollableFullCustomSampleScreenState();
}

class _FullScrollableFullCustomSampleScreenState
    extends State<FullScrollableFullCustomSampleScreen>
    with TickerProviderStateMixin {
  final String title = "Full Scrollable Full Custom Sample";
  late TabController _tabController;

  List<String> listOfData = [];
  bool shouldShowPagingLoading = false;
  bool shouldShowCenterLoading = true;

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
      showCenterLoading: shouldShowCenterLoading,
      showNoData: false,
      supportPaging: true,
      showPagingLoader: shouldShowPagingLoading,
      reachedEndOfScroll: () {
        setState(() {
          shouldShowPagingLoading = true;
          _simulateApiCall();
        });
      },
      swipedToRefresh: () {
        setState(() {
          shouldShowPagingLoading = false;
          listOfData.clear();
          listOfData.addAll(generateItems(20, 0));
        });
      },
    );
  }

  SliverChildBuilderDelegate _buildListDelegate() {
    return SliverChildBuilderDelegate((ctx, index) {
      return Container(
        // check if it the last item in list
        margin: EdgeInsets.only(bottom: index == listOfData.length - 1 ? 0 : 8),
        child: buildCard("item ${listOfData[index]}"),
      );
    }, childCount: listOfData.length);
  }

  FloatingActionButton _buildFloatActionBtn() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          shouldShowCenterLoading = false;
        });
      },
      tooltip: "Refresh",
      child: const Icon(Icons.refresh),
    );
  }

  List<String> generateItems(int size, int startIndex) {
    List<String> list = [];
    for (int i = startIndex; i <= startIndex + size; i++) {
      list.add(i.toString());
    }
    return list;
  }

  void _simulateApiCall() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    listOfData.addAll(generateItems(10, listOfData.length - 1));
    shouldShowPagingLoading = false;
    setState(() {});
  }
}
