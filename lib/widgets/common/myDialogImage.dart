/*
 * @Author: liangyt
 * @Date: 2020-01-15 14:10:27
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 15:30:50
 * @Description: 浏览图片
 * @FilePath: /unicom_flutter/lib/widgets/common/myDialogImage.dart
 */
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:unicom_flutter/widgets/common/myAppBar.dart';
import 'package:unicom_flutter/widgets/common/myLoading.dart';

class MyDialogImage extends StatefulWidget {
  final int index; // 打开第几张图片
  final List<String> list; // 图片列表
  final bool isLook; // 是否只是浏览图片
  final Function delete; // 删除图片
  MyDialogImage(
      {this.index = 0, this.isLook = true, this.delete, @required this.list});
  @override
  _MyDialogImageState createState() => _MyDialogImageState();
}

class _MyDialogImageState extends State<MyDialogImage> {
  int index = 0;
  List<String> list;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    setState(() {
      index = widget.index;
      list = widget.list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('${index + 1}/${list.length}', [
        widget.isLook
            ? Container()
            : IconButton(
                icon: Icon(Icons.delete),
                tooltip: 'delete',
                onPressed: () {
                  widget.delete(index);
                  setState(() {});
                  if (list.length == 0) {
                    Navigator.pop(context);
                  }
                },
              )
      ]),
      body: Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.list[index]),
                initialScale: PhotoViewComputedScale.contained * 0.8);
          },
          itemCount: list.length,
          loadingChild: MyLoading(),
          pageController: _pageController,
          onPageChanged: (int i) {
            setState(() {
              index = i;
            });
          },
        ),
      ),
    );
  }
}
