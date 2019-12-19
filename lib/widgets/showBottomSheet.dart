/*
 * @Author: liangyt
 * @Date: 2019-12-19 20:17:40
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-19 21:51:18
 * @Description: 底部弹出选项
 * @FilePath: /unicom-flutter/lib/widgets/showBottomSheet.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';

class ShowBottomSheet extends StatelessWidget {
  final String titleName;
  final String closeName;
  final List list;
  final Function tap;
  ShowBottomSheet(
      {this.titleName,
      this.closeName,
      @required this.list,
      @required this.tap});

  @override
  Widget build(BuildContext context) {
    double heightSheet = list != null
        ? (list.length * 88.0 > 440 ? 440 : list.length * 88.0)
        : 0;
    if (titleName != null) {
      heightSheet = heightSheet + 88;
    }
    if (closeName != null) {
      heightSheet = heightSheet + 100;
    }
    return SafeArea(
      child: Container(
        height: setHeight(heightSheet),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            title(context),
            listBox(context),
            closeBox(context)
          ],
        ),
      ),
    );
  }

  // 标题
  Widget title(BuildContext context) {
    if (titleName == null) {
      return Container();
    }
    return Container(
      height: setHeight(88),
      padding: setEdge(left: 30, right: 30),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                titleName,
                style: f28c666,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              size: 28,
              color: c999,
            ),
          )
        ],
      ),
    );
  }

  // 选项列表
  Widget listBox(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: setHeight(440)),
        child: SingleChildScrollView(
          child: Column(
            children: list
                .asMap()
                .keys
                .map((index) => listItem(context, index))
                .toList(),
          ),
        ));
  }

  // 选项
  Widget listItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        tap(index);
        Navigator.pop(context);
      },
      child: Container(
        height: setHeight(88),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: borderColor))),
        child: Text(list[index]['name'], style: f30c33),
      ),
    );
  }

  // 取消按钮
  Widget closeBox(BuildContext context) {
    if (closeName == null) {
      return Container();
    }
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: setHeight(12),
            color: borderColor,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: setHeight(88),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: borderColor))),
              child: Text(closeName, style: f30c33),
            ),
          )
        ],
      ),
    );
  }
}
