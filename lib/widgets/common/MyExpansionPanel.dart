/*
 * @Author: liangyt
 * @Date: 2020-01-04 14:12:01
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-04 15:41:18
 * @Description: 伸缩面板
 * @FilePath: /unicom_flutter/lib/widgets/common/MyExpansionPanel.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'dart:math' as math;

class MyExpansionPanel extends StatefulWidget {
  final bool isExpanded;
  final Function expansionCallback;
  final Widget title;
  final Widget body;
  final double headHeight;
  MyExpansionPanel(
      {@required this.isExpanded,
      @required this.expansionCallback,
      @required this.title,
      @required this.body,
      this.headHeight = 120});
  @override
  _MyExpansionPanelListState createState() => _MyExpansionPanelListState();
}

class _MyExpansionPanelListState extends State<MyExpansionPanel>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double angle = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween(begin: 0.0, end: math.pi).animate(_controller)
      ..addListener(() {
        setState(() {
          angle = _animation.value;
        });
      });

    super.initState();
  }

  @override
  void didUpdateWidget(MyExpansionPanel oldWidget) {
    if (oldWidget.isExpanded == widget.isExpanded) {
      return; //减少绘制
    }
    if (!widget.isExpanded) {
      _controller.reverse(); //反向旋转
    } else {
      _controller.forward(); //正向旋转
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_title(), _content()],
      ),
    );
  }

  Widget _title() {
    return InkWell(
      onTap: widget.expansionCallback,
      child: Container(
        height: MyScreen.setHeight(widget.headHeight),
        padding: MyScreen.setEdge(left: 30, right: 30),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.title,
            Transform.rotate(
              angle: angle,
              child: Icon(
                Icons.keyboard_arrow_up,
                size: 30,
                color: Color(0xFFC7C7CC),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: 200),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: widget.isExpanded ? double.infinity : 0),
        child: widget.body,
      ),
    );
  }
}
