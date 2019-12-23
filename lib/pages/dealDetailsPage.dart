/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:08:33
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 14:09:46
 * @Description: 处理详情页面
 * @FilePath: /unicom_flutter/lib/pages/dealDetailsPage.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';

class DealDetailsPage extends StatelessWidget {
  const DealDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('通知详情'),
    );
  }
}
