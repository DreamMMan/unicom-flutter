/*
 * @Author: liangyt
 * @Date: 2019-12-21 11:27:51
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 17:31:17
 * @Description: 列表加载完成到底提示
 * @FilePath: /unicom_flutter/lib/widgets/listNoMore.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';

class ListNoMore extends StatelessWidget {
  final bool show;
  final String noMore;
  ListNoMore({this.noMore = '已经到底了', @required this.show});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: show ? setHeight(88) : 0,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: setWidth(100),
              height: setHeight(1),
              color: Styles.cccc,
            ),
            Padding(
              padding: setEdge(left: 15, right: 15),
              child: Text(noMore, style: Styles.f26c99),
            ),
            Container(
              width: setWidth(100),
              height: setHeight(1),
              color: Styles.cccc,
            ),
          ],
        ),
      ),
    );
  }
}
