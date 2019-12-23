/*
 * @Author: liangyt
 * @Date: 2019-12-19 17:50:24
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 17:02:36
 * @Description: 告警列表页
 * @FilePath: /unicom_flutter/lib/pages/alarmPage.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/alarmDealProvide.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
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
            return Container(
              child: Column(
                children: <Widget>[
                  labelInfo(context, data.isOpen),
                  listBox(context, data),
                  dealBtn(context, data)
                ],
              ),
            );
          },
        ));
  }

  // 顶部信息栏
  Widget labelInfo(BuildContext context, bool isOpen) {
    return Container(
      height: setHeight(90),
      padding: setEdge(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '告警状态说明：',
            style: Styles.f26c66,
          ),
          Padding(
            padding: setEdge(left: 20, right: 15),
            child: ClipOval(
              child: Container(
                width: setWidth(14),
                height: setWidth(14),
                color: Styles.e04545,
              ),
            ),
          ),
          Text(
            '告警中',
            style: Styles.f26ce0,
          ),
          Padding(
            padding: setEdge(left: 40, right: 15),
            child: ClipOval(
              child: Container(
                width: setWidth(14),
                height: setWidth(14),
                color: Styles.c999,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '已解除',
              style: Styles.f26c99,
            ),
          ),
          InkWell(
            onTap: () {
              Provide.value<AlarmProvide>(context).setOpen();
            },
            child: Container(
              height: setHeight(48),
              padding: setEdge(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(setWidth(10))),
              alignment: Alignment.center,
              child: Text(isOpen ? '退出批量处理' : '批量处理', style: Styles.f26c33),
            ),
          )
        ],
      ),
    );
  }

  // 列表组件
  Widget listBox(context, data) {
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
  Widget dealBtn(BuildContext context, data) {
    if (data.isOpen) {
      return Container(
        width: setWidth(690),
        height: setHeight(100),
        margin: setEdge(left: 30, top: 40, right: 30, bottom: 40),
        child: MySubmitBtn(
          txt: '批量处理',
          textSty: Styles.f36cff,
          submit: () {
            if (data.idList.length < 1) {
              Utils.showToast('请选择要处理的通知');
              return;
            }
            Provide.value<AlarmDealProvide>(context).setId(data.idList);
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
