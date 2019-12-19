/*
 * @Author: liangyt
 * @Date: 2019-12-18 14:42:10
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 14:51:12
 * @Description: utils方法
 * @FilePath: /unicom_flutter/lib/utils/index.dart
 */

import 'package:hive/hive.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Utils {
  // hive
  static unicomBox() async {
    var box = await Hive.openBox('unicomBox');
    return box;
  }

  // BotToast
  static showToast(String title, {double align = 0, int s = 2}) {
    BotToast.showText(
        text: title,
        align: Alignment(0, align),
        duration: Duration(seconds: s));
  }
}
