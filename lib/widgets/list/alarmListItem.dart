/*
 * @Author: liangyt
 * @Date: 2019-12-21 15:34:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-21 16:14:28
 * @Description: 报警列表item
 * @FilePath: /unicom_flutter/lib/widgets/list/alarmListItem.dart
 */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/models/alarmModel.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';

class AlarmListItem extends StatelessWidget {
  final AlarmList data;
  final bool isOpen;
  final List<int> idList;
  AlarmListItem(
      {@required this.data, @required this.isOpen, @required this.idList});

  @override
  Widget build(BuildContext context) {
    var str = data.name == '连接异常'
        ? '-DTU${data.dtuId.toString()}-${data.sn}号表-${data.lineName}'
        : data.name == 'DTU离线' ? '-DTU${data.dtuId.toString()}' : '';
    return InkWell(
      onTap: () {
        Provide.value<AlarmProvide>(context).isSelect(data.id);
      },
      child: Container(
        width: ScreenUtil().setWidth(750),
        constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(160)),
        padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: borderColor))),
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
                    activeColor: c52C47B,
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
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(20)),
                            child: ClipOval(
                              child: Container(
                                width: setWidth(20),
                                height: setWidth(20),
                                color: data.removeTime != null ? c999 : e04545,
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(400),
                            child: Text(
                              '${data.name}告警',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(36),
                                  color: c333),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: isOpen
                            ? ScreenUtil().setWidth(400)
                            : ScreenUtil().setWidth(450),
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(40)),
                        child: Text('${data.siteName}$str',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(26), color: c666)),
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
                  style:
                      TextStyle(fontSize: ScreenUtil().setSp(24), color: c999),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                  child: Text(
                    data.handUserInfo != null ? '已处理' : '未处理',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(26),
                        color: data.handUserInfo != null ? c999 : e04545),
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
