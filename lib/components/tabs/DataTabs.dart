import 'package:flutter/material.dart';
import 'package:i_caf/common/Event.dart';

/// 数据选择Tab
class DataTabs extends StatefulWidget {
  DataTabs({
    @required this.items,
    this.checkedTextColor = const Color(0xFF2C96CD),
    this.unCheckedTextColor = Colors.white,
    this.checkedBgColor = Colors.white,
    this.unCheckedBgColor = const Color(0xFF2C96CD),
  });

  final List<DataTabItem> items;
  /// 选中的字体颜色
  final Color checkedTextColor;
  /// 未选中的字体颜色
  final Color unCheckedTextColor;
  /// 选中的背景色
  final Color checkedBgColor;
  /// 未选中的背景色
  final Color unCheckedBgColor;
  /// 选中事件名
  static const eTabSelected = "data_tab_selected";

  @override
  _DataTabsState createState() => _DataTabsState();
}

class _DataTabsState extends State<DataTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<Widget> widgets = widget.items.map((item) {
      ++index;
      return _buildTabItem(item, index, widget.items.length);
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  Widget _buildTabItem(DataTabItem item, int index, int maxLength) {
    BorderRadius borderRadius;

    if (index == 1) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0)
      );
    } else if (index == maxLength) {
      borderRadius = BorderRadius.only(
        topRight: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0)
      );
    }

    return GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: item.status ? widget.checkedBgColor : widget.unCheckedBgColor,
            border: Border.all(color: Colors.white, width: 1.0),
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
          ),
          child: Text("${item.title}(${item.value})", 
            style: TextStyle(
              color: item.status ? widget.checkedTextColor : widget.unCheckedTextColor,
              fontSize: 13.0
            )
          ),
        ),
        onTap: () { 
          selectedIndex = index;
          bus.emit(DataTabs.eTabSelected, index);
          setState(() {
            int i = 0;
            widget.items.forEach((element) {
              ++i;
              if (i != index) {
                element.status = false;
              }
            });
            item.status = true;
          });
        },
      );
  }
}

class DataTabItem {
  DataTabItem({
    this.title,
    this.value,
    this.status = false
  });

  final String title;
  final int value;
  bool status;
}