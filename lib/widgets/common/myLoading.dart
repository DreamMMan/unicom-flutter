/*
 * @Author: liangyt
 * @Date: 2019-12-19 16:55:45
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 13:52:50
 * @Description: 加载组件
 * @FilePath: /unicom_flutter/lib/widgets/myLoading.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

class MyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MyScreen.setWidth(250),
        width: MyScreen.setHeight(250),
        child: Card(
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MyScreen.setWidth(150),
                height: MyScreen.setWidth(150),
                child: SpinKitCircle(
                  color: Colors.white,
                  size: MyScreen.setWidth(100),
                ),
              ),
              Container(
                child: Text(
                  '正在拼命加载',
                  style: MyStyles.f26cf,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
