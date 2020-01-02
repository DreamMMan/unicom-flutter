/*
 * @Author: liangyt
 * @Date: 2020-01-02 16:21:08
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 16:52:20
 * @Description: 作业计划工单列表item
 * @FilePath: /unicom_flutter/lib/widgets/list/planListItem.dart
 */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/orderModel.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myListBtn.dart';

class PlanListItem extends StatelessWidget {
  final MyList data;
  PlanListItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyScreen.setWidth(750),
        color: Colors.white,
        constraints: BoxConstraints(minHeight: MyScreen.setHeight(160)),
        padding: MyScreen.setEdge(left: 30, top: 22, right: 30, bottom: 22),
        margin: MyScreen.setEdge(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_leftContent(), _rightContent()],
        ));
  }

  // 列表左边内容
  Widget _leftContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: MyStyles.f30c33,
          ),
          Padding(
            padding: EdgeInsets.only(top: MyScreen.setHeight(20)),
            child: Text(
              '${DateUtil.formatDateMs(data.createdTime, format: "yyyy-MM-dd")}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MyStyles.f26c99,
            ),
          )
        ],
      ),
    );
  }

  // 列表右边内容
  Widget _rightContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _rightBtn(data.rejectionNum, data.processingNum),
    );
  }

  List<Widget> _rightBtn(rejectionNum, processingNum) {
    List<Widget> views = [];
    if (rejectionNum > 0) {
      views
          .add(MyListBtn(name: '确认退回:  $rejectionNum', style: MyStyles.f26ce0));
    }
    if (processingNum > 0) {
      views.add(Padding(
          padding: EdgeInsets.only(
              top: rejectionNum > 0 ? MyScreen.setHeight(20) : 0),
          child:
              MyListBtn(name: '确认退回:  $rejectionNum', style: MyStyles.f26c3a)));
    }
    return views;
  }
}
