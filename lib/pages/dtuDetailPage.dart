/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:19:31
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 16:08:52
 * @Description: DTU详情
 * @FilePath: /unicom_flutter/lib/pages/dtuDetailPage.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/providers/dtuDetailProvide.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
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

  // DTU详情
  Widget _sliverTop() {
    return SliverToBoxAdapter(
      child: Container(
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

  // dtu操作按钮
  Widget _dtuBox(){
    return Container(
      decoration: BoxDecoration(
        border: MyStyles.borderTop
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
