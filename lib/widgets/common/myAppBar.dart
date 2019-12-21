/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:00:55
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 17:01:01
 * @Description: 页面appBar
 * @FilePath: /unicom_flutter/lib/widgets/myAppBar.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/styles.dart';

Widget myAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: f36cff,
    ),
    centerTitle: true,
  );
}
