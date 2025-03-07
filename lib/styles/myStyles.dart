/*
 * @Author: liangyt
 * @Date: 2019-12-18 11:37:14
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-18 13:43:04
 * @Description: 字体大小和颜色
 * @FilePath: /unicom_flutter/lib/utils/MyStyles.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';

class MyStyles {
  // 颜色
  static Color e0454501 = Color.fromRGBO(224, 69, 69, 0.1);
  static Color e04545 = Color(0xFFE04545);
  static Color boxShadow = Color.fromRGBO(51, 51, 51, 0.08);
  static Color cccc = Color(0xFFCCCCCC);
  static Color c333 = Color(0xFF333333);
  static Color c666 = Color(0xFF666666);
  static Color c999 = Color(0xFF999999);
  static Color borderColor = Color(0xFFF1F1F1);
  static Color pageBg = Color(0xFFF2F7FA);
  static Color d9DEE1 = Color(0xFFD9DEE1);
  static Color f8f8f8 = Color(0xFFF8F8F8);
  static Color c03A4EE = Color(0xFF03A4EE);
  static Color c03A4EE01 = Color.fromRGBO(3, 164, 238, 0.1);
  static Color c52C47B = Color(0xFF52C47B);
  static Color f1f1f1 = Color(0xFFf1f1f1);
  static Color c7C7CC = Color(0xFFC7C7CC);
  static Color e25657 = Color(0xFFE25657);
  static Color d6E2E8 = Color(0xFFD6E2E8);

  // 字体大小和颜色
  static TextStyle f22c33 =
      TextStyle(fontSize: MyScreen.setSp(22), color: c333);
  static TextStyle f22c99 =
      TextStyle(fontSize: MyScreen.setSp(22), color: c999);
  static TextStyle f24c33 =
      TextStyle(fontSize: MyScreen.setSp(24), color: c333);
  static TextStyle f24c66 =
      TextStyle(fontSize: MyScreen.setSp(24), color: c666);
  static TextStyle f24c99 =
      TextStyle(fontSize: MyScreen.setSp(24), color: c999);
  static TextStyle f26cf =
      TextStyle(fontSize: MyScreen.setSp(26), color: Colors.white);
  static TextStyle f26c33 =
      TextStyle(fontSize: MyScreen.setSp(26), color: c333);
  static TextStyle f26c66 =
      TextStyle(fontSize: MyScreen.setSp(26), color: c666);
  static TextStyle f26c99 =
      TextStyle(fontSize: MyScreen.setSp(26), color: c999);
  static TextStyle f26ccc =
      TextStyle(fontSize: MyScreen.setSp(26), color: cccc);
  static TextStyle f26ce0 =
      TextStyle(fontSize: MyScreen.setSp(26), color: e04545);
  static TextStyle f26c3a =
      TextStyle(fontSize: MyScreen.setSp(26), color: c03A4EE);
  static TextStyle f26c52 =
      TextStyle(fontSize: MyScreen.setSp(26), color: c52C47B);
  static TextStyle f28c666 =
      TextStyle(fontSize: MyScreen.setSp(28), color: c666);
  static TextStyle f30c52 =
      TextStyle(fontSize: MyScreen.setSp(30), color: c52C47B);
  static TextStyle f30ce0 =
      TextStyle(fontSize: MyScreen.setSp(30), color: e04545);
  static TextStyle f30ccc =
      TextStyle(fontSize: MyScreen.setSp(30), color: cccc);
  static TextStyle f30c33 =
      TextStyle(fontSize: MyScreen.setSp(30), color: c333);
  static TextStyle f30c66 =
      TextStyle(fontSize: MyScreen.setSp(30), color: c666);
  static TextStyle f30c99 =
      TextStyle(fontSize: MyScreen.setSp(30), color: c999);
  static TextStyle f30ce2 =
      TextStyle(fontSize: MyScreen.setSp(30), color: e25657);
  static TextStyle f30cff =
      TextStyle(fontSize: MyScreen.setSp(30), color: Colors.white);
  static TextStyle f32cff =
      TextStyle(fontSize: MyScreen.setSp(32), color: Colors.white);
  static TextStyle f36ce0 =
      TextStyle(fontSize: MyScreen.setSp(36), color: e04545);
  static TextStyle f36ce0B = TextStyle(
      fontSize: MyScreen.setSp(36), color: e04545, fontWeight: FontWeight.bold);
  static TextStyle f36cff =
      TextStyle(fontSize: MyScreen.setSp(36), color: Colors.white);
  static TextStyle f36c33 =
      TextStyle(fontSize: MyScreen.setSp(36), color: c333);
  static TextStyle f36c66 =
      TextStyle(fontSize: MyScreen.setSp(36), color: c666);
  static TextStyle f36c99 =
      TextStyle(fontSize: MyScreen.setSp(36), color: c999);
  static TextStyle f36c03 =
      TextStyle(fontSize: MyScreen.setSp(36), color: c03A4EE);
  static TextStyle f36c52 =
      TextStyle(fontSize: MyScreen.setSp(36), color: c52C47B);

  // border
  static Border borderTop =
      Border(top: BorderSide(width: 1, color: borderColor));
  static Border borderLeft =
      Border(left: BorderSide(width: 1, color: borderColor));
  static Border borderRight =
      Border(right: BorderSide(width: 1, color: borderColor));
  static Border borderBottom =
      Border(bottom: BorderSide(width: 1, color: borderColor));
  static Border borderAll = Border.all(width: 1, color: borderColor);
}
