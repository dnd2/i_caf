import 'package:flutter/material.dart';

/// 自定义路由切换动画
/// https://flutter.cn/docs/cookbook/animation/page-route-animation
/// https://juejin.im/post/5d3ea81af265da03f04ca5d9
/// 底部扩散模糊动画: https://juejin.im/post/5d5d1a136fb9a06ada54b66d
class RouteTranistion extends PageRouteBuilder {
  RouteTranistion(this.widget)
      : super(
            transitionDuration: const Duration(milliseconds: 900),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                widget,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {

              return SlideTransition(
                    // 1. 页面显示在屏幕时，Offset的dx dy均为0;
                    // 2. 如果需要动画页面从屏幕底部弹出，则应该是dy=1 到 dy=0;
                    // 3. 如果需要动画页面从右侧推入到屏幕，则应该是dx=1 到 dx=0;
                    // 4. 如果需要动画页面从屏幕顶部弹出，则应该是dy=0 到 dy=-1;
                    // 原文: https://juejin.im/post/5e5d33b3e51d4527143e5126
                    position: new Tween<Offset>(
                            begin: const Offset(1.0, 0.0), end: Offset.zero)
                        .animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(-1.0, 0.0)
                      ).animate(CurvedAnimation(parent: secondaryAnimation, curve: Curves.ease)),
                      child: child,
                    )
              );
            });

  final Widget widget;
}
