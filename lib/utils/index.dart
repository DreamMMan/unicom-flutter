/*
 * @Author: liangyt
 * @Date: 2019-12-18 14:42:10
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 09:24:02
 * @Description: utils方法
 * @FilePath: /unicom_flutter/lib/utils/index.dart
 */

import 'package:hive/hive.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/models/deviceList_model.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';
import 'dart:convert' as convert;

class Utils {
  static String hiveName = 'unicomBox';
  // hive
  static unicomBox() {
    return Hive.box(hiveName);
  }

  // BotToast
  static showToast(String title, {double align = 0, int s = 2}) {
    BotToast.showText(
        text: title,
        align: Alignment(0, align),
        duration: Duration(seconds: s));
  }

  // 加载中
  static showLoading(_context) {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            // 禁止手动后退
            onWillPop: () async {
              BotToast.showText(text: '正在处理中，请勿退出页面');
              return false;
            },
            child: MyLoading(),
          );
        });
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
        str['color'] = c52C47B;
        break;
      case 1:
        str['label'] = '未关联';
        str['color'] = cccc;
        break;
      case 2:
        str['label'] = '连接异常';
        str['color'] = e04545;
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
        str['color'] = c999;
        break;
      case 2:
        str['label'] = '待确认';
        str['color'] = c999;
        break;
      case 3:
        str['label'] = '进行中';
        str['color'] = c03A4EE;
        break;
      case 4:
        str['label'] = '确认退回';
        str['color'] = e04545;
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
