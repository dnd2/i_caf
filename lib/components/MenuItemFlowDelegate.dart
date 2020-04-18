import 'package:flutter/material.dart';

/// https://blog.csdn.net/yuzhiqiang_1993/article/details/88378021
class MenuItemFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  MenuItemFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 屏幕宽度
    var screenW = context.size.width;

    for (int i = 0; i < context.childCount; i++) {
        var w = context.getChildSize(i).width + x + margin.right;
        // 如果当前x左边加上子控件宽度小于屏幕宽度,则继续绘制,否则换行
        if (w < screenW) {
            context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
            x = w + margin.left;
        } else {
          x = margin.left;
          y += context.getChildSize(i).height + margin.top + margin.bottom;
          context.paintChild(i, 
            transform: Matrix4.translationValues(x, y, 0.0));
          x += context.getChildSize(i).width + margin.left + margin.right;
        }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小 
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}