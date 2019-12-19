/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:50:53
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-18 14:08:07
 * @Description: 首页
 * @FilePath: /unicom_flutter/lib/pages/homePage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/pages/alarmPage.dart';
import 'package:unicom_flutter/pages/orderPage.dart';
import 'package:unicom_flutter/utils/imagse.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;
  List<Widget> pageList = [OrderPage(), AlarmPage()];
  List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(
        icon: Image.asset(orderDefault),
        activeIcon: Image.asset(orderActive),
        title: Text('工单')),
    BottomNavigationBarItem(
        icon: Image.asset(alarmDefault),
        activeIcon: Image.asset(alarmActive),
        title: Text('通知'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        currentIndex: current,
        unselectedFontSize: 14,
        onTap: (int index) {
          setState(() {
            current = index;
          });
        },
      ),
      body: IndexedStack(
        index: current,
        children: pageList,
      ),
    );
  }
}
