/*
 * @Author: liangyt
 * @Date: 2020-01-06 23:13:08
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 23:15:08
 * @Description: 说明用处
 * @FilePath: /unicom-flutter/lib/providers/imageProvide.dart
 */

import 'dart:io';
import 'package:flutter/material.dart';

class ImageProvide with ChangeNotifier {
  File file;

  void setFile(File image) {
    file = image;
    notifyListeners();
  }
}
