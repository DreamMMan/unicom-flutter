/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:49:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 17:51:08
 * @Description: 工单列表页面
 * @FilePath: /unicom_flutter/lib/pages/orderPage.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/widgets/myAppBar.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('联通智慧机房工单系统'),
    );
  }
}
