/*
 * @Author: liangyt
 * @Date: 2020-01-03 19:08:43
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-03 19:13:27
 * @Description: 计划工单站点列表
 * @FilePath: /unicom-flutter/lib/widgets/list/PlanSiteListItem.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/siteListModel.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myListBtn.dart';

class PlanSiteListItem extends StatelessWidget {
  final SiteList data;
  PlanSiteListItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdge(left: 30, top: 40, right: 30, bottom: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: _planOrder(),
    );
  }

  // 作业计划工单
  Widget _planOrder() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: MyScreen.setWidth(400)),
                      child: Text(data.name, style: MyStyles.f36c33),
                    ),
                    Padding(
                      padding: MyScreen.setEdge(left: 40),
                      child: Text('未连接', style: MyStyles.f26ccc),
                    )
                  ],
                ),
                Padding(
                  padding: MyScreen.setEdge(top: 20),
                  child: Text(data.address, style: MyStyles.f26c99),
                )
              ],
            ),
          ),
          MyListBtn(
            name: Utils.siteStatus(data.status)['label'],
            style: Utils.siteStatus(data.status)['style'],
          )
        ],
      ),
    );
  }
}
