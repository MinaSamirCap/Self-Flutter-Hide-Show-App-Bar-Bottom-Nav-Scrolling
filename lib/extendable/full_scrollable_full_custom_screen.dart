import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/common_widgets.dart';
import 'package:self_flutter_hide_show_app_bar_bottom_nav_scrolling/helper/scroll_to_hide_widget.dart';

class FullScrollableFullCustomScreen extends StatefulWidget {
  /// main needed widgets ...
  final Widget titleWidget;
  final SliverChildDelegate delegate;

  /// app bar parameters ...
  final List<Widget>? actions;
  final PreferredSizeWidget? bottomAppBarWidget;

  /// scroll providing parameters for easy control from outside widget if needed ...
  final ScrollController? scrollController;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatActionButton;
  final Function(bool)? shouldShowFabCallback;

  /// pagination parameters ...
  final bool? showPagingLoader;
  final bool? supportPaging;
  final Function? swipedToRefresh;
  final Function? reachedEndOfScroll;

  /// loading and no data parameters ...
  final bool? showCenterLoading;
  final Widget? centerLoadingWidget;
  final bool? showNoData;
  final Widget? noDataWidget;

  /// list parameters ...
  final EdgeInsetsDirectional? listPadding;

  const FullScrollableFullCustomScreen(
      {required this.titleWidget,
      required this.delegate,
      this.actions,
      this.bottomAppBarWidget,
      this.scrollController,
      this.bottomNavigationBar,
      this.floatActionButton,
      this.shouldShowFabCallback,
      this.showPagingLoader = false,
      this.supportPaging = false,
      this.swipedToRefresh,
      this.reachedEndOfScroll,
      this.showCenterLoading = false,
      this.centerLoadingWidget,
      this.showNoData = false,
      this.noDataWidget,
      this.listPadding = const EdgeInsetsDirectional.all(12),
      Key? key})
      : super(key: key);

  @override
  State<FullScrollableFullCustomScreen> createState() =>
      _FullScrollableFullCustomScreenState();
}

class _FullScrollableFullCustomScreenState
    extends State<FullScrollableFullCustomScreen> {
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
        floatHeaderSlivers: _scrollableContent(),
        headerSliverBuilder: (ctx, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverAppBar(
                title: widget.titleWidget,
                floating: _scrollableContent(),
                snap: _scrollableContent(),
                pinned: !_scrollableContent(),
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
          child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (_isReachEndOfScrolling(notification)) {
                  widget.reachedEndOfScroll?.call();
                }
                return false;
              },
              child: _buildContentWidget()),
        ),
      ),
      floatingActionButton: _isFabVisible ? widget.floatActionButton : null,
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget? _buildBottomNavigation() {
    if (_scrollableContent()) {
      if (widget.bottomNavigationBar != null) {
        return ScrollToHideWidget(
          scrollController: scrollController,
          child: widget.bottomNavigationBar!,
        );
      } else {
        return null;
      }
    } else {
      return widget.bottomNavigationBar;
    }
  }

  Widget _buildContentWidget() {
    if (widget.showCenterLoading!) {
      return _centerLoadingWidget();
    }
    if (widget.showNoData!) {
      return _noDataWidget();
    }
    if (widget.supportPaging!) {
      return Column(
        children: [
          Expanded(
              child: RefreshIndicator(
                  onRefresh: () => _refresh(), child: _buildListBody())),
          pagingLoadingWidget(widget.showPagingLoader!)
        ],
      );
    } else {
      return _buildListBody();
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
            padding: widget.listPadding!,
            sliver: SliverList(
              delegate: widget.delegate,
            ),
          ),
        ]);
      }),
    );
  }

  Widget _centerLoadingWidget() {
    return Column(
      children: [
        widget.centerLoadingWidget ??
            const Expanded(child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _noDataWidget() {
    return Column(
      children: [
        widget.noDataWidget ??
            const Expanded(child: Center(child: Text("No Data P:"))),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  /// we use this function to know if the screen should act as a scrollable
  /// content to hide and show app bar, fab, bottom nav while scrolling
  /// or make all widget to be fixed on screen
  /// if the content is scrollable --> return true;
  /// if the screen is showing the center loading --> return false;
  /// if the screen is showing data value --> return false;
  bool _scrollableContent() =>
      !(widget.showCenterLoading! || widget.showNoData!);

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

  bool _isReachEndOfScrolling(ScrollNotification scrollInfo) {
    return (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent);
  }

  void _fireFabCallback(UserScrollNotification notification) {
    if (widget.shouldShowFabCallback != null) {
      if (_isScrollingToTop(notification)) {
        widget.shouldShowFabCallback!(true);
      } else if (_isScrollingToBottom(notification)) {
        widget.shouldShowFabCallback!(false);
      }
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 1500)).then((_) {});
    widget.swipedToRefresh?.call();
  }
}
