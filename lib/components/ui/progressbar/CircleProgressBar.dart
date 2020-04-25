import 'dart:ui';
import 'package:flutter/material.dart';

/// 参考：https://juejin.im/post/5bdc11be518825171140d46d
/// 波浪进度条： https://blog.csdn.net/baoolong/article/details/86503719
/// 圆形进度条：https://juejin.im/post/5d43d866518825061a12a6ee
class CircleProgressBar extends CustomPainter {

  /// 绘制操作
  /// 
  @override
  void paint(Canvas canvas, Size size) {
     final double center = size.width * 0.5;
     final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0xFFFF0000)
      ..strokeCap = StrokeCap.round // 画笔笔触类型
      ..strokeWidth = 
  }

  /// 在刷新布局的时候告诉Flutter是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }

}