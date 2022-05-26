import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/scroll_to_hide_widget.dart';

class FullScrollableContentScreen extends StatefulWidget {
  final Widget titleWidget;
  final SliverChildDelegate delegate;
  final ScrollController? scrollController;
  final PreferredSizeWidget? bottomAppBarWidget;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatActionButton;
  final Function(bool)? shouldShowFabCallback;

  const FullScrollableContentScreen(
      {required this.titleWidget,
      required this.delegate,
      this.scrollController,
      this.bottomAppBarWidget,
      this.actions,
      this.bottomNavigationBar,
      this.floatActionButton,
      this.shouldShowFabCallback,
      Key? key})
      : super(key: key);

  @override
  State<FullScrollableContentScreen> createState() =>
      _FullScrollableContentScreenState();
}

class _FullScrollableContentScreenState
    extends State<FullScrollableContentScreen> {
  bool _isFabVisible = true;
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (ctx, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverAppBar(
                title: widget.titleWidget,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                bottom: widget.bottomAppBarWidget,
                actions: widget.actions,
              ),
            ),
          ),
        ],
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (widget.floatActionButton != null) {
              _applyLogicToHideOrShowFloatActionBtn(notification);
            } else {
              _fireFabCallback(notification);
            }

            /// Return true to cancel the notification bubbling. Return false to allow the
            /// notification to continue to be dispatched to further ancestors.
            return false;
          },
          child: _buildListBody(),
        ),
      ),
      floatingActionButton: _isFabVisible ? widget.floatActionButton : null,
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget? _buildBottomNavigation() {
    if (widget.bottomNavigationBar != null) {
      return ScrollToHideWidget(
        scrollController: scrollController,
        child: widget.bottomNavigationBar!,
      );
    } else {
      return null;
    }
  }

  Widget _buildListBody() {
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
              delegate: widget.delegate,
            ),
          )
        ]);
      }),
    );
  }

  void _applyLogicToHideOrShowFloatActionBtn(
      UserScrollNotification notification) {
    if (_isScrollingToTop(notification)) {
      if (!_isFabVisible) setState(() => _isFabVisible = true);
    } else if (_isScrollingToBottom(notification)) {
      if (_isFabVisible) setState(() => _isFabVisible = false);
    }
  }

  bool _isScrollingToTop(UserScrollNotification notification) =>
      notification.direction == ScrollDirection.forward;

  bool _isScrollingToBottom(UserScrollNotification notification) =>
      notification.direction == ScrollDirection.reverse;

  void _fireFabCallback(UserScrollNotification notification) {
    if (widget.shouldShowFabCallback != null) {
      if (_isScrollingToTop(notification)) {
        widget.shouldShowFabCallback!(true);
      } else if (_isScrollingToBottom(notification)) {
        widget.shouldShowFabCallback!(false);
      }
    }
  }
}
