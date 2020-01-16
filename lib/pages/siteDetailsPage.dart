/*
 * @Author: liangyt
 * @Date: 2019-12-23 16:36:39
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-16 11:15:38
 * @Description: 数据采集建设站点详情
 * @FilePath: /unicom_flutter/lib/pages/siteDetailsPage.dart
 */

import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAmapView.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myListBtn.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class SiteDetailsPage extends StatefulWidget {
  @override
  _SiteDetailsPageState createState() => _SiteDetailsPageState();
}

class _SiteDetailsPageState extends State<SiteDetailsPage> {
  EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('站点详情'),
      body: SafeArea(
        child: CupertinoScrollbar(
            child: Column(
          children: <Widget>[_content(), _fixContent()],
        )),
      ),
    );
  }

  // 非固定内容
  Widget _content() {
    return Expanded(
      child: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        emptyWidget: false ? MyEmpty() : null,
        controller: _controller,
        enableControlFinishRefresh: true,
        // firstRefresh: true,
        // firstRefreshWidget: MyLoading(),
        onRefresh: () async {
          // await Provide.value<OrderProvide>(context)
          //     .onRefresh(context, false);
          // _controller.resetLoadState(); // 重置加载状态
          // _controller.finishRefresh(); // 完成刷新
          // _controller.finishLoad(
          //     noMore: data.lifeList.length >= data.lifeTotal); // 加载完和判断是否能加载
        },
        slivers: <Widget>[_sliverTop(), _sliverList()],
      ),
    );
  }

  // 站点顶部内容
  Widget _sliverTop() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[_siteTop(), _addDtu()],
      ),
    );
  }

  // 站点名称、地址
  Widget _siteTop() {
    return Container(
      padding: MyScreen.setEdge(left: 30, right: 30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: MyScreen.setEdge(top: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text('站点名称', style: MyStyles.f30c33),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: MyScreen.setEdge(left: 10, right: 10),
                      child: Text('操作手册', style: MyStyles.f26c66),
                    ),
                    MyAsset(
                      name: MyConstant.doubt,
                      width: 28,
                    )
                  ],
                )
              ],
            ),
          ),
          InkWell(
            child: Container(
              width: MyScreen.setWidth(480),
              padding: MyScreen.setEdge(left: 10, top: 5, right: 10, bottom: 5),
              margin: MyScreen.setEdge(bottom: 30),
              decoration: BoxDecoration(
                  color: MyStyles.f8f8f8,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyAsset(
                    name: MyConstant.noPosition,
                    width: 28,
                  ),
                  Expanded(
                    child: Container(
                      padding: MyScreen.setEdge(left: 10),
                      child: Text(
                        '深圳市和平路1085号富临酒店',
                        style: MyStyles.f26c99,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: MyScreen.setEdge(top: 20, bottom: 20),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: MyStyles.borderColor))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyListBtn(
                  name: '确认退回',
                  style: MyStyles.f26ce0,
                ),
                Expanded(
                  child: Container(
                    padding: MyScreen.setEdge(left: 10, top: 10),
                    child: Text(
                      '有设备未连接',
                      style: MyStyles.f26c66,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 添加DTU
  Widget _addDtu() {
    return InkWell(
      child: Container(
        margin: MyScreen.setEdge(top: 20),
        height: MyScreen.setHeight(88),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyAsset(
              name: MyConstant.add,
              width: 28,
            ),
            Padding(
              padding: MyScreen.setEdge(left: 20),
              child: Text(
                '添加DTU',
                style: MyStyles.f30c33,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Sliver列表
  Widget _sliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
              onTap: () {
                // Provide.value<OrderDetailsProvide>(context)
                //     .setIdAndIslife(data.planList[index].id, true);
                // Application.router.navigateTo(context, '/orderDetails');
              },
              child: _dtuList());
        },
        childCount: 5,
      ),
    );
  }

  // dtu列表
  Widget _dtuList() {
    return Container(
      padding: MyScreen.setEdge(left: 30, right: 30),
      margin: MyScreen.setEdge(top: 10),
      color: Colors.white,
      child: DefaultTextStyle(
        style: MyStyles.f30c66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // dtu id
            Container(
              padding: MyScreen.setEdge(top: 30),
              child: Text(
                'DTU1',
                style: TextStyle(
                    color: MyStyles.c333, fontWeight: FontWeight.w800),
              ),
            ),
            // imei 无线有线信号
            Container(
              margin: MyScreen.setEdge(top: 30, bottom: 30),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MyScreen.setWidth(400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('IMEI:', style: MyStyles.f26c99),
                        Expanded(
                          child: Text(
                            'asdasdasdasdasdsad',
                            style: MyStyles.f26c99,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text('无线:'),
                          Icon(
                            Icons.signal_cellular_connected_no_internet_4_bar,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text('有线:'),
                          Text(
                            '  离线',
                            style: MyStyles.f26ce0,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            _meterList()
          ],
        ),
      ),
    );
  }

  // 表列表
  Widget _meterList() {
    List list = [0, 1, 2, 3, 4, 5];
    return Container(
      padding: MyScreen.setEdge(top: 30),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Column(
        children: list.map((item) {
          return Container(
            margin: MyScreen.setEdge(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MyScreen.setWidth(250),
                  child: Text('三相四线表2'),
                ),
                Container(
                  width: MyScreen.setWidth(300),
                  child: Text('234324234'),
                ),
                Expanded(
                  child: Text(
                    Utils.meterStatus(0)['label'],
                    style: Utils.meterStatus(0)['style'],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // 底部固定内容
  Widget _fixContent() {
    return Container(
      width: double.infinity,
      height: MyScreen.setHeight(100),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _fixLeftItem('设备总数', 10),
          _fixLeftItem('已关联', 10),
          _fixRightBtn()
        ],
      ),
    );
  }

  // 底部固定内容数量item
  Widget _fixLeftItem(String name, int _num) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name, style: MyStyles.f30c66),
            Padding(
              padding: MyScreen.setEdge(left: 20),
              child: Text(
                '$_num',
                style: MyStyles.f36ce0,
              ),
            )
          ],
        ),
      ),
    );
  }

  // 底部固定内容右边按钮
  Widget _fixRightBtn() {
    return Container(
      width: MyScreen.setWidth(250),
      height: MyScreen.setHeight(99),
      child: MySubmitBtn(
        txt: '回单',
        textSty: MyStyles.f32cff,
        submit: () {
          print('点击回单');
        },
      ),
    );
  }
}
