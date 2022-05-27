import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

Widget buildSeparator(int index) {
  return const SizedBox(height: 8);
}

Widget buildCard(String txt) {
  return Card(
      child: Container(padding: const EdgeInsets.all(15), child: Text(txt)));
}

TabBar buildTabBar(TabController? tabController) {
  return TabBar(
      controller: tabController,
      indicatorColor: Colors.white,
      indicatorWeight: 5,
      tabs: const [
        Tab(icon: Icon(Icons.home), text: "Home"),
        Tab(icon: Icon(Icons.list_alt), text: "Feed"),
        Tab(icon: Icon(Icons.person), text: "Profile"),
        Tab(icon: Icon(Icons.settings), text: "Settings"),
      ]);
}

Widget buildBottomNavigation() {
  return BottomNavigationBar(items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Fav"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
  ]);
}

List<Widget> buildToolbarIcons() {
  return <Widget>[
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
      tooltip: "Search",
    ),
    IconButton(
      onPressed: () {},
      icon: getNotificationIcon(5),
      tooltip: "Notification",
    ),
    buildPopupMenuBtn()
  ];
}

Widget getNotificationIcon(int counter) {
  return Badge(
      showBadge: (counter > 0) ? true : false,
      badgeContent: Text(
        counter.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: const Icon(Icons.notifications),
      badgeColor: Colors.red,
      position: BadgePosition.topEnd());
}

Widget buildPopupMenuBtn() {
  return PopupMenuButton<String>(
      tooltip: "Show Menu",
      onSelected: (item) {},
      itemBuilder: (ctx) => [buildCalendarPopup(), buildLogoutPopup()]);
}

PopupMenuItem<String> buildLogoutPopup() =>
    buildHomePopupWidget(Icons.exit_to_app, "Logout");

PopupMenuItem<String> buildCalendarPopup() =>
    buildHomePopupWidget(Icons.event, "Calendar");

PopupMenuItem<String> buildHomePopupWidget(IconData icon, String txt) {
  return PopupMenuItem<String>(
      value: txt,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(txt),
          const SizedBox(width: 15),
          Icon(icon, color: Colors.amber)
        ],
      ));
}

Widget pagingLoadingWidget(bool isLoading) {
  return AnimatedContainer(
    curve: Curves.fastOutSlowIn,
    padding: const EdgeInsets.all(10.0),
    height: isLoading ? 55.0 : 0,
    color: Colors.white,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
    duration: const Duration(milliseconds: 300),
  );
}
