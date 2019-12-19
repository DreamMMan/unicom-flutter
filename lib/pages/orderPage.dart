/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:49:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 17:51:08
 * @Description: 工单列表页面
 * @FilePath: /unicom_flutter/lib/pages/orderPage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/imagse.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/widgets/myAppBar.dart';
import 'package:unicom_flutter/widgets/myAsset.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
        return Container(
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
              Padding(
                padding: setEdge(left: 15),
                child: Text(box.get('username')),
              )
            ],
          ),
        );
      },
    );
  }
}
