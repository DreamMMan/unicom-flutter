/*
 * @Author: liangyt
 * @Date: 2019-12-21 15:34:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 15:17:03
 * @Description: 报警列表item
 * @FilePath: /unicom_flutter/lib/widgets/list/alarmListItem.dart
 */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/models/alarmModel.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/providers/dealDetailsProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';

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
          Application.router.navigateTo(context, '/dealDetails');
          Provide.value<DealDetailsProvide>(context).setId(data.id);
        }
      },
      child: Container(
        width: setWidth(750),
        constraints: BoxConstraints(minHeight: setHeight(160)),
        padding: EdgeInsets.all(setWidth(30)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 1, color: Styles.borderColor))),
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
                    activeColor: Styles.c52C47B,
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
                            margin: EdgeInsets.only(right: setWidth(20)),
                            child: ClipOval(
                              child: Container(
                                width: setWidth(20),
                                height: setWidth(20),
                                color: data.removeTime != null
                                    ? Styles.c999
                                    : Styles.e04545,
                              ),
                            ),
                          ),
                          Container(
                            width: setWidth(400),
                            child: Text(
                              '${data.name}告警',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.f36c33,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: isOpen ? setWidth(400) : setWidth(450),
                        margin: EdgeInsets.only(
                            top: setHeight(20), left: setWidth(40)),
                        child:
                            Text('${data.siteName}$str', style: Styles.f26c66),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${DateUtil.formatDateMs(data.createTime, format: "MM-dd HH:mm:ss")}',
                  style: Styles.f24c99,
                ),
                Padding(
                  padding: setEdge(top: 20),
                  child: Text(
                    data.handUserInfo != null ? '已处理' : '未处理',
                    style: TextStyle(
                        fontSize: setSp(26),
                        color: data.handUserInfo != null
                            ? Styles.c999
                            : Styles.e04545),
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
