/*
 * @Author: liangyt
 * @Date: 2019-12-21 11:27:51
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 17:31:17
 * @Description: 列表加载完成到底提示
 * @FilePath: /unicom_flutter/lib/widgets/listNoMore.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

class ListNoMore extends StatelessWidget {
  final bool show;
  final String noMore;
  ListNoMore({this.noMore = '已经到底了', @required this.show});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: show ? MyScreen.setHeight(88) : 0,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MyScreen.setWidth(100),
              height: MyScreen.setHeight(1),
              color: MyStyles.cccc,
            ),
            Padding(
              padding: MyScreen.setEdge(left: 15, right: 15),
              child: Text(noMore, style: MyStyles.f26c99),
            ),
            Container(
              width: MyScreen.setWidth(100),
              height: MyScreen.setHeight(1),
              color: MyStyles.cccc,
            ),
          ],
        ),
      ),
    );
  }
}
