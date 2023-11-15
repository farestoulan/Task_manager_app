import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_manager_app/config/app/my_app.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../../core/utils/styles/color/color_manger.dart';

class HomeBottomNavigationWidget extends StatelessWidget {
  final bool isDark;
  final int selectIndex;
  Function(int index) onTabChange;

  HomeBottomNavigationWidget({
    super.key,
    required this.selectIndex,
    required this.onTabChange,
    required this.isDark,
  });

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // bool isDark = CacheHelper.getData(key: 'isDark');
    // print('tesssst***********:${isDark}');
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      index: selectIndex,
      height: 70.0,
      items: const <Widget>[
        Icon(Icons.home_outlined, size: 30),
        Icon(Icons.task_outlined, size: 30),
        Icon(Icons.category_outlined, size: 30),
      ],
      color:
          // ColorManager.primary,
          isDark ? ColorManager.whiteColor : ColorManager.primary,
      buttonBackgroundColor:
          // ColorManager.primary,
          isDark ? ColorManager.whiteColor : ColorManager.primary,
      backgroundColor:
          //ColorManager.whiteColor,
          isDark ? HexColor('333739') : ColorManager.whiteColor,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        onTabChange(index);
      },
      letIndexChange: (selectIndex) => true,
    );
  }
}
