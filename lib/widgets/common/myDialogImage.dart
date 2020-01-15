/*
 * @Author: liangyt
 * @Date: 2020-01-15 14:10:27
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-15 16:01:46
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
  final List list; // 图片列表
  final bool isLook; // 是否只是浏览图片
  final int type; // 图片类型 0 file 1 网络图片 2 asset图片
  final Function delete; // 删除图片
  MyDialogImage(
      {this.index = 0,
      this.isLook = true,
      this.delete,
      this.type = 1,
      @required this.list});
  @override
  _MyDialogImageState createState() => _MyDialogImageState();
}

class _MyDialogImageState extends State<MyDialogImage> {
  int index = 0;
  List list;
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
            ImageProvider image;
            switch (widget.type) {
              case 0:
                image = FileImage(widget.list[index]);
                break;
              case 1:
                image = NetworkImage(widget.list[index]);
                break;
              case 2:
                image = AssetImage(widget.list[index]);
                break;
              default:
                image = NetworkImage(widget.list[index]);
            }
            return PhotoViewGalleryPageOptions(
                imageProvider: image,
                initialScale: PhotoViewComputedScale.contained * 1);
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
