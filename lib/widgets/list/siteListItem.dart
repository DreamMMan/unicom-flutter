/*
 * @Author: liangyt
 * @Date: 2019-12-23 09:16:17
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-24 14:21:33
 * @Description: 站点列表itrm
 * @FilePath: /unicom_flutter/lib/widgets/list/siteListItem.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/siteListModel.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';

class SiteListItem extends StatelessWidget {
  final SiteList data;
  final String name;
  final bool isLife;
  SiteListItem({@required this.data, this.name, this.isLife});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidth(750),
      padding: setEdge(left: 30, top: 40, right: 30, bottom: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 1, color: Styles.borderColor))),
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
                    constraints: BoxConstraints(maxWidth: setWidth(230)),
                    child: Text(
                      data.name,
                      style: Styles.f36c33,
                    ),
                  ),
                  Padding(
                    padding: setEdge(left: 20, right: 20),
                    child: Icon(Icons.arrow_right),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: setWidth(230)),
                    child: Text(
                      data.targetName,
                      style: Styles.f36c33,
                    ),
                  ),
                ],
              ),
              rightBtn()
            ],
          ),
          Padding(
            padding: setEdge(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: setWidth(295),
                  child: Text(
                    data.address,
                    style: Styles.f26c66,
                  ),
                ),
                Padding(
                  padding: setEdge(left: 20, right: 20),
                  child: Icon(Icons.arrow_right),
                ),
                Container(
                  width: setWidth(295),
                  child: Text(
                    data.targetAddress,
                    style: Styles.f26c66,
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
                  style: Styles.f36c33,
                ),
              ),
              rightBtn()
            ],
          ),
          Padding(
            padding: setEdge(top: 20),
            child: Text(
              data.address,
              style: Styles.f26c99,
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
                      constraints: BoxConstraints(maxWidth: setWidth(400)),
                      child: Text(data.name, style: Styles.f36c33),
                    ),
                    Padding(
                      padding: setEdge(left: 40),
                      child: Text('未连接', style: Styles.f26ccc),
                    )
                  ],
                ),
                Padding(
                  padding: setEdge(top: 20),
                  child: Text(data.address, style: Styles.f26c99),
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
      color = Styles.c333;
    } else if (!isLife) {
      name = Utils.siteStatus(data.status)['label'];
      color = Utils.siteStatus(data.status)['color'];
    } else {
      return Container();
    }
    return Container(
      width: setWidth(136),
      height: setHeight(48),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Styles.f8f8f8,
          borderRadius: BorderRadius.circular(setWidth(10))),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: setSp(26)),
        child: Text(
          name,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
