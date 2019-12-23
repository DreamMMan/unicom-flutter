/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:49:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 13:52:04
 * @Description: 工单列表页面
 * @FilePath: /unicom_flutter/lib/pages/orderPage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/pages/orderList/lifeList.dart';
import 'package:unicom_flutter/pages/orderList/planList.dart';
import 'package:unicom_flutter/utils/constant.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
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
            userInfo(),
            MyTabs(
                tabs: ['作业计划工单', '生命周期工单'],
                listWidget: [PlanList(), LifeList()])
          ],
        ),
      ),
    );
  }

  // 用户信息栏
  Widget userInfo() {
    return WatchBoxBuilder(
      box: Utils.unicomBox(),
      builder: (context, box) {
        return InkWell(
          onTap: () {
            showModal(context);
          },
          child: Container(
            height: setHeight(88),
            padding: setEdge(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyAsset(
                  name: Constant.userIcon,
                  width: 34,
                ),
                Expanded(
                  child: Padding(
                    padding: setEdge(left: 15),
                    child: Text(
                      box.get('username'),
                      style: Styles.f30c66,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: setWidth(46),
                  color: Styles.c999,
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
        backgroundColor: Styles.d9DEE1,
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
