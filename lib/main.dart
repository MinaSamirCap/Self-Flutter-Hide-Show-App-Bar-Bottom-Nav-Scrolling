import 'package:flutter/material.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/app_bar_with_bottom_nav_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/app_bar_with_float_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/app_bar_with_tabs_bottom_nav_fab_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/app_bar_with_tabs_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/full_scrollable_enhanced_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/full_scrollable_enhanced_with_refresh_indicator_paging_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/full_scrollable_enhanced_without_refresh_indicator_paging_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/home_screen.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/screens/scrolling_listener_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        AppBarWithTabsScreen.routeName: (ctx) => const AppBarWithTabsScreen(),
        AppBarWithFloatScreen.routeName: (ctx) => const AppBarWithFloatScreen(),
        AppBarWithBottomNavScreen.routeName: (ctx) =>
            const AppBarWithBottomNavScreen(),
        AppBarWithTabsBottomNavFabScreen.routeName: (ctx) =>
            const AppBarWithTabsBottomNavFabScreen(),
        FullScrollableEnhancedScreen.routeName: (ctx) =>
            const FullScrollableEnhancedScreen(),
        ScrollingListenerScreen.routeName: (ctx) =>
            const ScrollingListenerScreen(),
        FullScrollableEnhancedWithRefreshIndicatorPagingScreen.routeName:
            (ctx) =>
                const FullScrollableEnhancedWithRefreshIndicatorPagingScreen(),
        FullScrollableEnhancedWithoutRefreshIndicatorPagingScreen.routeName:
            (ctx) =>
                const FullScrollableEnhancedWithoutRefreshIndicatorPagingScreen()
      },
    );
  }
}
