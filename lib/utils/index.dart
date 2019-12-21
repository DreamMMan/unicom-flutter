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
import 'package:unicom_flutter/widgets/common/myLoading.dart';

class Utils {
  static String hiveName = 'unicomBox';
  // hive
  static unicomBox() {
    return Hive.box(hiveName);
  }

  // BotToast
  static showToast(String title, {double align = 0, int s = 2}) {
    BotToast.showText(
        text: title,
        align: Alignment(0, align),
        duration: Duration(seconds: s));
  }

  // 加载中
  static showLoading(_context) {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            // 禁止手动后退
            onWillPop: () async {
              BotToast.showText(text: '正在处理中，请勿退出页面');
              return false;
            },
            child: MyLoading(),
          );
        });
  }
}
