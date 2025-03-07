/*
 * @Author: liangyt
 * @Date: 2019-12-19 14:53:50
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-18 14:34:40
 * @Description: 后台接口列表
 * @FilePath: /unicom_flutter/lib/http/api.dart
 */

const apiConfig = {
  'login': {'method': 'POST', 'url': '/auth/app/login'}, // 登录接口
  'orderList':{'method': 'POST', 'url': '/system/appSupportTicket/getList'}, // 计划工单 和生命工单列表
  'alarmList':{'method': 'POST', 'url': '/system/appAlarm/getList'}, // 告警列表
  'handAlarm':{'method': 'POST', 'url': '/system/appAlarm/handAlarm'}, // 告警批量处理
  'alarmDetail':{'method': 'POST', 'url': '/system/appAlarm/getDetail'}, // 告警详情
  'orderDetails':{'method': 'POST', 'url': '/system/appSupportTicket/getDetail'}, // 工单详情
  'appSiteList':{'method': 'POST', 'url': '/system/appSite/getList'}, // 站点列表
  'appSiteDetail':{'method': 'POST', 'url': '/system/appSite/getDetail'}, // 站点详情
  'appSiteReceipt':{'method': 'POST', 'url': '/system/appSite/receipt'}, // 用于数据采集建设和常规巡检 回单
  'getDeviceCategory':{'method': 'POST', 'url': '/system/appSite/getDeviceCategory'}, // 获取电表类型
  'addDtu':{'method': 'POST', 'url': '/system/appSite/addDtu'}, // 添加dtu
  'dtuDetail':{'method': 'POST', 'url': '/system/appSite/dtuDetail'}, // dtu详情
  'upData':{'method': 'POST', 'url': '/system/appSite/getData'}, // dtu上报数据
  'saveCoord':{'method': 'POST', 'url': '/system/appSite/saveCoord'}, // 保存站点坐标
  'removeDtu':{'method': 'POST', 'url': '/system/appSite/removeDtu'}, // 删除dtu
  'replaceDtu':{'method': 'POST', 'url': '/system/appSite/replaceDtu'}, // 更换dtu
  'addAmmeter':{'method': 'POST', 'url': '/system/appSite/addAmmeter'}, // 添加电表
  'removeAmmeter':{'method': 'POST', 'url': '/system/appSite/removeAmmeter'}, // 删除电表
  'replaceAmmeter':{'method': 'POST', 'url': '/system/appSite/replaceAmmeter'}, // 更换电表
  'getDeviceList':{'method': 'POST', 'url': '/system/appSite/getDeviceList'}, // 获取设备列表
  'linkDevice':{'method': 'POST', 'url': '/system/appSite/linkDevice'}, // 关联设备
  'uploadImage':{'method': 'POST', 'url': '/system/appJob/uploadImage'}, // 上传图片
  'examine':{'method': 'POST', 'url': '/system/appSite/examine'}, // 生命周期审核
  'receipt':{'method': 'POST', 'url': '/system/appSite/receipt'}, // 常规动力回单
  'jobDetail':{'method': 'POST', 'url': '/system/appJob/getData'}, // 常规动力作业详情
  'submit':{'method': 'POST', 'url': '/system/appJob/submit'}, // 常规动力作业详情提交
};
