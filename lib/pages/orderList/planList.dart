/*
 * @Author: liangyt
 * @Date: 2019-12-20 14:12:14
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-21 11:38:37
 * @Description: 作业计划工单
 * @FilePath: /unicom_flutter/lib/pages/orderList/planList.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/orderProvide.dart';
import 'package:unicom_flutter/widgets/list/listNoMore.dart';
import 'package:unicom_flutter/widgets/list/orderListItem.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';

class PlanList extends StatefulWidget {
  @override
  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final EasyRefreshController _controller = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Provide<OrderProvide>(
      builder: (context, child, data) {
        // 报错时 关闭刷新 关闭加载
        if (data.isError) {
          _controller.finishRefresh();
          _controller.finishLoad();
        }
        return Container(
          child: EasyRefresh.custom(
            header: MaterialHeader(),
            footer: MaterialFooter(),
            emptyWidget:
                !data.planFirst && data.planList.length == 0 ? MyEmpty() : null,
            controller: _controller,
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            firstRefresh: true,
            firstRefreshWidget: MyLoading(),
            onRefresh: () async {
              await Provide.value<OrderProvide>(context)
                  .onRefresh(context, true);
              _controller.resetLoadState(); // 重置加载状态
              _controller.finishRefresh(); // 完成刷新
              _controller.finishLoad(
                  noMore:
                      data.planList.length >= data.planTotal); // 加载完和判断是否能加载
            },
            onLoad: () async {
              await Provide.value<OrderProvide>(context).onLoad(context, true);
              _controller.finishLoad(
                  noMore:
                      data.planList.length >= data.planTotal); // 加载完和判断是否能加载
            },
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return InkWell(
                        child: OrderListItem(
                      data: data.planList[index],
                      isPlan: true,
                    ));
                  },
                  childCount: data.planList.length,
                ),
              ),
              ListNoMore(
                show: !data.planFirst && data.planList.length >= data.planTotal,
              )
            ],
          ),
        );
      },
    );
  }
}
