/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:00:55
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 14:59:19
 * @Description: 页面appBar
 * @FilePath: /unicom_flutter/lib/widgets/myAppBar.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

Widget myAppBar(String title, [List<Widget> actions]) {
  return AppBar(
    title: Text(
      title,
      style: MyStyles.f36cff,
    ),
    centerTitle: true,
    actions: actions,
  );
}
