import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/orderModel.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myListBtn.dart';

class LifeListItem extends StatelessWidget {
  final MyList data;
  const LifeListItem({@required this.data});

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
              '${DateUtil.formatDateMs(data.createdTime, format: "yyyy-MM-dd HH:mm:ss")}',
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
    return data.processingNum > 0
        ? MyListBtn(
            name: '待确认: ${data.processingNum}',
            style: MyStyles.f26c99,
          )
        : Container();
  }
}
