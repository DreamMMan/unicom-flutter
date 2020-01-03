/*
 * @Author: liangyt
 * @Date: 2020-01-03 19:31:17
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-03 19:51:39
 * @Description: 生命周期调拨站点列表
 * @FilePath: /unicom-flutter/lib/widgets/list/trfSiteListItem.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/models/siteListModel.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myListBtn.dart';

class TrfSiteListItem extends StatelessWidget {
  final SiteList data;
  TrfSiteListItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdge(left: 30, top: 40, right: 30, bottom: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: _allot(),
    );
  }

  // 设备调拨
  Widget _allot() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: MyScreen.setWidth(230)),
                    child: Text(
                      data.name,
                      style: MyStyles.f36c33,
                    ),
                  ),
                  Padding(
                    padding: MyScreen.setEdge(left: 20, right: 20),
                    child: Icon(
                      MyConstant.arrowIcon,
                      size: 30,
                      color: MyStyles.cccc,
                    ),
                  ),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: MyScreen.setWidth(230)),
                    child: Text(
                      data.targetName,
                      style: MyStyles.f36c33,
                    ),
                  ),
                ],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MyScreen.setWidth(295),
                  child: Text(
                    data.address,
                    style: MyStyles.f26c66,
                  ),
                ),
                Padding(
                  padding: MyScreen.setEdge(left: 20, right: 20),
                  child: Icon(
                    MyConstant.arrowIcon,
                    size: 30,
                    color: MyStyles.cccc,
                  ),
                ),
                Container(
                  width: MyScreen.setWidth(295),
                  child: Text(
                    data.targetAddress,
                    style: MyStyles.f26c66,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
