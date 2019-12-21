/*
 * @Author: liangyt
 * @Date: 2019-12-21 16:42:06
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-21 16:42:53
 * @Description: Sliver计算固定头部
 * @FilePath: /unicom_flutter/lib/widgets/list/sliverAppBarDelegate.dart
 */

import 'dart:math';
import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
