/*
 * @Author: liangyt
 * @Date: 2019-12-18 10:40:16
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-02-03 14:07:54
 * @Description: fluro 路由配置
 * @FilePath: /unicom_flutter/lib/routes/config.dart
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:unicom_flutter/routes/handlers.dart';

class Routes {
  static void configRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print('找不到路由');
      return Container();
    });

    // 首页
    router.define('/',
        handler: homeHandler, transitionType: TransitionType.cupertino);
    // webview页面
    router.define('/webView',
        handler: webViewHandler, transitionType: TransitionType.cupertino);
    // 登录页面
    router.define('/login',
        handler: loginHandler, transitionType: TransitionType.cupertino);
    // 工单详情页面
    router.define('/orderDetails',
        handler: orderDetailsHandler, transitionType: TransitionType.cupertino);
    // 报警处理详情页面
    router.define('/alarmDetails',
        handler: alarmDetailsHandler, transitionType: TransitionType.cupertino);
    // 报警处理页面
    router.define('/alarmDeal',
        handler: alarmDealHandler, transitionType: TransitionType.cupertino);
    // 常规建设站点详情 页面
    router.define('/siteDetails',
        handler: siteDetailsHandler, transitionType: TransitionType.cupertino);
    // 生命周期工单站点详情 页面
    router.define('/lifeSite',
        handler: lifeSiteHandler, transitionType: TransitionType.cupertino);
    // 常规动力站点详情页面
    router.define('/rpIn',
        handler: rpInHandler, transitionType: TransitionType.cupertino);
    // 空调 蓄电池站点详情 页面
    router.define('/airBat',
        handler: airBatHandler, transitionType: TransitionType.cupertino);
    // 生命周期工单审核页面
    router.define('/lifeAudit',
        handler: lifeAuditHandler, transitionType: TransitionType.cupertino);
    // dtu详情
    router.define('/dtuDetail',
        handler: dtuDetailHandler, transitionType: TransitionType.cupertino);
    // 设定表/传感器
    router.define('/meter',
        handler: meterHandler, transitionType: TransitionType.cupertino);
    // 设备关联选择类型页面
    router.define('/linkType',
        handler: linkTypeHandler, transitionType: TransitionType.cupertino);
  }
}
