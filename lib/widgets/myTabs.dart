/*
 * @Author: liangyt
 * @Date: 2019-12-20 11:33:17
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-20 11:49:15
 * @Description: tabs 导航栏
 * @FilePath: /unicom_flutter/lib/widgets/myTabs.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/utils/myColors.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';

class MyTabs extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> listWidget;
  final int initIndex;
  final bool isScrollable;
  MyTabs(
      {@required this.tabs,
      @required this.listWidget,
      this.initIndex = 0,
      this.isScrollable = false});

  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: widget.initIndex,
        length: widget.listWidget.length,
        vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: setWidth(88),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(width: 1, color: borderColor))),
              child: TabBar(
                controller: _tabController,
                isScrollable: widget.isScrollable,
                labelColor: e04545,
                unselectedLabelColor: c666,
                indicatorColor: e04545,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: f30cff,
                tabs: widget.tabs.map((item) {
                  return Tab(
                    text: item,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: widget.listWidget,
              ),
            )
          ],
        ),
      ),
    );
  }
}
