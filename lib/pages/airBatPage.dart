/*
 * @Author: liangyt
 * @Date: 2020-01-03 20:16:01
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 16:11:47
 * @Description: 空调清洗作业 蓄电池放电测试作业
 * @FilePath: /unicom-flutter/lib/pages/airBatPage.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/models/airBatModel.dart';
import 'package:unicom_flutter/providers/airBatProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myDialogImage.dart';
import 'package:unicom_flutter/widgets/common/myEmpty.dart';
import 'package:unicom_flutter/widgets/common/myInput.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'package:unicom_flutter/widgets/common/mySubmitBtn.dart';

class AirBatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('作业详情'),
      body: Provide<AirBatProvide>(
        builder: (BuildContext context, child, data) {
          if (data.isLoad && data.pageData == null) {
            return MyEmpty();
          }
          if (!data.isLoad && data.pageData == null) {
            return MyLoading();
          }
          return SingleChildScrollView(
            child: CupertinoScrollbar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _topContent(data.lastData),
                  _uploadImage(context, data.nameList),
                  _listContent(context, data.deviceList),
                  _submitBox(context, data.pageData.submit)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 顶部内容
  Widget _topContent(List lastData) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdgeAll(30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${lastData[0]}',
            style: MyStyles.f36c33,
          ),
          Padding(
            padding: MyScreen.setEdge(top: 20),
            child: Text(
              '${lastData[1]}',
              style: MyStyles.f26c66,
            ),
          ),
          lastData[2] == 4
              ? Container(
                  width: MyScreen.setWidth(690),
                  padding: MyScreen.setEdge(top: 30),
                  margin: MyScreen.setEdge(top: 30),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: MyStyles.borderColor))),
                  child: Text('审核驳回：${lastData[3]}', style: MyStyles.f26ce0),
                )
              : Container()
        ],
      ),
    );
  }

// 上传图片
  Widget _uploadImage(BuildContext context, List<String> nameList) {
    return Container(
      width: MyScreen.setWidth(750),
      padding: MyScreen.setEdgeAll(30),
      margin: MyScreen.setEdge(top: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: MyScreen.setEdge(bottom: 20),
            child: Text('上传照片', style: MyStyles.f30c33),
          ),
          Wrap(
            spacing: MyScreen.setWidth(10),
            runSpacing: MyScreen.setWidth(10),
            children: nameList.asMap().keys.map((index) {
              return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext contetx) {
                        return MyDialogImage(
                          index: index,
                          list: nameList,
                          isLook: false,
                          type: 1,
                          delete: (int index) {
                            nameList.removeAt(index);
                            Provide.value<AirBatProvide>(context)
                                .setnameList(nameList);
                          },
                        );
                      });
                },
                child: _imageItem(nameList[index]),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _imageItem(String url) {
    return Container(
      width: MyScreen.setWidth(130),
      height: MyScreen.setWidth(130),
      child: Image.network(
        url,
        fit: BoxFit.contain,
      ),
    );
  }

  // 列表内容
  Widget _listContent(BuildContext context, List<DeviceList> deviceList) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: deviceList.asMap().keys.map((index) {
          return _listItem(context, deviceList, index);
        }).toList(),
      ),
    );
  }

  // 列表
  Widget _listItem(
      BuildContext context, List<DeviceList> deviceList, int index) {
    return Container(
      width: MyScreen.setWidth(750),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _listItemTitle(deviceList[index]),
          _listItemContent(context, deviceList, index)
        ],
      ),
    );
  }

  // 品牌名和 设备号
  Widget _listItemTitle(DeviceList deviceData) {
    return Container(
      height: MyScreen.setHeight(80),
      padding: MyScreen.setEdge(left: 30),
      child: Row(
        children: <Widget>[
          Text(
            deviceData.name,
            style: MyStyles.f30c33,
          ),
          Container(
            margin: MyScreen.setEdge(left: 20),
            padding: MyScreen.setEdgeAll(2),
            color: MyStyles.d6E2E8,
            child: Text(deviceData.brandName, style: MyStyles.f24c33),
          )
        ],
      ),
    );
  }

  Widget _listItemContent(
      BuildContext context, List<DeviceList> deviceList, int index) {
    return Container(
      padding: MyScreen.setEdge(left: 30, right: 30),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _listItemContentItem(context, '备注', false, 0, deviceList, index),
          _listItemContentItem(context, '运行状态', true, 1, deviceList, index),
          _listItemContentItem(context, '隐患类型', false, 2, deviceList, index),
          _listItemContentItem(context, '其他隐患', false, 3, deviceList, index)
        ],
      ),
    );
  }

  Widget _listItemContentItem(BuildContext context, String label,
      bool isRequired, int type, List<DeviceList> deviceList, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: MyStyles.borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          type == 1 || type == 2
              ? Container(
                  width: MyScreen.setWidth(170),
                  height: MyScreen.setHeight(100),
                  alignment: Alignment.centerLeft,
                  child: Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(text: label, style: MyStyles.f30c33),
                    TextSpan(
                        text: isRequired ? '*' : '', style: MyStyles.f36ce0)
                  ])),
                )
              : Container(),
          type == 0 || type == 3
              ? Container(
                  width: MyScreen.setWidth(690),
                  height: MyScreen.setHeight(100),
                  child: MyInput(
                    inintValue: type == 0
                        ? deviceList[index].description
                        : deviceList[index].otherDanger,
                    prefix: Container(
                      width: MyScreen.setWidth(170),
                      child: Text(label, style: MyStyles.f30c33),
                    ),
                    hintText: type == 0 ? '可用于备注设置位置，便于查找设备' : '如有其他隐患请输入',
                    hintStyle: MyStyles.f30c99,
                    paddingHeight: 38,
                    fieldCallBack: (val) {
                      type == 0
                          ? deviceList[index].description = val
                          : deviceList[index].otherDanger = val;
                      Provide.value<AirBatProvide>(context)
                          .setDeviceList(deviceList);
                    },
                  ),
                )
              : Container(
                  width: MyScreen.setWidth(520),
                  padding: MyScreen.setEdge(top: 25, bottom: 25),
                  child: _listItemRight(context, type, deviceList, index),
                )
        ],
      ),
    );
  }

  Widget _listItemRight(
      BuildContext context, int type, List<DeviceList> deviceList, int index) {
    if (type == 1) {
      return Wrap(
        runSpacing: MyScreen.setWidth(40),
        spacing: MyScreen.setWidth(30),
        children: [
          InkWell(
            onTap: () {
              deviceList[index].status = 1;
              Provide.value<AirBatProvide>(context).setDeviceList(deviceList);
            },
            child: _listItemRightBtn('良好', deviceList[index].status == 1),
          ),
          InkWell(
            onTap: () {
              deviceList[index].status = 0;
              Provide.value<AirBatProvide>(context).setDeviceList(deviceList);
            },
            child: _listItemRightBtn('已坏', deviceList[index].status == 0),
          )
        ],
      );
    }
    return Wrap(
      runSpacing: MyScreen.setWidth(40),
      spacing: MyScreen.setWidth(30),
      children: deviceList[index].dangerList.asMap().keys.map((btnIndex) {
        return InkWell(
          onTap: () {
            deviceList[index].dangerList[btnIndex].enable =
                !deviceList[index].dangerList[btnIndex].enable;
            Provide.value<AirBatProvide>(context).setDeviceList(deviceList);
          },
          child: _listItemRightBtn(deviceList[index].dangerList[btnIndex].name,
              deviceList[index].dangerList[btnIndex].enable),
        );
      }).toList(),
    );
  }

  Widget _listItemRightBtn(String name, bool isCheck) {
    return Container(
      width: MyScreen.setWidth(name.length > 6 ? 520 : 244),
      height: MyScreen.setHeight(60),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isCheck ? MyStyles.e0454501 : Colors.white,
          border: Border.all(
              width: 1,
              color: isCheck ? MyStyles.e0454501 : MyStyles.borderColor),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        name,
        style: isCheck ? MyStyles.f26ce0 : MyStyles.f26c33,
      ),
    );
  }

  // 回单按钮
  Widget _submitBox(BuildContext context, bool submit) {
    if (submit) {
      return Container();
    }
    return Container(
      width: MyScreen.setWidth(750),
      height: MyScreen.setHeight(100),
      color: Colors.white,
      margin: MyScreen.setEdge(left: 30, top: 60, right: 60, bottom: 60),
      child: Container(
        child: MySubmitBtn(
          txt: '提交',
          textSty: MyStyles.f36cff,
          submit: () {
            Provide.value<AirBatProvide>(context).submit(context);
          },
        ),
      ),
    );
  }
}
