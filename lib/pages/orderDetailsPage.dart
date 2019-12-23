/*
 * @Author: liangyt
 * @Date: 2019-12-21 16:17:13
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 10:13:09
 * @Description: 工单详情
 * @FilePath: /unicom_flutter/lib/pages/orderDetails.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/orderDetailsProvide.dart';
import 'package:unicom_flutter/utils/constant.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/showBottomSheet.dart';
import 'package:unicom_flutter/widgets/list/listNoMore.dart';
import 'package:unicom_flutter/widgets/list/siteListItem.dart';
import 'package:unicom_flutter/widgets/list/sliverAppBarDelegate.dart';

class OrderDetailsPage extends StatelessWidget {
  final EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('工单详情'),
      body: Provide<OrderDetailsProvide>(builder: (context, child, data) {
        // 报错时 关闭刷新 关闭加载
        if (data.isError) {
          _controller.finishRefresh();
          _controller.finishLoad();
        }
        // 触发刷新
        if (data.isCallRefresh) {
          _controller.callRefresh();
        }
        return Container(
          child: EasyRefresh.custom(
            header: MaterialHeader(),
            footer: MaterialFooter(),
            emptyWidget: false ? MyEmpty() : null,
            controller: _controller,
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            firstRefresh: true,
            firstRefreshWidget: MyLoading(),
            onRefresh: () async {
              await Provide.value<OrderDetailsProvide>(context)
                  .onRefresh(context);
              _controller.resetLoadState(); // 重置加载状态
              _controller.finishRefresh(); // 完成刷新
              _controller.finishLoad(
                  noMore: data.list.length >= data.total); // 加载完和判断是否能加载
            },
            onLoad: () async {
              await Provide.value<OrderDetailsProvide>(context).onLoad(context);
              _controller.finishLoad(
                  noMore: data.list.length >= data.total); // 加载完和判断是否能加载
            },
            slivers: <Widget>[
              topContent(),
              fixContent(context),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return InkWell(
                        child: SiteListItem(
                      data: data.list[index],
                    ));
                  },
                  childCount: data.list.length,
                ),
              ),
              ListNoMore(
                show: true,
              )
            ],
          ),
        );
      }),
    );
  }

  // 顶部内容
  Widget topContent() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[orderContent(), siteNum()],
      ),
    );
  }

  // 工单内容
  Widget orderContent() {
    return Container(
      padding: setEdge(left: 30, top: 30, right: 30, bottom: 30),
      color: Colors.white,
      child: DefaultTextStyle(
        style: f26c99,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '采集建设工单',
                  style: f36c33,
                ),
                Padding(
                  padding: setEdge(left: 40),
                  child: Text('1234567899555'),
                )
              ],
            ),
            Padding(
              padding: setEdge(top: 20),
              child: Text('计划完成时间：2019-03-29'),
            ),
            Padding(
              padding: setEdge(top: 20),
              child: Text('作业内容：完成数据采集建设工作'),
            )
          ],
        ),
      ),
    );
  }

  // 站点状态数量
  Widget siteNum() {
    return Container(
      margin: setEdge(top: 10),
      height: setHeight(150),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          siteNumItem('站点总数', 4),
          siteNumItem('进行中', 1),
          siteNumItem('审核驳回', 1),
          siteNumItem('已完成', 1)
        ],
      ),
    );
  }

  // 站点数量item
  Widget siteNumItem(String name, int _num) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('$_num', style: f36c33),
          Text(
            name,
            style: f26c66,
          )
        ],
      ),
    );
  }

  // 固定的头部
  Widget fixContent(context) {
    return SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: SliverAppBarDelegate(
          maxHeight: setHeight(180),
          minHeight: setHeight(180),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[listTitle(), searchBox(context)],
          )),
    );
  }

  // 列表名字
  Widget listTitle() {
    return Container(
      height: setHeight(80),
      alignment: Alignment.centerLeft,
      padding: setEdge(left: 30),
      color: pageBg,
      child: Text('作业站点列表', style: f30c66),
    );
  }

  // 搜索框
  Widget searchBox(context) {
    return Container(
      height: setHeight(100),
      padding: setEdge(left: 30, right: 30),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              showModal(context);
            },
            child: Row(
              children: <Widget>[
                Text(
                  '区域（全部）',
                  style: f24c66,
                ),
                Transform(
                  transform: Matrix4.identity()..rotateZ(45),
                  origin: Offset(6, 3), // 旋转的中心点
                  child: Icon(
                    Icons.arrow_right,
                    size: setWidth(36),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: setHeight(60),
              alignment: Alignment.centerLeft,
              padding: setEdge(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: pageBg, borderRadius: BorderRadius.circular(5)),
              child: MyInput(
                  iconName: Constant.searchIcon,
                  paddingHeight: 20,
                  hintText: '站点/编号/地址',
                  hintStyle: f24c99,
                  fieldCallBack: (value) {
                    print(value);
                  }),
            ),
          )
        ],
      ),
    );
  }

  // 底部选项卡
  showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: d9DEE1,
        builder: (BuildContext context) {
          return ShowBottomSheet(
            list: Constant.regionList,
            titleName: '请选择站点区域',
            tap: (data) async {
              print(data);
            },
          );
        });
  }
}
