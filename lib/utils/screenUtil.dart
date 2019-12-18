/*
 * @Author: liangyt
 * @Date: 2019-12-18 11:09:23
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-18 11:18:02
 * @Description: 屏幕适配插件设置
 * @FilePath: /unicom_flutter/lib/utils/screenUtil.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double setWidth(double width) {
  return ScreenUtil().setWidth(width);
}

double setHeight(double height) {
  return ScreenUtil().setHeight(height);
}

double setSp(double sp) {
  return ScreenUtil().setSp(sp);
}

EdgeInsetsGeometry setEdge(
    {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
  return EdgeInsets.fromLTRB(
      setWidth(left), setWidth(top), setWidth(right), setWidth(bottom));
}
