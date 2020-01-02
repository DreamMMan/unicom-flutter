/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:49:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 15:47:48
 * @Description: 工单列表页面
 * @FilePath: /unicom_flutter/lib/pages/orderPage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/pages/orderList/lifeList.dart';
import 'package:unicom_flutter/pages/orderList/planList.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicom_flutter/widgets/common/myTabs.dart';
import 'package:unicom_flutter/widgets/common/showBottomSheet.dart';
import 'package:unicom_flutter/routes/application.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('联通智慧机房工单系统'),
      body: Container(
        child: Column(
          children: <Widget>[
            _userInfo(),
            MyTabs(
                tabs: ['作业计划工单', '生命周期工单'],
                listWidget: [PlanList(), LifeList()])
          ],
        ),
      ),
    );
  }

  // 用户信息栏
  Widget _userInfo() {
    return WatchBoxBuilder(
      box: Utils.unicomBox(),
      builder: (context, box) {
        return InkWell(
          onTap: () {
            showModal(context);
          },
          child: Container(
            height: MyScreen.setHeight(88),
            padding: MyScreen.setEdge(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyAsset(
                  name: MyConstant.userIcon,
                  width: 34,
                ),
                Expanded(
                  child: Padding(
                    padding: MyScreen.setEdge(left: 15),
                    child: Text(
                      box.get('username'),
                      style: MyStyles.f30c66,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: MyScreen.setWidth(46),
                  color: MyStyles.c999,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // 底部选项卡
  showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: MyStyles.d9DEE1,
        builder: (BuildContext context) {
          return ShowBottomSheet(
            list: [
              {'name': '退出登录'},
            ],
            closeName: '取消',
            tap: (data) async {
              var box = await Utils.unicomBox();
              box.delete('token');
              Application.router.navigateTo(context, '/login', replace: true);
            },
          );
        });
  }
}
