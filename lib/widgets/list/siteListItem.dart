/*
 * @Author: liangyt
 * @Date: 2019-12-23 09:16:17
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 15:01:48
 * @Description: 站点列表itrm
 * @FilePath: /unicom_flutter/lib/widgets/list/siteListItem.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/siteListModel.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

class SiteListItem extends StatelessWidget {
  final SiteList data;
  final String name;
  final bool isLife;
  SiteListItem({@required this.data, this.name, this.isLife});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdge(left: 30, top: 40, right: 30, bottom: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: _content(),
    );
  }

  Widget _content() {
    if (name == '设备调拨') {
      // 设备调拨
      return _allot();
    }
    if (isLife) {
      return _addContent();
    }
    return _planOrder();
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
                    constraints: BoxConstraints(maxWidth: MyScreen.setWidth(230)),
                    child: Text(
                      data.name,
                      style: MyStyles.f36c33,
                    ),
                  ),
                  Padding(
                    padding: MyScreen.setEdge(left: 20, right: 20),
                    child: Icon(Icons.arrow_right),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: MyScreen.setWidth(230)),
                    child: Text(
                      data.targetName,
                      style: MyStyles.f36c33,
                    ),
                  ),
                ],
              ),
              rightBtn()
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
                  child: Icon(Icons.arrow_right),
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
              rightBtn()
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
                      constraints: BoxConstraints(maxWidth: MyScreen.setWidth(400)),
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
          rightBtn()
        ],
      ),
    );
  }

  // 右边按钮
  Widget rightBtn() {
    String name;
    Color color;
    if (isLife && data.status == 3) {
      name = '待审核';
      color = MyStyles.c333;
    } else if (!isLife) {
      name = Utils.siteStatus(data.status)['label'];
      color = Utils.siteStatus(data.status)['color'];
    } else {
      return Container();
    }
    return Container(
      width: MyScreen.setWidth(136),
      height: MyScreen.setHeight(48),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: MyStyles.f8f8f8,
          borderRadius: BorderRadius.circular(MyScreen.setWidth(10))),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: MyScreen.setSp(26)),
        child: Text(
          name,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
