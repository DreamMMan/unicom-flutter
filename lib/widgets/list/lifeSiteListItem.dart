/*
 * @Author: liangyt
 * @Date: 2020-01-03 19:21:45
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-03 19:27:16
 * @Description: 生命周期工单站点列表item
 * @FilePath: /unicom-flutter/lib/widgets/list/LifeSiteListItem.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/siteListModel.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myListBtn.dart';

class LifeSiteListItem extends StatelessWidget {
  final SiteList data;
  LifeSiteListItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdge(left: 30, top: 40, right: 30, bottom: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: _addContent(),
    );
  }

  // 生命周期非调拨
  Widget _addContent() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  data.name,
                  style: MyStyles.f36c33,
                ),
              ),
              data.status == 3
                  ? MyListBtn(
                      name: '待确认',
                      style: MyStyles.f26c33,
                    )
                  : Container()
            ],
          ),
          Padding(
            padding: MyScreen.setEdge(top: 20),
            child: Text(
              data.address,
              style: MyStyles.f26c99,
            ),
          )
        ],
      ),
    );
  }
}
