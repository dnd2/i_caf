import 'package:flutter/material.dart';
import 'package:i_caf/components/tabs/DataTabs.dart';

/// 列表中的角标： https://xbuba.com/questions/57538938
/// 进度条: https://github.com/stefanJi/IntervalProgressBar
class PotientialCusPage extends StatelessWidget {
  final List<DataTabItem> items = [
    new DataTabItem(title: '待跟进潜客', value: 20, status: true),
    new DataTabItem(title: '今日已跟进', value: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DataTabs(items: items),
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