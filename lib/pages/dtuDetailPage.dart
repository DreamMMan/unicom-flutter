/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:19:31
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-18 14:07:25
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
import 'package:unicom_flutter/routes/application.dart';
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
            return _content(context);
          },
        ),
      ),
    );
  }

  // 内容
  Widget _content(context) {
    List<Widget> _list = [];
    // if (data.siteData != null) {
    //   _list..addAll([_sliverTop(data), _sliverList(data.siteData)]);
    // }
    _list..addAll([_sliverTop(context), _sliverList()]);
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
  Widget _sliverTop(context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[_dtuContent(), _upDataBox(), _addMeter(context)],
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
  Widget _addMeter(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/meter');
      },
      child: Container(
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
      ),
    );
  }

  // 电表列表
  Widget _sliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _meterList(
              index == 0 ? '水浸传感器' : index == 1 ? '温湿度传感器' : '三相四线表');
        },
        childCount: 3,
      ),
    );
  }

  // 电表item
  Widget _meterList(String type) {
    List<Widget> _list = [_meterInfo(type)];
    if (type.contains('表')) {
      _list..add(_meterLine());
    }
    return Container(
      margin: MyScreen.setEdge(top: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _list,
      ),
    );
  }

  // 表信息
  Widget _meterInfo(String type) {
    return Container(
        constraints: BoxConstraints(
          minHeight: MyScreen.setHeight(120),
        ),
        margin: MyScreen.setEdge(top: 10),
        padding: MyScreen.setEdge(top: type.contains('表') ? 33 : 46),
        color: Colors.white,
        child: DefaultTextStyle(
          style: MyStyles.f30c33,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MyScreen.setWidth(300),
                    alignment: Alignment.centerLeft,
                    padding: MyScreen.setEdge(left: 30),
                    child: Text(type),
                  ),
                  Expanded(
                    child: Text('水浸'),
                  ),
                  InkWell(
                    child: Container(
                      padding: MyScreen.setEdge(right: 40),
                      child: MyAsset(name: MyConstant.action, width: 28),
                    ),
                  )
                ],
              ),
              type.contains('表')
                  ? Padding(
                      padding: MyScreen.setEdge(
                          top: 20, left: 30, right: 40, bottom: 20),
                      child: Text('六路直流表1'),
                    )
                  : Container()
            ],
          ),
        ));
  }

  // 表线路
  Widget _meterLine() {
    return Container(
      padding: MyScreen.setEdge(left: 30, top: 30, right: 30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_lineItem(), _lineItem(), _lineItem()],
      ),
    );
  }

  // 表线路item
  Widget _lineItem() {
    if (true == true) {
      return IntrinsicHeight(
        child: Container(
          width: MyScreen.setWidth(690),
          margin: MyScreen.setEdge(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _lineItemLeft(),
              _lineItemStatus(),
              _lineDevice()
            ],
          ),
        ),
      );
    }
    return IntrinsicHeight(
      child: Container(
        width: MyScreen.setWidth(690),
        margin: MyScreen.setEdge(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  IntrinsicHeight(
                    child: Container(
                      margin: MyScreen.setEdge(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _lineItemLeft(),
                          _lineItemStatus(),
                        ],
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Container(
                      margin: MyScreen.setEdge(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _lineItemLeft(),
                          _lineItemStatus(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _lineDevice()
          ],
        ),
      ),
    );
  }

  // 路或相
  Widget _lineItemLeft() {
    return Container(
      width: MyScreen.setWidth(110),
      constraints: BoxConstraints(minHeight: MyScreen.setWidth(110)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: MyStyles.borderAll,
      ),
      child: Text(
        '1路',
        style: MyStyles.f26c33,
      ),
    );
  }

  // 路或相的状态
  Widget _lineItemStatus() {
    return Container(
      width: MyScreen.setWidth(140),
      constraints: BoxConstraints(minHeight: MyScreen.setWidth(110)),
      margin: MyScreen.setEdge(left: 20, right: 20),
      child: DefaultTextStyle(
        style: MyStyles.f26c52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('正常'),
            MyAsset(
              name: MyConstant.lineGreen,
              width: 120,
              height: 15,
            ),
            Text('36v/5A36v/5A36v/5A36v/5A36v/5A')
          ],
        ),
      ),
    );
  }

  // 路或相的设备
  Widget _lineDevice() {
    return Expanded(
      child: Container(
        padding: MyScreen.setEdge(top: 20, bottom: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(border: MyStyles.borderAll),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_lineDeviceText(), _lineDeviceIcon()],
        ),
      ),
    );
  }

  // 设备
  Widget _lineDeviceText() {
    Widget _device = Text(
      '点击关联设备',
      style: MyStyles.f26c99,
    );
    _device = Text(
      '动力设备（2）',
      style: MyStyles.f26c33,
    );
    _device = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
            text: '动力设备类型',
            style: MyStyles.f26c33,
          ),
          TextSpan(
            text: ' 设备ID设备ID设备ID设备ID',
            style: MyStyles.f22c33,
          )
        ])),
        Padding(
          padding: MyScreen.setEdge(top: 15),
          child: Text(
            '品牌-匹数/标称容量/规格型号',
            style: MyStyles.f22c99,
          ),
        ),
      ],
    );

    return Expanded(
      child: Container(
        padding: MyScreen.setEdge(left: 30),
        decoration: BoxDecoration(border: MyStyles.borderRight),
        child: _device,
      ),
    );
  }

  // 图标
  Widget _lineDeviceIcon() {
    return Container(
      width: MyScreen.setWidth(75),
      child: Icon(
        Icons.keyboard_arrow_right,
        color: MyStyles.c999,
      ),
    );
  }
}
