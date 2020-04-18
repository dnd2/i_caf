import 'package:flutter/material.dart';

/// 自定义路由切换动画
/// https://flutter.cn/docs/cookbook/animation/page-route-animation
class RouteTranistion extends PageRouteBuilder {
  RouteTranistion(this.widget) 
    : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
          return widget;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.ease
            );

            return Stack(
              children: <Widget>[
                SlideTransition(
                  position: new Tween<Offset>(
                    begin: const Offset(0.0, 0.0),
                    end: const Offset(-1.0, 0.0)
                  ).animate(curvedAnimation),
                  child: child,
                ),
                SlideTransition(
                  position: new Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero
                  ).animate(curvedAnimation),
                  child: child,
                )
              ],
            );
          }
    );
    
    final Widget widget;
}