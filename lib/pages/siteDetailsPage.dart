/*
 * @Author: liangyt
 * @Date: 2019-12-23 16:36:39
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 11:37:11
 * @Description: 数据采集建设站点详情
 * @FilePath: /unicom_flutter/lib/pages/siteDetailsPage.dart
 */

import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/models/siteDetailsModel.dart';
import 'package:unicom_flutter/providers/siteDetailProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAmapView.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myDialog.dart';
import 'package:unicom_flutter/widgets/common/myDtuDialog.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myListBtn.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';
import 'package:unicom_flutter/widgets/common/signal.dart';

class SiteDetailsPage extends StatefulWidget {
  @override
  _SiteDetailsPageState createState() => _SiteDetailsPageState();
}

class _SiteDetailsPageState extends State<SiteDetailsPage> {
  EasyRefreshController _controller = EasyRefreshController();

  // 添加dtu
  showAddDtu(String imei) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDtuDialog(
              name: '添加DTU',
              imei: imei,
              fieldCallBack: (val) {
                Provide.value<SiteDetailProvide>(context).setImei(val);
              },
              scan: (val) {
                Provide.value<SiteDetailProvide>(context).setImei(val);
                Navigator.pop(context);
                showAddDtu(val);
              },
              cancel: () {
                Provide.value<SiteDetailProvide>(context).setImei('');
                Navigator.pop(context);
              },
              submit: () {
                Provide.value<SiteDetailProvide>(context).addDtu(context);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('站点详情'),
      body: SafeArea(
        child: CupertinoScrollbar(child: Provide<SiteDetailProvide>(
          builder: (BuildContext context, child, data) {
            if (data.isError) {
              _controller.finishRefresh();
            }
            if (data.callRefresh) {
              _controller.callRefresh();
            }
            return Column(
              children: <Widget>[_content(data), _fixContent(data)],
            );
          },
        )),
      ),
    );
  }

  // 非固定内容
  Widget _content(SiteDetailProvide data) {
    List<Widget> _list = [];
    if (data.siteData != null) {
      _list..addAll([_sliverTop(data), _sliverList(data.siteData)]);
    }
    return Expanded(
      child: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        emptyWidget: data.isLoad && data.siteData == null ? MyEmpty() : null,
        controller: _controller,
        enableControlFinishRefresh: true,
        firstRefresh: true,
        firstRefreshWidget: MyLoading(),
        onRefresh: () async {
          await Provide.value<SiteDetailProvide>(context).onRefresh(context);
          _controller.finishRefresh(); // 完成刷新
        },
        slivers: _list,
      ),
    );
  }

  // 站点顶部内容
  Widget _sliverTop(SiteDetailProvide data) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          _siteTop(data.siteData),
          _addDtu(data.disabled, data.imei)
        ],
      ),
    );
  }

  // 站点名称、地址
  Widget _siteTop(SiteDetailsModel siteData) {
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
                  child: Text(siteData.name, style: MyStyles.f30c33),
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
            onTap: () {
              print('点击了地址');
            },
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
                        siteData.address,
                        style: MyStyles.f26c99,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          siteData.status == 4
              ? Container(
                  padding: MyScreen.setEdge(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: MyStyles.borderColor))),
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
                            siteData.description,
                            style: MyStyles.f26c66,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  // 添加DTU
  Widget _addDtu(bool disabled, String imei) {
    return InkWell(
      onTap: () {
        if (disabled) return;
        showAddDtu(imei);
      },
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
  Widget _sliverList(SiteDetailsModel siteData) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
              onTap: () {
                // Provide.value<OrderDetailsProvide>(context)
                //     .setIdAndIslife(data.planList[index].id, true);
                // Application.router.navigateTo(context, '/orderDetails');
              },
              child: _dtuList(siteData.dtuList[index]));
        },
        childCount: siteData.dtuList.length,
      ),
    );
  }

  // dtu列表
  Widget _dtuList(DtuList dtuData) {
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
                'DTU${dtuData.id}',
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
                            dtuData.imei,
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
                          Padding(
                            padding: MyScreen.setEdge(left: 10),
                            child: Signal(
                              signal: dtuData.rssi ?? 0,
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
                              dtuData.wiredOnline ? '在线' : '离线',
                              style: dtuData.wiredOnline
                                  ? MyStyles.f26c52
                                  : MyStyles.f26ce0,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            _meterList(dtuData.ammeterList, dtuData.online)
          ],
        ),
      ),
    );
  }

  // 表列表
  Widget _meterList(List<AmmeterList> ammeterList, bool online) {
    if (ammeterList.length == 0) {
      return Container(
        height: MyScreen.setHeight(85),
        child: DefaultTextStyle(
          style: MyStyles.f24c99,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('未关联传感器/表，'),
              InkWell(
                onTap: () {
                  print('关联表');
                },
                child: Text('去关联',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: MyStyles.c666)),
              )
            ],
          ),
        ),
      );
    }
    return Container(
      padding: MyScreen.setEdge(top: 30),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Column(
        children: ammeterList.map((item) {
          String _name = item.name + item.sn;
          String _used = item.name.contains('表')
              ? item.used.toString() ?? ''
              : item.name.contains('水浸')
                  ? item.alarming ? '水浸' : '未水浸'
                  : item.temperature != null
                      ? '${item.temperature}℃/${item.humidity}%'
                      : '';
          int _status = item.status;
          if (!online && item.status == 0) {
            _status = 2;
          }
          return Container(
            margin: MyScreen.setEdge(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MyScreen.setWidth(390),
                  child: Text(_name),
                ),
                Container(
                  width: MyScreen.setWidth(200),
                  child: Text(_used),
                ),
                Expanded(
                  child: Text(
                    Utils.meterStatus(_status)['label'],
                    style: Utils.meterStatus(_status)['style'],
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
  Widget _fixContent(SiteDetailProvide data) {
    if (data.siteData == null || data.isAlarm) {
      return Container();
    }
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
          _fixLeftItem('设备总数', data.siteData.deviceNum),
          _fixLeftItem('已关联', data.siteData.linkNum),
          _fixRightBtn(
              data.disabled, data.siteData.canReceipt, data.siteData.linkNum)
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
  Widget _fixRightBtn(bool disabled, bool canReceipt, int linkNum) {
    return InkWell(
      child: Container(
        width: MyScreen.setWidth(250),
        height: MyScreen.setHeight(99),
        child: MySubmitBtn(
          txt: disabled ? '已回单' : canReceipt ? '回单' : '不可回单',
          textSty: MyStyles.f32cff,
          buttonColor: disabled || !canReceipt ? Colors.grey : null,
          submit: () {
            if (disabled) return;
            if (canReceipt) {
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyDialog(
                      title: '是否确定回单',
                      content: Container(
                        padding: MyScreen.setEdgeAll(30),
                        child: Text(
                          '回单后将无法修改设备关联信息，请确定',
                          style: MyStyles.f28c666,
                        ),
                      ),
                      submit: () {
                        Navigator.pop(context);
                        Provide.value<SiteDetailProvide>(context)
                            .submit(context);
                      },
                    );
                  });
            } else {
              if (linkNum == 0) Utils.showToast('请先关联设备');
            }
          },
        ),
      ),
    );
  }
}
