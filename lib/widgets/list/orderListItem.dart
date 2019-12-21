import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/orderModel.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';

class OrderListItem extends StatelessWidget {
  final MyList data;
  final bool isPlan;
  const OrderListItem({@required this.data, @required this.isPlan});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: setWidth(750),
        color: Colors.white,
        constraints: BoxConstraints(minHeight: setHeight(160)),
        padding: EdgeInsets.all(setWidth(22)),
        margin: EdgeInsets.only(bottom: setWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: f30c33,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: setHeight(20)),
                    child: Text(
                      '${DateUtil.formatDateMs(data.createdTime, format: "yyyy-MM-dd HH:mm:ss")}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: f26c99,
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment:
                  (data.rejectionNum > 0 && data.processingNum > 0)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _rightBtn(data.rejectionNum, data.processingNum),
            )
          ],
        ));
  }

  List<Widget> _rightBtn(rejectionNum, processingNum) {
    List<Widget> views = [];
    if (rejectionNum > 0) {
      views.add(
        Container(
          padding: EdgeInsets.all(setWidth(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: f8f8f8,
          ),
          child: Text(
            '确认退回:  $rejectionNum',
            style: f26ce0,
          ),
        ),
      );
    }
    if (processingNum > 0) {
      views.add(Padding(
          padding: EdgeInsets.only(top: rejectionNum > 0 ? setHeight(20) : 0),
          child: Container(
            padding: EdgeInsets.all(setWidth(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: f8f8f8,
            ),
            child: Text(
              isPlan ? '进行中: $processingNum' : '待确认: $processingNum',
              style: isPlan ? f26c3a : f26c99,
            ),
          )));
    }
    return views;
  }
}
