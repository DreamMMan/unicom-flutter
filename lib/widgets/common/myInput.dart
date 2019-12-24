/*
 * @Author: liangyt
 * @Date: 2019-12-19 10:28:55
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-24 10:45:01
 * @Description: 输入框组件
 * @FilePath: /unicom_flutter/lib/widgets/myInput.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicom_flutter/utils/constant.dart';
import 'package:unicom_flutter/utils/screenUtil.dart';
import 'package:unicom_flutter/utils/styles.dart';
import 'package:unicom_flutter/widgets/common/myAsset.dart';

typedef void ITextFieldCallBack(String content);

class MyInput extends StatefulWidget {
  final String inintValue;
  final String keyboardType;
  final int maxLines;
  final int maxLength;
  final String hintText;
  final TextStyle hintStyle;
  final ITextFieldCallBack fieldCallBack;
  final ITextFieldCallBack submit;
  final bool delete;
  final InputBorder inputBorder;
  final String iconName;
  final TextStyle textStyle;
  final String whiteEegExp;
  final String blackEegExp;
  final String textInputAction;
  final double paddingHeight;
  final double iconWidth;

  MyInput(
      {this.inintValue = '',
      this.keyboardType = 'text',
      this.maxLines = 1,
      this.maxLength,
      this.hintText,
      this.hintStyle,
      @required this.fieldCallBack,
      this.submit,
      this.delete = true,
      this.inputBorder,
      this.textStyle,
      this.iconName,
      this.whiteEegExp,
      this.blackEegExp,
      this.paddingHeight = 0,
      this.textInputAction = 'none',
      this.iconWidth = 22});

  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  String _inputText = '';
  bool _hasdeleteIcon = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _inputText = widget.inintValue;
    });
  }

  ///输入类型
  _getTextInputType() {
    switch (widget.keyboardType) {
      case 'text':
        return TextInputType.text;
      case 'multiline':
        return TextInputType.multiline;
      case 'number':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      case 'datetime':
        return TextInputType.datetime;
      case 'emailAddress':
        return TextInputType.emailAddress;
      case 'url':
        return TextInputType.url;
      case 'password':
        return TextInputType.text;
    }
  }

  // 控制键盘的功能键
  _getTextInputAction() {
    switch (widget.textInputAction) {
      case 'done':
        return TextInputAction.done;
      case 'search':
        return TextInputAction.search;
      case 'send':
        return TextInputAction.send;
      case 'next':
        return TextInputAction.next;
      case 'go':
        return TextInputAction.go;
    }
  }

  // 白名单 黑名单
  _getInputFormatter() {
    List<TextInputFormatter> regExplist = [];
    if (widget.whiteEegExp != null) {
      regExplist
        ..add(WhitelistingTextInputFormatter(RegExp(widget.whiteEegExp)));
    }
    if (widget.blackEegExp != null) {
      regExplist
        ..add(BlacklistingTextInputFormatter(RegExp(widget.blackEegExp)));
    }
    return regExplist;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));
    TextField textField = TextField(
      controller: _controller,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: _getTextInputType(),
      inputFormatters: _getInputFormatter(),
      style: widget.textStyle != null ? widget.textStyle : Styles.f30c33,
      obscureText: widget.keyboardType == 'password' ? true : false,
      textInputAction: _getTextInputAction(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: setHeight(widget.paddingHeight),
            bottom: setHeight(widget.paddingHeight),
          ),
          icon: widget.iconName != null
              ? MyAsset(name: widget.iconName, width: widget.iconWidth)
              : null,
          suffixIcon: widget.delete && _hasdeleteIcon
              ? Container(
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(0.0),
                    icon: MyAsset(name: Constant.deleteIcon, width: widget.iconWidth),
                    onPressed: () {
                      setState(() {
                        _inputText = "";
                        _hasdeleteIcon = (_inputText.isNotEmpty);
                        widget.fieldCallBack(_inputText);
                      });
                    },
                  ),
                )
              : null,
          border: widget.inputBorder != null
              ? widget.inputBorder
              : InputBorder.none,
          hintText: widget.hintText,
          counterText: '',
          hintStyle: widget.hintStyle != null ? widget.hintStyle : Styles.f30ccc),
      onChanged: (val) {
        setState(() {
          _inputText = val;
          _hasdeleteIcon = (_inputText.isNotEmpty);
          widget.fieldCallBack(_inputText);
        });
      },
      onSubmitted: (value){
        widget.submit(_inputText);
      },
    );
    return textField;
  }
}
