/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:49:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 21:58:36
 * @Description: 工单列表页面
 * @FilePath: /unicom_flutter/lib/pages/orderPage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/imagse.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
import 'package:unicom_flutter/widgets/myAppBar.dart';
import 'package:unicom_flutter/widgets/myAsset.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicom_flutter/widgets/showBottomSheet.dart';

import '../routes/application.dart';
import '../utils/index.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('联通智慧机房工单系统'),
      body: Container(
        child: Column(
          children: <Widget>[userInfo()],
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
                  name: userIcon,
                  width: 34,
                ),
                Expanded(
                  child: Padding(
                    padding: setEdge(left: 15),
                    child: Text(
                      box.get('username'),
                      style: f30c66,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: setWidth(46),
                  color: c999,
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
        backgroundColor: d9DEE1,
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
