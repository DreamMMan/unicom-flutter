/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:50:53
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-13 11:10:54
 * @Description: 首页
 * @FilePath: /unicom_flutter/lib/pages/homePage.dart
 */
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/pages/alarmPage.dart';
import 'package:unicom_flutter/pages/orderPage.dart';
import 'package:unicom_flutter/providers/homeProvide.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pageList = [OrderPage(), AlarmPage()];
  List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(
        icon: MyAsset(
          name: MyConstant.orderDefault,
          width: 50,
        ),
        activeIcon: MyAsset(
          name: MyConstant.orderActive,
          width: 50,
        ),
        title: Text('工单')),
    BottomNavigationBarItem(
        icon: MyAsset(
          name: MyConstant.alarmDefault,
          width: 50,
        ),
        activeIcon: MyAsset(
          name: MyConstant.alarmActive,
          width: 50,
        ),
        title: Text('通知'))
  ];

  DateTime lastPopTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          Utils.showToast('再试一次退出');
          setState(() {
            lastPopTime = DateTime.now();
          });
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Provide<HomeProvide>(
        builder: (context, child, data) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: tabs,
              currentIndex: data.current,
              unselectedFontSize: 14,
              onTap: (int index) {
                Provide.value<HomeProvide>(context).setCurrent(index);
              },
            ),
            body: IndexedStack(
              index: data.current,
              children: pageList,
            ),
          );
        },
      ),
    );
  }
}
