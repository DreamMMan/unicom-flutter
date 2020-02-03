/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:19:31
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-02-03 11:51:12
 * @Description: DTU详情
 * @FilePath: /unicom_flutter/lib/pages/dtuDetailPage.dart
 */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/models/dtuDetailModel.dart';
import 'package:unicom_flutter/models/newLineModel.dart';
import 'package:unicom_flutter/providers/dtuDetailProvide.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';
import 'package:unicom_flutter/widgets/common/myDialog.dart';
import 'package:unicom_flutter/widgets/common/myDtuDialog.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/signal.dart';

class DtuDetailPage extends StatefulWidget {
  @override
  _DtuDetailPageState createState() => _DtuDetailPageState();
}

class _DtuDetailPageState extends State<DtuDetailPage> {
  final EasyRefreshController _controller = EasyRefreshController();
  TimerUtil mTimerUtil;
  int countdown = 60;

  // 倒计时
  void countTime() {
    mTimerUtil = new TimerUtil(mInterval: 1000, mTotalTime: 60000);
    mTimerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        countdown = _tick.toInt();
      });
      if (_tick.toInt() == 0) {
        setState(() {
          countdown = 60;
        });
        mTimerUtil.cancel();
      }
    });
    mTimerUtil.startCountDown();
  }

  // 更换dtu
  showAddDtu(String imei) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDtuDialog(
              name: '更换DTU',
              imei: imei,
              fieldCallBack: (val) {
                Provide.value<DtuDetailProvide>(context).setImei(val);
              },
              scan: (val) {
                Provide.value<DtuDetailProvide>(context).setImei(val);
                Navigator.pop(context);
                showAddDtu(val);
              },
              cancel: () {
                Provide.value<DtuDetailProvide>(context).setImei('');
                Navigator.pop(context);
              },
              submit: () {
                Provide.value<DtuDetailProvide>(context).addDtu(context);
              });
        });
  }

  // 停用DTU
  stopDtu() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyDialog(
            title: '停用DTU',
            content: Container(
              padding: MyScreen.setEdgeAll(30),
              child: Text(
                '停用后，DTU下的表以及表各路与设备的关联关系将被清除。如果要保留关联关系，请使用“更换DTU”操作',
                style: MyStyles.f28c666,
              ),
            ),
            submit: () {
              Navigator.pop(context);
              Provide.value<DtuDetailProvide>(context).stopDtu(context);
            },
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    if (mTimerUtil != null) mTimerUtil.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('DTU详情'),
      body: CupertinoScrollbar(
        child: Provide<DtuDetailProvide>(
          builder: (BuildContext context, child, data) {
            if (data.isError) {
              _controller.finishRefresh();
            }
            if (data.callRefresh) {
              _controller.callRefresh();
            }
            return _content(data);
          },
        ),
      ),
    );
  }

  // 内容
  Widget _content(DtuDetailProvide data) {
    List<Widget> _list = [];
    if (data.dtuData != null) {
      _list..addAll([_sliverTop(data), _sliverList(data)]);
    }
    return EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      emptyWidget: data.isLoad && data.dtuData == null ? MyEmpty() : null,
      controller: _controller,
      enableControlFinishRefresh: true,
      firstRefresh: true,
      firstRefreshWidget: MyLoading(),
      onRefresh: () async {
        await Provide.value<DtuDetailProvide>(context).onRefresh(context);
        _controller.finishRefresh(); // 完成刷新
      },
      slivers: _list,
    );
  }

  // 非列表内容
  Widget _sliverTop(DtuDetailProvide data) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          _dtuContent(data),
          _upDataBox(data),
          _addMeter(data)
        ],
      ),
    );
  }

  // dtu内容
  Widget _dtuContent(DtuDetailProvide data) {
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
              'DTU${data.dtuData.id}',
              style: MyStyles.f30c33,
            ),
          ),
          _imeiBox(data.dtuData),
          _dtuBox(data)
        ],
      ),
    );
  }

  // imei 有线无线状态
  Widget _imeiBox(DtuDetailModel dtuData) {
    return Container(
      padding: MyScreen.setEdge(top: 30, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(400),
            child: Text(
              dtuData.imei,
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
                      signal: dtuData.rssi ?? 0.0,
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
    );
  }

  // dtu操作按钮布局
  Widget _dtuBox(DtuDetailProvide data) {
    return Container(
      padding: MyScreen.setEdge(top: 20, bottom: 30),
      decoration: BoxDecoration(border: MyStyles.borderTop),
      child: Row(
        children: <Widget>[_dtuBoxItem(true, data), _dtuBoxItem(false, data)],
      ),
    );
  }

  // dtu操作按钮item
  Widget _dtuBoxItem(bool isReplace, DtuDetailProvide data) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (data.disabled) return;
          if (isReplace) {
            showAddDtu(data.imei);
          } else {
            stopDtu();
          }
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
  Widget _upDataBox(DtuDetailProvide data) {
    return Container(
      padding: MyScreen.setEdgeAll(30),
      child: Row(
        children: <Widget>[
          Container(
              child: DefaultTextStyle(
            style: MyStyles.f24c99,
            child: Column(
              children: <Widget>[
                Text(
                    '上一次数据更新时间${DateUtil.formatDateMs(data.dtuData.updateTime, format: "MM-dd HH:mm")}'),
                Text('（每15分钟更新一次，下拉刷新页面）')
              ],
            ),
          )),
          Expanded(
            child: InkWell(
              onTap: () async {
                if (data.disabled || countdown != 60) return;
                await Provide.value<DtuDetailProvide>(context).upData(context);
                countTime();
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
                      countdown == 60 ? '立即更新' : '$countdown s',
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
  Widget _addMeter(DtuDetailProvide data) {
    return InkWell(
      onTap: () {
        if (data.disabled) return;
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
  Widget _sliverList(DtuDetailProvide data) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _meterList(data.dtuData.ammeterList[index]);
        },
        childCount: data.dtuData.ammeterList.length,
      ),
    );
  }

  // 电表item
  Widget _meterList(AmmeterList merterData) {
    List<Widget> _list = [_meterInfo(merterData)];
    if (merterData.name.contains('表')) {
      _list..add(_meterLine(merterData));
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
  Widget _meterInfo(AmmeterList merterData) {
    return Container(
        constraints: BoxConstraints(
          minHeight: MyScreen.setHeight(120),
        ),
        margin: MyScreen.setEdge(top: 10),
        padding: MyScreen.setEdge(top: merterData.name.contains('表') ? 33 : 46),
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
                    child: Text(merterData.name.contains('传感器')
                        ? merterData.name
                        : merterData.ammeterName),
                  ),
                  Expanded(
                    child: Text(merterData.name.contains('水浸传感器')
                        ? (merterData.alarming ? '水浸' : '未水浸')
                        : (merterData.name.contains('温湿度传感器')
                            ? "${merterData.temperature}℃/${merterData.humidity}%"
                            : "${merterData.used}")),
                  ),
                  InkWell(
                    child: Container(
                      padding: MyScreen.setEdge(right: 40),
                      child: MyAsset(name: MyConstant.action, width: 28),
                    ),
                  )
                ],
              ),
              merterData.name.contains('表')
                  ? Padding(
                      padding: MyScreen.setEdge(
                          top: 20, left: 30, right: 40, bottom: 20),
                      child: Text(merterData.name),
                    )
                  : Container()
            ],
          ),
        ));
  }

  // 表线路
  Widget _meterLine(AmmeterList merterData) {
    // 重新组合相或路列表
    List _list = Utils.regroup(merterData.lineList);
    return Container(
      padding: MyScreen.setEdge(left: 30, top: 30, right: 30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _list.map((lineData) {
          return _lineItem(lineData);
        }).toList(),
      ),
    );
  }

  // 表线路item
  Widget _lineItem(NewLineMode lineData) {
    if (lineData.flag == false) {
      return IntrinsicHeight(
        child: Container(
          width: MyScreen.setWidth(690),
          margin: MyScreen.setEdge(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _lineItemLeft(lineData.list[0]),
              _lineItemStatus(lineData.list[0]),
              _lineDevice(lineData.deviceList)
            ],
          ),
        ),
      );
    }
    return IntrinsicHeight(
        // child: Container(
        //   width: MyScreen.setWidth(690),
        //   margin: MyScreen.setEdge(bottom: 30),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: <Widget>[
        //       Container(
        //         child: Column(
        //           children: <Widget>[
        //             IntrinsicHeight(
        //               child: Container(
        //                 margin: MyScreen.setEdge(bottom: 20),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
        //                   children: <Widget>[
        //                     _lineItemLeft(lineData),
        //                     _lineItemStatus(lineData),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             IntrinsicHeight(
        //               child: Container(
        //                 margin: MyScreen.setEdge(bottom: 20),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
        //                   children: <Widget>[
        //                     _lineItemLeft(lineData),
        //                     _lineItemStatus(lineData),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       _lineDevice(lineData)
        //     ],
        //   ),
        // ),
        );
  }

  // 路或相
  Widget _lineItemLeft(LineList lineData) {
    return Container(
      width: MyScreen.setWidth(110),
      constraints: BoxConstraints(minHeight: MyScreen.setWidth(110)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: MyStyles.borderAll,
      ),
      child: Text(
        lineData.name,
        style: MyStyles.f26c33,
      ),
    );
  }

  // 路或相的状态
  Widget _lineItemStatus(LineList lineData) {
    return Container(
      width: MyScreen.setWidth(140),
      constraints: BoxConstraints(minHeight: MyScreen.setWidth(110)),
      margin: MyScreen.setEdge(left: 20, right: 20),
      child: DefaultTextStyle(
        style: lineData.status == 0
            ? MyStyles.f26c52
            : lineData.status == 1 ? MyStyles.f26c99 : MyStyles.f26ce0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(lineData.status == 0
                ? '正常'
                : lineData.status == 1 ? '未关联' : '异常'),
            MyAsset(
              name: lineData.status == 0
                  ? MyConstant.lineGreen
                  : lineData.status == 1
                      ? MyConstant.lineGray
                      : MyConstant.lineRed,
              width: 120,
              height: 15,
            ),
            Text('${lineData.voltage ?? 0}v/${lineData.current ?? 0}A')
          ],
        ),
      ),
    );
  }

  // 路或相的设备
  Widget _lineDevice(List<DeviceList> deviceList) {
    return Expanded(
      child: Container(
        padding: MyScreen.setEdge(top: 20, bottom: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(border: MyStyles.borderAll),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_lineDeviceText(deviceList), _lineDeviceIcon()],
        ),
      ),
    );
  }

  // 设备
  Widget _lineDeviceText(List<DeviceList> deviceList) {
    Widget _device;
    if (deviceList.length == 0) {
      _device = Text(
        '点击关联设备',
        style: MyStyles.f26c99,
      );
    } else if (deviceList.length == 1) {
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
    } else {
      _device = Text(
        '动力设备（2）',
        style: MyStyles.f26c33,
      );
    }
    // Widget _device = Text(
    //   '点击关联设备',
    //   style: MyStyles.f26c99,
    // );
    // _device = Text(
    //   '动力设备（2）',
    //   style: MyStyles.f26c33,
    // );
    // _device = Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     Text.rich(TextSpan(children: <TextSpan>[
    //       TextSpan(
    //         text: '动力设备类型',
    //         style: MyStyles.f26c33,
    //       ),
    //       TextSpan(
    //         text: ' 设备ID设备ID设备ID设备ID',
    //         style: MyStyles.f22c33,
    //       )
    //     ])),
    //     Padding(
    //       padding: MyScreen.setEdge(top: 15),
    //       child: Text(
    //         '品牌-匹数/标称容量/规格型号',
    //         style: MyStyles.f22c99,
    //       ),
    //     ),
    //   ],
    // );

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
