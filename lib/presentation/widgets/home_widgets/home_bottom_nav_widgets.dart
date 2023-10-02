import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationWidget extends StatelessWidget {
  final int selectIndex;
  Function(int index) onTabChange;
  HomeBottomNavigationWidget(
      {super.key, required this.selectIndex, required this.onTabChange});

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      index: selectIndex,
      height: 70.0,
      items: const <Widget>[
        Icon(Icons.home_outlined, size: 30),
        Icon(Icons.task_outlined, size: 30),
        Icon(Icons.category_outlined, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        onTabChange(index);
      },
      letIndexChange: (selectIndex) => true,
    );
  }
}
