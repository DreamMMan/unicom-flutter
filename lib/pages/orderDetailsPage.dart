/*
 * @Author: liangyt
 * @Date: 2019-12-21 16:17:13
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-14 09:44:02
 * @Description: 工单详情
 * @FilePath: /unicom_flutter/lib/pages/orderDetails.dart
 */

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/models/orderDetailsModel.dart';
import 'package:unicom_flutter/providers/lifeSiteDetailsProvide.dart';
import 'package:unicom_flutter/providers/orderDetailsProvide.dart';
import 'package:unicom_flutter/providers/rpinsProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/showBottomSheet.dart';
import 'package:unicom_flutter/widgets/list/lifeSiteListItem.dart';
import 'package:unicom_flutter/widgets/list/listNoMore.dart';
import 'package:unicom_flutter/widgets/list/planSiteListItem.dart';
import 'package:unicom_flutter/widgets/list/sliverAppBarDelegate.dart';
import 'package:unicom_flutter/widgets/list/trfSiteListItem.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('工单详情'),
      resizeToAvoidBottomPadding: false,
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
        return CupertinoScrollbar(
          child: EasyRefresh.custom(
            header: MaterialHeader(),
            footer: MaterialFooter(),
            emptyWidget: null,
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
              topContent(data.orderData, data),
              fixContent(context, data),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Widget listIem;
                    if (data.isLife && data.orderData.name != '设备调拨') {
                      listIem = LifeSiteListItem(data: data.list[index]);
                    } else if (data.isLife && data.orderData.name == '设备调拨') {
                      listIem = TrfSiteListItem(data: data.list[index]);
                    } else {
                      listIem = PlanSiteListItem(data: data.list[index]);
                    }
                    return InkWell(
                        onTap: () {
                          if (data.isLife) {
                            // 生命周期站点详情
                            Provide.value<LifeSiteDetailsProvide>(context)
                                .setId(context, data.list[index].id,
                                    data.orderData.name);
                            Application.router.navigateTo(context, '/lifeSite');
                          } else {
                            switch (Utils.orderType(data.orderData.name)) {
                              case 0:
                                // 数据采集建设站点详情
                                Application.router
                                    .navigateTo(context, '/siteDetails');
                                break;
                              case 1:
                                // 动力设备站点详情
                                Provide.value<RpinsProvide>(context)
                                    .getData(context, data.list[index].id);
                                Application.router.navigateTo(context, '/rpIn');
                                break;
                              case 2:
                                // 空调蓄电池站点详情
                                Application.router
                                    .navigateTo(context, '/airBat');
                                break;
                              default:
                                Application.router
                                    .navigateTo(context, '/siteDetails');
                            }
                          }
                        },
                        child: listIem);
                  },
                  childCount: data.list.length,
                ),
              ),
              ListNoMore(
                show: data.isLoaded && data.list.length >= data.total,
              )
            ],
          ),
        );
      }),
    );
  }

  // 顶部内容
  Widget topContent(OrderDetailsModel orderData, data) {
    return SliverToBoxAdapter(
      child: orderData == null
          ? Container()
          : Column(
              children: <Widget>[
                orderContent(orderData, data),
                siteNum(orderData, data),
                listTitle()
              ],
            ),
    );
  }

  // 工单内容
  Widget orderContent(OrderDetailsModel orderData, data) {
    return Container(
      padding: MyScreen.setEdgeAll(30),
      color: Colors.white,
      child: DefaultTextStyle(
        style: MyStyles.f26c99,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  orderData.name,
                  style: MyStyles.f36c33,
                ),
                Padding(
                  padding: MyScreen.setEdge(left: 40),
                  child: Text(orderData.ticketNo),
                )
              ],
            ),
            Padding(
              padding: MyScreen.setEdge(top: 20),
              child: data.isLife
                  ? Text(
                      '${DateUtil.formatDateMs(orderData.createdTime, format: "yyyy-MM-dd HH-mm-ss")}')
                  : Text(
                      '计划完成时间：${DateUtil.formatDateMs(orderData.plannedTime, format: "yyyy-MM-dd")}'),
            ),
            data.isLife
                ? Container()
                : Padding(
                    padding: MyScreen.setEdge(top: 20),
                    child: Text('作业内容：${orderData.content}'),
                  )
          ],
        ),
      ),
    );
  }

  // 站点状态数量
  Widget siteNum(OrderDetailsModel orderData, data) {
    List<Widget> list = [];
    if (data.isLife) {
      list
        ..add(siteNumItem('站点总数', orderData.totalSite))
        ..add(siteNumItem('待确认', orderData.processingNum));
    } else {
      list
        ..add(siteNumItem('站点总数', orderData.totalSite))
        ..add(siteNumItem('进行中', orderData.processingNum))
        ..add(siteNumItem('确认退回', orderData.rejectionNum))
        ..add(siteNumItem('已完成', orderData.completedNum));
    }
    return Container(
      margin: MyScreen.setEdge(top: 10),
      height: MyScreen.setHeight(150),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list,
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
          Text('$_num', style: MyStyles.f36c33),
          Text(
            name,
            style: MyStyles.f26c66,
          )
        ],
      ),
    );
  }

  // 固定的头部
  Widget fixContent(context, data) {
    return SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: SliverAppBarDelegate(
          maxHeight: MyScreen.setHeight(100),
          minHeight: MyScreen.setHeight(100),
          child: searchBox(context, data)),
    );
  }

  // 列表名字
  Widget listTitle() {
    return Container(
      height: MyScreen.setHeight(80),
      alignment: Alignment.centerLeft,
      padding: MyScreen.setEdge(left: 30),
      color: MyStyles.pageBg,
      child: Text('作业站点列表', style: MyStyles.f30c66),
    );
  }

  // 搜索框
  Widget searchBox(context, data) {
    return Container(
      height: MyScreen.setHeight(100),
      padding: MyScreen.setEdge(left: 30, right: 30),
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
                  data.region,
                  style: MyStyles.f24c66,
                ),
                Transform(
                  transform: Matrix4.identity()..rotateZ(45),
                  origin: Offset(6, 6), // 旋转的中心点
                  child: Icon(
                    Icons.arrow_right,
                    size: MyScreen.setWidth(36),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MyScreen.setHeight(60),
              alignment: Alignment.centerLeft,
              padding: MyScreen.setEdge(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: MyStyles.pageBg,
                  borderRadius: BorderRadius.circular(5)),
              child: MyInput(
                  iconName: MyConstant.searchIcon,
                  paddingHeight: 20,
                  hintText: '站点/编号/地址',
                  hintStyle: MyStyles.f24c99,
                  textInputAction: 'search',
                  fieldCallBack: (value) {
                    Provide.value<OrderDetailsProvide>(context)
                        .setkeyWorld(value);
                  },
                  submit: (value) {
                    _controller.callRefresh();
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
        backgroundColor: MyStyles.d9DEE1,
        builder: (BuildContext context) {
          return ShowBottomSheet(
            list: MyConstant.regionList,
            titleName: '请选择站点区域',
            tap: (data) async {
              Provide.value<OrderDetailsProvide>(context).setRegion(
                  MyConstant.regionList[data]['name'],
                  MyConstant.regionList[data]['code']);
            },
          );
        });
  }
}
