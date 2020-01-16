/*
 * @Author: liangyt
 * @Date: 2020-01-16 16:50:48
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-16 17:08:37
 * @Description: 信号强度
 * @FilePath: /unicom_flutter/lib/widgets/common/signal.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/styles/myScreen.dart';
import 'package:unicom_flutter/styles/myStyles.dart';

class Signal extends StatelessWidget {
  final double signal;
  Signal({@required this.signal});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyScreen.setWidth(30),
        height: MyScreen.setWidth(30),
        child: Stack(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 2,
                    height: MyScreen.setWidth(15),
                    color: signal > 20
                        ? Colors.green
                        : signal > 10 && signal <= 20
                            ? Colors.orange
                            : signal > 0 ? Colors.red : Colors.grey,
                  ),
                  Container(
                    width: 2,
                    margin: EdgeInsets.only(left: 4),
                    height: MyScreen.setWidth(23),
                    color: signal > 20
                        ? Colors.green
                        : signal > 10 && signal <= 20
                            ? Colors.orange
                            : Colors.grey,
                  ),
                  Container(
                    width: 2,
                    margin: EdgeInsets.only(left: 4),
                    height: MyScreen.setWidth(30),
                    color: signal > 20 ? Colors.green : Colors.grey,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                signal == 0 ? 'X' : '',
                style: MyStyles.f26ce0,
              ),
            )
          ],
        ));
  }
}
