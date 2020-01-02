/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:50:53
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 15:46:44
 * @Description: 首页
 * @FilePath: /unicom_flutter/lib/pages/homePage.dart
 */

import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/pages/alarmPage.dart';
import 'package:unicom_flutter/pages/orderPage.dart';
import 'package:unicom_flutter/providers/homeProvide.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:connectivity/connectivity.dart';

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
    return Provide<HomeProvide>(
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
    );
  }
}
