/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:19:31
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 16:41:01
 * @Description: DTU详情
 * @FilePath: /unicom_flutter/lib/pages/dtuDetailPage.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/providers/dtuDetailProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/signal.dart';

class DtuDetailPage extends StatelessWidget {
  final EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('DTU详情'),
      body: CupertinoScrollbar(
        child: Provide<DtuDetailProvide>(
          builder: (BuildContext context, child, data) {
            return _content();
          },
        ),
      ),
    );
  }

  // 内容
  Widget _content() {
    List<Widget> _list = [];
    // if (data.siteData != null) {
    //   _list..addAll([_sliverTop(data), _sliverList(data.siteData)]);
    // }
    _list..addAll([_sliverTop(), _sliverList()]);
    return EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      emptyWidget: false ? MyEmpty() : null,
      controller: _controller,
      enableControlFinishRefresh: true,
      // firstRefresh: true,
      firstRefreshWidget: MyLoading(),
      onRefresh: () async {
        // await Provide.value<SiteDetailProvide>(context).onRefresh(context);
        // _controller.finishRefresh(); // 完成刷新
      },
      slivers: _list,
    );
  }

  // 非列表内容
  Widget _sliverTop() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[_dtuContent(), _upDataBox(), _addMeter()],
      ),
    );
  }

  // dtu内容
  Widget _dtuContent() {
    return Container(
      padding: MyScreen.setEdge(left: 30, right: 30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: MyScreen.setEdge(top: 30),
            child: Text(
              '富临-DTU1',
              style: MyStyles.f30c33,
            ),
          ),
          _imeiBox(),
          _dtuBox()
        ],
      ),
    );
  }

  // imei 有线无线状态
  Widget _imeiBox() {
    return Container(
      padding: MyScreen.setEdge(top: 30, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(400),
            child: Text(
              'gyujfkadsbfklafhkjahjf',
              style: MyStyles.f26c66,
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  Text('无线:'),
                  Padding(
                    padding: MyScreen.setEdge(left: 10),
                    child: Signal(
                      signal: 0,
                    ),
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
                  Padding(
                    padding: MyScreen.setEdge(left: 20),
                    child: Text(
                      true ? '在线' : '离线',
                      style: true ? MyStyles.f26c52 : MyStyles.f26ce0,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // dtu操作按钮布局
  Widget _dtuBox() {
    return Container(
      padding: MyScreen.setEdge(top: 20, bottom: 30),
      decoration: BoxDecoration(border: MyStyles.borderTop),
      child: Row(
        children: <Widget>[_dtuBoxItem(true), _dtuBoxItem(false)],
      ),
    );
  }

  // dtu操作按钮item
  Widget _dtuBoxItem(isReplace) {
    return Expanded(
      child: InkWell(
        onTap: () {
          print(isReplace);
        },
        child: Container(
          decoration:
              BoxDecoration(border: isReplace ? MyStyles.borderRight : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MyAsset(
                name: isReplace ? MyConstant.replace : MyConstant.stop,
                width: 36,
              ),
              Padding(
                padding: MyScreen.setEdge(left: 20),
                child: Text(
                  isReplace ? '更换DTU' : '停用DTU',
                  style: MyStyles.f26c99,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 立即更新数据
  Widget _upDataBox() {
    return Container(
      padding: MyScreen.setEdgeAll(30),
      child: Row(
        children: <Widget>[
          Container(
              child: DefaultTextStyle(
            style: MyStyles.f24c99,
            child: Column(
              children: <Widget>[
                Text('上一次数据更新时间2019-11-11 11:00'),
                Text('（每15分钟更新一次，下拉刷新页面）')
              ],
            ),
          )),
          Expanded(
            child: InkWell(
              onTap: () {
                print('立即更新');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MyAsset(
                    name: MyConstant.loading,
                    width: 28,
                  ),
                  Padding(
                    padding: MyScreen.setEdge(left: 20),
                    child: Text(
                      '立即更新',
                      style: MyStyles.f24c66,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // 添加电表
  Widget _addMeter() {
    return Container(
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
              '添加表/传感器',
              style: MyStyles.f30c33,
            ),
          )
        ],
      ),
    );
  }

  // 电表列表
  Widget _sliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
              onTap: () {
                // Application.router.navigateTo(context, '/dtuDetail');
              },
              child: Container());
        },
        childCount: 0,
      ),
    );
  }
}
