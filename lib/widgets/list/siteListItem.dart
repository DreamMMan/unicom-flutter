/*
 * @Author: liangyt
 * @Date: 2019-12-23 09:16:17
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 13:55:03
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
      padding: EdgeInsets.all(setWidth(30)),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 1, color: Styles.borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _leftContent(data, name, isLife),
          _rightBtn(data, isLife)
        ],
      ),
    );
  }

  // 列表左边内容 设备调拨的区分
  Widget _leftContent(data, name, isLife) {
    if (name == '设备调拨') {
      return Container(
        child: Row(
          children: <Widget>[
            Container(
              width: data.status == 3 ? setWidth(225) : setWidth(295),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name ?? '',
                    style: Styles.f36c33,
                  ),
                  Padding(
                    padding: setEdge(top: 20),
                    child: Text(
                      data.address ?? '',
                      style: TextStyle(color: Styles.c999),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: setWidth(100),
              alignment: Alignment.center,
              child: Icon(
                Icons.trending_flat,
                color: Styles.c999,
                size: 20,
              ),
            ),
            Container(
              width: data.status == 3 ? setWidth(225) : setWidth(295),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data.targetName ?? '', style: Styles.f36c33),
                  Padding(
                    padding: setEdge(top: 20),
                    child: Text(
                      data.targetAddress ?? '',
                      style: TextStyle(color: Styles.c999),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: isLife
                  ? data.status == 3 ? setWidth(500) : setWidth(690)
                  : setWidth(500),
              child: Text.rich(TextSpan(
                  text: '${data.name}   ',
                  style: Styles.f36c33,
                  children: [
                    name == '数据采集建设'
                        ? TextSpan(
                            text:
                                Utils.deviceStatus(data.deviceStatus)['label'],
                            style: TextStyle(
                                color: Utils.deviceStatus(
                                    data.deviceStatus)['color'],
                                fontSize: setSp(26)),
                          )
                        : TextSpan()
                  ]))),
          Container(
            width: isLife
                ? data.status == 3 ? setWidth(500) : setWidth(690)
                : setWidth(500),
            margin: EdgeInsets.only(top: setHeight(25)),
            child: Text(
              data.address,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: Styles.f26c33,
            ),
          )
        ],
      );
    }
  }

  // 列表item 右边按钮
  Widget _rightBtn(data, isLife) {
    if (isLife) {
      if (data.status == 3) {
        return Container(
          padding: setEdge(left: 18, top: 10, right: 18, bottom: 10),
          decoration: BoxDecoration(
              color: Styles.pageBg, borderRadius: BorderRadius.circular(5)),
          child: Text(
            '待确认',
            style: Styles.f26c99,
          ),
        );
      } else {
        return Container();
      }
    } else {
      return Container(
        padding: setEdge(left: 18, top: 10, right: 18, bottom: 10),
        decoration: BoxDecoration(
            color: Styles.pageBg, borderRadius: BorderRadius.circular(5)),
        child: Text(
          Utils.siteStatus(data.status)['label'],
          style: TextStyle(
              color: Utils.siteStatus(data.status)['color'],
              fontSize: setSp(26)),
        ),
      );
    }
  }
}
