/*
 * @Author: liangyt
 * @Date: 2019-12-18 11:09:23
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 15:11:05
 * @Description: 屏幕适配插件设置
 * @FilePath: /unicom_flutter/lib/utils/screenUtil.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyScreen {
  static setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static setSp(double sp) {
    return ScreenUtil().setSp(sp);
  }

  static setEdge(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.fromLTRB(
        setWidth(left), setWidth(top), setWidth(right), setWidth(bottom));
  }

  static setEdgeAll(double size) {
    return EdgeInsets.all(setWidth(size));
  }

  static double statusBarHeight = ScreenUtil.statusBarHeight;
}
