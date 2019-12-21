/*
 * @Author: liangyt
 * @Date: 2019-12-19 16:55:45
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 16:56:07
 * @Description: 加载组件
 * @FilePath: /unicom_flutter/lib/widgets/myLoading.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';

class MyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: setWidth(250),
        width: setHeight(250),
        child: Card(
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: setWidth(150),
                height: setWidth(150),
                child: SpinKitCircle(
                  color: Colors.white,
                  size: setWidth(100),
                ),
              ),
              Container(
                child: Text(
                  '正在拼命加载',
                  style: f26cf,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
