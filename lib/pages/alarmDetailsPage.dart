/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:08:33
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 15:19:18
 * @Description: 处理详情页面
 * @FilePath: /unicom_flutter/lib/pages/AlarmDetailsPage.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class AlarmDetailsPage extends StatelessWidget {
  const AlarmDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('通知详情'),
    );
  }
}
