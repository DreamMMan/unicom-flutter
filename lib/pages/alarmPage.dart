/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:50:24
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-03 20:50:25
 * @Description: 告警列表页
 * @FilePath: /unicom_flutter/lib/pages/alarmPage.dart
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/alarmDealProvide.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myClipOval.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';
import 'package:unicom_flutter/widgets/list/alarmListItem.dart';
import 'package:unicom_flutter/widgets/list/listNoMore.dart';

class AlarmPage extends StatelessWidget {
  final EasyRefreshController _controller = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar('通知'),
        body: Provide<AlarmProvide>(
          builder: (context, child, data) {
            return CupertinoScrollbar(
              child: Column(
                children: <Widget>[
                  _labelInfo(context, data.isOpen),
                  _listBox(context, data),
                  _dealBtn(context, data)
                ],
              ),
            );
          },
        ));
  }

  // 顶部信息栏
  Widget _labelInfo(BuildContext context, bool isOpen) {
    return Container(
      height: MyScreen.setHeight(90),
      padding: MyScreen.setEdge(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '告警状态说明：',
            style: MyStyles.f26c66,
          ),
          Padding(
            padding: MyScreen.setEdge(left: 20, right: 15),
            child: MyClipOval(size: 14, color: MyStyles.e04545),
          ),
          Text(
            '告警中',
            style: MyStyles.f26ce0,
          ),
          Padding(
              padding: MyScreen.setEdge(left: 40, right: 15),
              child: MyClipOval(size: 14, color: MyStyles.c999)),
          Expanded(
            child: Text(
              '已解除',
              style: MyStyles.f26c99,
            ),
          ),
          InkWell(
            onTap: () {
              Provide.value<AlarmProvide>(context).setOpen();
            },
            child: Container(
              height: MyScreen.setHeight(48),
              padding: MyScreen.setEdge(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(MyScreen.setWidth(10))),
              alignment: Alignment.center,
              child: Text(isOpen ? '退出批量处理' : '批量处理', style: MyStyles.f26c33),
            ),
          )
        ],
      ),
    );
  }

  // 列表组件
  Widget _listBox(context, data) {
    if (data.isError) {
      _controller.finishRefresh();
      _controller.finishLoad();
    }
    if (data.callRefresh) {
      _controller.callRefresh();
    }
    return Expanded(
      child: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        emptyWidget: !data.first && data.list.length == 0 ? MyEmpty() : null,
        controller: _controller,
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        firstRefresh: true,
        firstRefreshWidget: MyLoading(),
        onRefresh: () async {
          await Provide.value<AlarmProvide>(context).onRefresh(context);
          _controller.resetLoadState(); // 重置加载状态
          _controller.finishRefresh(); // 完成刷新
          _controller.finishLoad(
              noMore: data.list.length >= data.total); // 加载完和判断是否能加载
        },
        onLoad: () async {
          await Provide.value<AlarmProvide>(context).onLoad(context);
          _controller.finishLoad(
              noMore: data.list.length >= data.total); // 加载完和判断是否能加载
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AlarmListItem(
                    data: data.list[index],
                    idList: data.idList,
                    isOpen: data.isOpen);
              },
              childCount: data.list.length,
            ),
          ),
          ListNoMore(
            show: !data.first && data.list.length >= data.total,
          )
        ],
      ),
    );
  }

  // 批量处理
  Widget _dealBtn(BuildContext context, data) {
    if (data.isOpen) {
      return Container(
        width: MyScreen.setWidth(690),
        height: MyScreen.setHeight(100),
        margin: MyScreen.setEdge(left: 30, top: 40, right: 30, bottom: 40),
        child: MySubmitBtn(
          txt: '批量处理',
          textSty: MyStyles.f36cff,
          submit: () {
            if (data.idList.length < 1) {
              Utils.showToast('请选择要处理的通知');
              return;
            }
            Provide.value<AlarmDealProvide>(context).setId(data.idList, 1);
            Provide.value<AlarmProvide>(context).setOpen();
            Application.router.navigateTo(context, '/alarmDeal');
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
