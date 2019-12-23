/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:50:53
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 10:27:40
 * @Description: 首页
 * @FilePath: /unicom_flutter/lib/pages/homePage.dart
 */

import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/pages/alarmPage.dart';
import 'package:unicom_flutter/pages/orderPage.dart';
import 'package:unicom_flutter/utils/constant.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;
  List<Widget> pageList = [OrderPage(), AlarmPage()];
  List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(
        icon: MyAsset(
          name: Constant.orderDefault,
          width: 50,
        ),
        activeIcon: MyAsset(
          name: Constant.orderActive,
          width: 50,
        ),
        title: Text('工单')),
    BottomNavigationBarItem(
        icon: MyAsset(
          name: Constant.alarmDefault,
          width: 50,
        ),
        activeIcon: MyAsset(
          name: Constant.alarmActive,
          width: 50,
        ),
        title: Text('通知'))
  ];

  // 网络监测
  Stream<ConnectivityResult> connectChangeListener() async* {
    final Connectivity connectivity = Connectivity();
    await for (ConnectivityResult result
        in connectivity.onConnectivityChanged) {
      yield result;
    }
  }

  StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = connectChangeListener().listen(
      (ConnectivityResult connectivityResult) {
        if (!mounted) {
          return;
        }
        if (connectivityResult == ConnectivityResult.none) {
          BotToast.showText(text: '请检查网络连接！');
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

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
