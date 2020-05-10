import 'dart:ui';
import 'dart:math' as Math;
import 'package:flutter/material.dart';

/// 参考：https://juejin.im/post/5bdc11be518825171140d46d
/// 波浪进度条： https://blog.csdn.net/baoolong/article/details/86503719
/// 圆形进度条：https://juejin.im/post/5d43d866518825061a12a6ee
class CircleProgressBar extends CustomPainter {

  num degToRad(num deg) => deg * (Math.pi / 180);
  num radToDeg(num rad) => rad * (180 / Math.pi);

  /// 绘制操作
  /// 
  @override
  void paint(Canvas canvas, Size size) {
     final double center = size.width * 0.5;
     /// 圆的半径
     final double dotRadius = Math.pi * 10.0;
     /// 进度条的偏移量
     final double radiusOffset = dotRadius * 0.4;
     /// 外圆半径
     final double outerRadius = center - radiusOffset;
     /// 内圆半径
     final double innerRadius = center - dotRadius * 2 + radiusOffset;
     /// 进度条拖动圆点中心位置
     final double drawRadius  = center - dotRadius;
     /// 进度条宽度
     final double progressWidth = outerRadius - innerRadius + radiusOffset;
     final Offset offsetCenter = Offset(center, center);

     final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0xFFFF0000)
      ..strokeCap = StrokeCap.round // 画笔笔触类型
      ..strokeWidth = (outerRadius - innerRadius);
      canvas.drawCircle(offsetCenter, drawRadius, ringPaint);

      _drawProgress(
        canvas: canvas, 
        progress: 0.1, 
        progressWidth: progressWidth,
        offsetCenter: offsetCenter,
        drawRadius: drawRadius);
  }

  /// 在刷新布局的时候告诉Flutter是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }

  void _drawProgress({Canvas canvas, double progress, double progressWidth,
    Offset offsetCenter, double drawRadius}) {
    final angle = 360.0 * progress;
    final double radians = degToRad(angle);
    final arcRect = Rect.fromCircle(center: offsetCenter, radius: drawRadius);
    final Gradient gradient = new SweepGradient(
      endAngle: radians,
      colors: [
        Colors.white,
        Color(0xFFFF0000)
      ]
    );
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = progressWidth
      ..shader = gradient.createShader(arcRect);
    canvas.drawArc(
      arcRect,
      0.0, radians, false, progressPaint
    );
  }

}