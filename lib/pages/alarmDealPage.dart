/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:10:03
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 14:10:50
 * @Description: 告警处理
 * @FilePath: /unicom_flutter/lib/pages/alarmDealPage.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class AlarmDealPage extends StatelessWidget {
  const AlarmDealPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('告警处理'),
    );
  }
}
