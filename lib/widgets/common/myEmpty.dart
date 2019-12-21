/*
 * @Author: liangyt
 * @Date: 2019-12-20 14:18:32
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-20 16:03:33
 * @Description: 空数据显示的内容
 * @FilePath: /unicom_flutter/lib/widgets/myEmpty.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/styles.dart';

class MyEmpty extends StatelessWidget {
  final String emptyLabel;
  MyEmpty({this.emptyLabel = '暂无数据'});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(emptyLabel, style: f30c99),
    );
  }
}
