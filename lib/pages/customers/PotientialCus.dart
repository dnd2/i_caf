import 'package:flutter/material.dart';

/// 列表中的角标： https://xbuba.com/questions/57538938
/// 进度条: https://github.com/stefanJi/IntervalProgressBar
class PotientialCusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBarView(
          children: <Widget>[
              CircularProgressIndicator(

              )
          ]
        ),
        actions: <Widget>[
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/list/icon_filter.png'),
              size: 25.0,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}