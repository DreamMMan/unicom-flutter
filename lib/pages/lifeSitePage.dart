/*
 * @Author: liangyt
 * @Date: 2020-01-03 20:10:50
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-04 21:12:51
 * @Description: 生命周期站点详情
 * @FilePath: /unicom-flutter/lib/pages/lifeSitePage.dart
 */
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/models/LifeSiteDetailsModel.dart';
import 'package:unicom_flutter/providers/lifeSiteDetailsProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/utils/index.dart';
import 'package:unicom_flutter/widgets/common/MyExpansionPanel.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class LifeSitePage extends StatefulWidget {
  @override
  _LifeSitePageState createState() => _LifeSitePageState();
}

class _LifeSitePageState extends State<LifeSitePage> {
  int _index = -1; // 当前选中的索引

  @override
  Widget build(BuildContext context) {
    return Provide<LifeSiteDetailsProvide>(
      builder: (BuildContext context, child, data) {
        if (data.isLoad && data.siteData == null) {
          return MyEmpty();
        }
        if (!data.isLoad && data.siteData == null) {
          return MyLoading();
        }
        return Scaffold(
          appBar: myAppBar(data.title),
          body: CupertinoScrollbar(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[_content(data), _bottom(data.siteData)],
              ),
            ),
          ),
        );
      },
    );
  }

  // 非底部固定内容
  Widget _content(LifeSiteDetailsProvide data) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _topContent(data.siteData),
              _listTitle(data),
              _equipment(data.deviceList)
            ],
          ),
        ),
      ),
    );
  }

  // 站点名称和地址
  Widget _topContent(LifeSiteDetailsModel siteData) {
    return Container(
      width: double.infinity,
      padding: MyScreen.setEdgeAll(30),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  siteData.name,
                  style: MyStyles.f36c33,
                ),
                Padding(
                  padding: MyScreen.setEdge(top: 20),
                  child: Text(
                    siteData.address,
                    style: MyStyles.f26c66,
                  ),
                )
              ],
            ),
          ),
          siteData.targetName != null
              ? Padding(
                  padding: MyScreen.setEdge(left: 20, right: 20),
                  child: Icon(
                    MyConstant.arrowIcon,
                    size: 30,
                    color: MyStyles.cccc,
                  ),
                )
              : Container(),
          siteData.targetName != null
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        siteData.targetName,
                        style: MyStyles.f36c33,
                      ),
                      Padding(
                        padding: MyScreen.setEdge(top: 20),
                        child: Text(
                          siteData.targetAddress,
                          style: MyStyles.f26c66,
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  // 列表名称
  Widget _listTitle(LifeSiteDetailsProvide data) {
    return Container(
      padding: MyScreen.setEdge(left: 30, top: 20, bottom: 24),
      child: Text(
        data.title,
        style: MyStyles.f30c33,
      ),
    );
  }

  // 设备列表
  Widget _equipment(List<dynamic> deviceList) {
    return Container(
        child: Column(
      children: deviceList.asMap().keys.map((index) {
        if (deviceList[index]['list'].length == 0) {
          return Container();
        }
        return Padding(
          padding: MyScreen.setEdge(bottom: 20),
          child: MyExpansionPanel(
              isExpanded: _index == index,
              expansionCallback: () {
                setState(() {
                  _index = index == _index ? -1 : index;
                });
              },
              title: _panelTitle(
                  deviceList[index]['name'], deviceList[index]['list'].length),
              body: _panelContent(
                  deviceList[index]['name'], deviceList[index]['list'])),
        );
      }).toList(),
    ));
  }

  // 面板title
  Widget _panelTitle(String name, int _num) {
    return Container(
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(text: name, style: MyStyles.f30c33),
        TextSpan(text: '  ($_num)', style: MyStyles.f30c99)
      ])),
    );
  }

  // 面板内容
  Widget _panelContent(String name, List<dynamic> deviceList) {
    return Container(
      child: Column(
        children: deviceList.asMap().keys.map((index) {
          return _panelContentItem(name, deviceList[index]);
        }).toList(),
      ),
    );
  }

  // 面板内容Item
  Widget _panelContentItem(String name, DeviceList listData) {
    return Container(
      padding: MyScreen.setEdge(left: 30, top: 30, right: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Wrap(
        children: <Widget>[
          _lineItem('设备  I  D：', listData.deviceSn),
          _lineItem('资产编号：', listData.assetsSn),
          _lineItem('品        牌：', listData.brandName),
          name == '空调'
              ? _lineItem('匹       数：', listData.power)
              : Container(
                  width: 0,
                ),
          (name == '开关电源' || name == '动环监控')
              ? _lineItem('规格型号：', listData.specificationModel)
              : Container(
                  width: 0,
                ),
          name == '开关电源'
              ? _lineItem('模块型号：', listData.moduleModel)
              : Container(
                  width: 0,
                ),
          name == '开关电源'
              ? _lineItem('模块配置数量：', listData.moduleNum.toString())
              : Container(
                  width: 0,
                ),
          name == '开关电源'
              ? _lineItem('模块容量：', listData.capacity)
              : Container(
                  width: 0,
                ),
          name == '开关电源'
              ? _lineItem('是否满足N+1配置：', listData.canN1 ? '是' : '否')
              : Container(
                  width: 0,
                ),
          name == '���电池'
              ? _lineItem('标称容量：', listData.capacity)
              : Container(
                  width: 0,
                ),
          name == '蓄电池'
              ? _lineItem('组数：', listData.num.toString())
              : Container(
                  width: 0,
                ),
          name == '蓄电池'
              ? _lineItem('后备时长(小时)：', listData.backupTime.toString())
              : Container(
                  width: 0,
                ),
          _lineItem('运行状态：', Utils.runStatus(listData.status)),
          _lineItem('使用状态：', Utils.userStatus(listData.usedStatus)),
          name != '开关电源'
              ? _lineItem(
                  '启用日期：',
                  DateUtil.formatDateMs(listData.enableTime,
                          format: "yyyy-MM-dd")
                      .toString())
              : Container(
                  width: 0,
                )
        ],
      ),
    );
  }

  Widget _lineItem(String name, String value) {
    return Container(
      width: MyScreen.setWidth(340),
      padding: MyScreen.setEdge(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name),
          Expanded(
            child: Text(value),
          )
        ],
      ),
    );
  }

  // 底部的固定内容
  Widget _bottom(LifeSiteDetailsModel siteData) {
    if (siteData.status != 3) {
      return Container();
    }
    return Container(
      width: MyScreen.setWidth(750),
      height: MyScreen.setHeight(100),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Row(
        children: <Widget>[
          Container(
            width: MyScreen.setWidth(300),
            padding: MyScreen.setEdge(left: 40),
            child: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(text: '设备数量： ', style: MyStyles.f30c66),
              TextSpan(
                  text: '${siteData.deviceList.length}',
                  style: MyStyles.f30ce2),
            ])),
          ),
          InkWell(
            child: Container(
              width: MyScreen.setWidth(450),
              height: MyScreen.setHeight(100),
              child: MySubmitBtn(
                txt: '确认',
                textSty: MyStyles.f32cff,
                submit: () {
                  print('确认');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
