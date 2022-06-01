import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';

class AppBarWithTabsScreen extends StatefulWidget {
  static const routeName = "app-bar-with-tabs-screen";

  const AppBarWithTabsScreen({Key? key}) : super(key: key);

  @override
  State<AppBarWithTabsScreen> createState() => _AppBarWithTabsScreenState();
}

class _AppBarWithTabsScreenState extends State<AppBarWithTabsScreen> {
  String title = "App Bar With Tabs";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
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
                  pinned: false,
                  forceElevated: innerBoxIsScrolled,
                  bottom: buildTabBar(null),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildListBody("Home Page"),
              _buildListBody("Feed Page"),
              _buildListBody("Profile Page"),
              _buildListBody("Setting Page")
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: "Dummy",
          child: const Icon(Icons.title),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _buildListBody(String txt) {
    print("FullScrollable, buildListBody");
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
}

/// main steps
/// 1- wrap the body of scaffold in a NestedScrollView ...
/// 2- convert AppBar to SliverAppBar ...
///
/// to enable the app bar to float while we are scrolling
/// 1- in the SliverAppBar we need to set [floating: true]
/// 2- Also in NestedScrollView we need to set [floatHeaderSlivers: true]
///
/// if we want the app bar to snap we need to set [snap: true]
/// if we need to set snap to true we have to set float to true also ...
///
/// if we want the app bar only snip after user leave the touch of the scrolling
/// in NestedScrollView we need to remove [floatHeaderSlivers: true]
///
/// After adding the needed widgets to build a tab bar in app
/// adding [DefaultTabController, TabBar, TabBarView]
/// if we want the tabs to be pinned while scrolling ...
/// in SliverAppBar we need to set [pinned: true]
///
///
/// we have an issue now because we use ListView the scroll behavior
/// will not be good between pages, you will find the page already scrolled
/// to a position if you move from one page to another ...
///
/// To solve it, we need to replace ListView
/// with SliverList and wrap it in CustomScrollView
/// Also, we can warp the SliverList in SliverPadding to enhance UI.
/// Now all children are from sliver type so we can solve the overlap issue.
///
/// 1- You have to wrap the the header with SliverOverlapAbsorber like below
/// SliverOverlapAbsorber(
///        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
///        sliver: SliverSafeArea(
///            sliver: SliverAppBar(
/// do not forget to pass the handler as above ...
///
/// 2- in the CustomScrollView that takes slivers
/// You need to add SliverOverlapInjector like below
/// CustomScrollView(slivers: [
///        SliverOverlapInjector(
///           handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
///        SliverPadding(
/// do not forget to pass the handler like above ...
///
/// 3- you need to wrap the CustomScrollView in Builder Widget to pass the
/// right context the the handler for correct injection.
///
/// 4- warp all in SafeArea .. to good view .. and fix issues on iOS
///
/// in the last add this [forceElevated: innerBoxIsScrolled] to the SliverAppBar
/// to see the elevation of the app bar if you scrolled up or down ...

/// reference ...
/// https://www.youtube.com/watch?v=xzPXqQ-Pe2g
/// https://www.youtube.com/watch?v=LUqDNnv_dh0&ab_channel=Flutter
/// https://www.raywenderlich.com/19539821-slivers-in-flutter-getting-started
