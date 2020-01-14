/*
 * @Author: liangyt
 * @Date: 2019-12-18 14:42:10
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-14 09:54:16
 * @Description: utils方法
 * @FilePath: /unicom_flutter/lib/utils/index.dart
 */

import 'package:common_utils/common_utils.dart';
import 'package:hive/hive.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicom_flutter/constant/myConstant.dart';
import 'package:unicom_flutter/models/deviceList_model.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'dart:convert' as convert;

class Utils {
  // hive
  static unicomBox() {
    return Hive.box(MyConstant.hiveName);
  }

  // BotToast
  static showToast(String title, {double align = 0, int s = 2}) {
    BotToast.showText(
        text: title,
        align: Alignment(0, align),
        duration: Duration(seconds: s));
  }

  // 加载中
  static showLoading(_context, {title: '正在处理中，请勿退出页面'}) {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            // 禁止手动后退
            onWillPop: () async {
              BotToast.showText(text: title);
              return false;
            },
            child: MyLoading(),
          );
        });
  }

  // 查询定位权限
  static Future<bool> requestPermission() async {
    final permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.location]);

    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      return true;
    } else {
      showToast('需要定位权限!');
      return false;
    }
  }

  // 工单类型
  static orderType(String name) {
    switch (name) {
      case '数据采集建设':
        return 0;
        break;
      case '常规动力巡检作业':
        return 1;
        break;
      case '空调清洗作业':
        return 2;
      case '蓄电池放电测试作业':
        return 2;
        break;
      default:
        return 0;
    }
  }

  // 持续时间 时间戳转小时和分钟
  static durationTime(int createTime, int removeTime) {
    int newTime = DateUtil.getNowDateMs();
    if (removeTime != null) {
      newTime = removeTime;
    }
    int time = newTime - createTime;

    int leavel, h, m;
    h = time ~/ (1000 * 60 * 60);
    if (h > 0) {
      leavel = time - (1000 * 60 * 60 * h);
    } else {
      leavel = time;
    }
    m = leavel ~/ (1000 * 60);
    String hstr = h > 0 ? h.toString() + 'h' : '';
    String mstr = m > 0 ? m.toString() + 'm' : '<1m';
    return hstr + mstr;
  }

  //  字符串json转Map
  static stringToMap(value) {
    Map<String, dynamic> data = convert.jsonDecode(value);
    return data;
  }

  // 设备状态
  static deviceStatus(value) {
    var str = {};
    switch (value) {
      case 0:
        str['label'] = '连接正常';
        str['style'] = MyStyles.f26c52;
        break;
      case 1:
        str['label'] = '未关联';
        str['style'] = MyStyles.f26ccc;
        break;
      case 2:
        str['label'] = '连接异常';
        str['style'] = MyStyles.f26ce0;
        break;
      default:
    }
    return str;
  }

  // 站点状态
  static siteStatus(value) {
    var str = {};
    switch (value) {
      case 1:
        str['label'] = '已完成';
        str['color'] = MyStyles.c999;
        break;
      case 2:
        str['label'] = '待确认';
        str['color'] = MyStyles.c999;
        break;
      case 3:
        str['label'] = '进行中';
        str['color'] = MyStyles.c03A4EE;
        break;
      case 4:
        str['label'] = '确认退回';
        str['color'] = MyStyles.e04545;
        break;
      default:
    }
    return str;
  }

  // 运行状态
  static runStatus(value) {
    var str = '';
    switch (value) {
      case 0:
        str = '已坏';
        break;
      case 1:
        str = '良好';
        break;
      default:
    }
    return str;
  }

  // 使用状态
  static userStatus(value) {
    var str = '';
    switch (value) {
      case 0:
        str = '闲置';
        break;
      case 1:
        str = '在网使用';
        break;
      case 2:
        str = '已报废';
        break;
      case 3:
        str = '已销账';
        break;
      default:
    }
    return str;
  }

  // 主设备过滤
  static filtrate(list, String type, String keyWorld, List<int> arr) {
    List<DeviceList> newList = [];
    if (type == '全部类型' && keyWorld.trim().isEmpty) {
      return list;
    } else {
      for (int i = 0; i < list.length; i++) {
        if (type != '全部类型' && keyWorld.trim().isEmpty) {
          if (list[i].deviceType == type) {
            newList..add(list[i]);
          }
        } else if (type != '全部类型' && keyWorld.trim().isNotEmpty) {
          if (list[i].deviceType == type &&
              (list[i].deviceSn != null &&
                      list[i].deviceSn.toString().indexOf(keyWorld) != -1 ||
                  list[i].name != null &&
                      list[i].name.indexOf(keyWorld) != -1 ||
                  list[i].deviceManufactory != null &&
                      list[i].deviceManufactory.indexOf(keyWorld) != -1 ||
                  list[i].deviceModel != null &&
                      list[i].deviceModel.indexOf(keyWorld) != -1 ||
                  list[i].nename != null &&
                      list[i].nename.indexOf(keyWorld) != -1)) {
            newList..add(list[i]);
          }
        } else if (type == '全部类型' && keyWorld.trim().isNotEmpty) {
          if (list[i].deviceSn != null &&
                  list[i].deviceSn.toString().indexOf(keyWorld) != -1 ||
              list[i].name != null && list[i].name.indexOf(keyWorld) != -1 ||
              list[i].deviceManufactory != null &&
                  list[i].deviceManufactory.indexOf(keyWorld) != -1 ||
              list[i].deviceModel != null &&
                  list[i].deviceModel.indexOf(keyWorld) != -1 ||
              list[i].nename != null &&
                  list[i].nename.indexOf(keyWorld) != -1) {
            newList..add(list[i]);
          }
        }
      }
      return newList;
    }
  }
}
