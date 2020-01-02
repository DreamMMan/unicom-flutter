/*
 * @Author: liangyt
 * @Date: 2019-12-21 15:34:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 17:50:49
 * @Description: 报警列表item
 * @FilePath: /unicom_flutter/lib/widgets/list/alarmListItem.dart
 */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/models/alarmModel.dart';
import 'package:unicom_flutter/providers/alarmDetailsProvide.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myClipOval.dart';

class AlarmListItem extends StatelessWidget {
  final AlarmList data;
  final bool isOpen;
  final List<int> idList;
  AlarmListItem(
      {@required this.data, @required this.isOpen, @required this.idList});

  @override
  Widget build(BuildContext context) {
    var str = data.name == '连接异常'
        ? '-DTU${data.dtuId}-${data.sn}号表-${data.lineName}'
        : data.name == 'DTU离线' ? '-DTU${data.dtuId}' : '';
    return InkWell(
      onTap: () {
        if (isOpen && data.handUserInfo == null) {
          Provide.value<AlarmProvide>(context).isSelect(data.id);
        }
        if (!isOpen) {
          Application.router.navigateTo(context, '/alarmDetails');
          Provide.value<AlarmDetailsProvide>(context).setId(context, data.id);
        }
      },
      child: Container(
        width: MyScreen.setWidth(750),
        constraints: BoxConstraints(minHeight: MyScreen.setHeight(160)),
        padding: MyScreen.setEdgeAll(30),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 1, color: MyStyles.borderColor))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (isOpen && data.handUserInfo == null)
                ? Checkbox(
                    value: idList.indexOf(data.id) != -1,
                    onChanged: (bool check) {
                      Provide.value<AlarmProvide>(context).isSelect(data.id);
                    },
                    activeColor: MyStyles.c52C47B,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
                : Text(''),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: MyScreen.setEdge(right: 20),
                            child: MyClipOval(
                                size: 20,
                                color: data.removeTime != null
                                    ? MyStyles.c999
                                    : MyStyles.e04545),
                          ),
                          Container(
                            width: MyScreen.setWidth(400),
                            child: Text(
                              '${data.name}告警',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: MyStyles.f36c33,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: isOpen
                            ? MyScreen.setWidth(400)
                            : MyScreen.setWidth(450),
                        margin: MyScreen.setEdge(top: 20, left: 40),
                        child: Text('${data.siteName}$str',
                            style: MyStyles.f26c66),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${DateUtil.formatDateMs(data.createTime, format: "MM-dd HH:mm:ss")}',
                  style: MyStyles.f24c99,
                ),
                Padding(
                  padding: MyScreen.setEdge(top: 20),
                  child: Text(
                    data.handUserInfo != null ? '已处理' : '未处理',
                    style: TextStyle(
                        fontSize: MyScreen.setSp(26),
                        color: data.handUserInfo != null
                            ? MyStyles.c999
                            : MyStyles.e04545),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
