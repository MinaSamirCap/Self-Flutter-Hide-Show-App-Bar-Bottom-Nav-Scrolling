import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/scroll_to_hide_widget.dart';

class AppBarWithTabsBottomNavFabScreen extends StatefulWidget {
  static const routeName = "app-bar-with-tabs-bottom-nav-fab-screen";

  const AppBarWithTabsBottomNavFabScreen({Key? key}) : super(key: key);

  @override
  State<AppBarWithTabsBottomNavFabScreen> createState() =>
      _AppBarWithTabsBottomNavFabScreenState();
}

class _AppBarWithTabsBottomNavFabScreenState
    extends State<AppBarWithTabsBottomNavFabScreen> {
  String title = "App Bar With Tabs And Bottom Nav Fab";

  late ScrollController scrollController;
  bool isFabVisible = true;

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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          controller: scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (ctx, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  title: Text(title),
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: buildTabBar(),
                ),
              ),
            ),
          ],
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              _applyLogicToHideFloatActionBtn(notification);

              /// Return true to cancel the notification bubbling. Return false to allow the
              /// notification to continue to be dispatched to further ancestors.
              return false;
            },
            child: TabBarView(
              children: [
                _buildListBody("Home Page"),
                _buildListBody("Feed Page"),
                _buildListBody("Profile Page"),
                _buildListBody("Setting Page")
              ],
            ),
          ),
        ),
        floatingActionButton: isFabVisible ? _buildFloatActionBtn() : null,
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildListBody(String txt) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (context) {
        return CustomScrollView(slivers: [
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return Container(
                  // check if it the last item in list
                  margin: EdgeInsets.only(bottom: index == 59 ? 0 : 8),
                  child: buildCard("item $index"),
                );
              }, childCount: 60),
            ),
          )
        ]);
      }),
    );
  }

  Widget _buildBottomNavigation() {
    return ScrollToHideWidget(
      scrollController: scrollController,
      child: buildBottomNavigation(),
    );
  }

  Widget _buildFloatActionBtn() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: "Dummy",
      child: const Icon(Icons.title),
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
