/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:50:24
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 17:51:27
 * @Description: 告警列表页
 * @FilePath: /unicom_flutter/lib/pages/alarmPage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/widgets/myAppBar.dart';

class AlarmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('通知'),
    );
  }
}
