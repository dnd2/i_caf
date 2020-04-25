import 'package:flutter/material.dart';
import 'package:i_caf/common/Screen.dart';
import 'package:i_caf/common/routes/Router.dart';
/// Event callback triggered when the navigation item will be clicked.
typedef NavItemGestureTapCallBack = void Function();

class MenuNavPanel extends StatelessWidget {
  final double leading = 0.9;
  final double textLineHeight = .2;
  final double fontSize = 14;
  final navWidth = Screen.getHorizontalSize(93);
  final navItemWidth = Screen.getHorizontalSize(19.5);
  final List<MenuNavItem> navItems = [];
  final iconHeight = Screen.getVerticalSize(4);

  @override
  Widget build(BuildContext context) {
    Screen.init(context);
    _initData(context);

    return Container(
      width: navWidth,
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _panelWidgets()
      )
    );
  }

  List<Widget> _panelWidgets() {
    // 合并数组: s://stackoverflow.com/questions/21826342/is-there-a-simple-way-to-combine-two-lists-in-dart
    final double navSpacing = Screen.getHorizontalSize(1.7);
    final double navCrossSpacing = Screen.getVerticalSize(1.5);

    return [
      _navPanel(navItems: navItems.sublist(0, 6)),
      _navPanel(title: '工作台', navItems: navItems.sublist(6, navItems.length), 
        mainSpacing: navSpacing, 
        crossSpacing: navCrossSpacing,
        wrapAlign: WrapAlignment.start, 
        navWrapTop: 10.0,)
    ].expand((element) => element).toList();
  }

  List<Widget> _navPanel({
      String title = '今日任务', 
      List<MenuNavItem> navItems, 
      double mainSpacing: 0, 
      double crossSpacing: 0, 
      WrapAlignment wrapAlign: WrapAlignment.center,
      double navWrapTop: 10,
      double navWrapBottom: 15,
      double navWrapVertical: 12.0}) {

    List<Widget> widgets = navItems.map((element) => _menuItems(element)).toList();
    mainSpacing  = mainSpacing <= 0 ? Screen.getHorizontalSize(11.3) : mainSpacing;
    crossSpacing = crossSpacing <= 0 ? Screen.getVerticalSize(.8) : crossSpacing;

    return <Widget>[
      Container(
        height: 18.0,
        margin: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFF2C96CD), width: 6.0)
            )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 13.0),
          // 设置文本行距
          child: Transform.translate(
            offset: Offset(0, fontSize * leading / 2),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
              ),
              strutStyle: StrutStyle(
                forceStrutHeight: true,
                height: textLineHeight,
                leading: leading),
            )
          )
        ),
      ),
      Container(
        width: navWidth,
        padding: EdgeInsets.only(
          top: navWrapTop, 
          bottom: navWrapBottom,
          left: navWrapVertical,
          right: navWrapVertical
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0)
          ]),
        child: Wrap(
          alignment: wrapAlign,
          spacing: mainSpacing,
          runSpacing: crossSpacing,
          // delegate: MenuItemFlowDelegate(margin: EdgeInsets.all(1.0)),
          children: widgets
        )
      )
    ];
  }

  Widget _menuItems(MenuNavItem item) {
    return GestureDetector(
      onTap: () => item.callback(),
      child: Container(
        width: navItemWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    height: iconHeight,
                    image: AssetImage(item.icon),
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(item.title,
                      style: TextStyle(fontSize: 13.0, color: Colors.black)),
                  Text(item.memo.isEmpty ? "" : "${item.memo} (${item.extra})",
                      style: TextStyle(fontSize: 10.0, color: Colors.grey))
                ],
              ),
            ),
            item.memo.isEmpty ? Text('') : Positioned(
              top: 0,
              right: 5.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(20.0)),
                    color: Color(0xFFFF7B49)),
                child: Text(item.tipValue.toString(),
                    style: TextStyle(fontSize: 11.0, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initData(BuildContext context) {
    this.navItems.addAll([
      MenuNavItem(
          title: '潜客跟进',
          icon: 'assets/images/home/potential_cus.png',
          memo: '已完成',
          extra: 3621,
          tipValue: 500, callback: () => Navigator.push(context, Router.redirectTo('potiential_cus'))),
      MenuNavItem(
          title: '保客回访',
          icon: 'assets/images/home/retain_cus.png',
          memo: '已完成',
          extra: 8,
          tipValue: 12),
      MenuNavItem(
          title: '展厅接待',
          icon: 'assets/images/home/exhibition.png',
          memo: '已完成',
          extra: 5,
          tipValue: 8),
      MenuNavItem(
          title: '交车',
          icon: 'assets/images/home/hand_in_over.png',
          memo: '已完成',
          extra: 3,
          tipValue: 5),
      MenuNavItem(
          title: '邀约到店',
          icon: 'assets/images/home/visit_to_shop.png',
          memo: '已完成',
          extra: 13,
          tipValue: 21),
      MenuNavItem(
          title: '线索跟进',
          icon: 'assets/images/home/clue.png',
          memo: '已完成',
          extra: 52,
          tipValue: 58),
      MenuNavItem(
          title: '线索分配',
          icon: 'assets/images/home/clue_assigned.png',
          memo: '已完成',
          extra: 136,
          tipValue: 279),
      MenuNavItem(
          title: '战败审核',
          icon: 'assets/images/home/audit.png',
          memo: '已完成',
          extra: 34,
          tipValue: 137),
      MenuNavItem(
          title: '战败激活',
          icon: 'assets/images/home/activation.png',
          memo: '',
          extra: 0,
          tipValue: 0),
      MenuNavItem(
          title: '客户再分配',
          icon: 'assets/images/home/cus_assigned.png',
          memo: '',
          extra: 0,
          tipValue: 0),
      MenuNavItem(
          title: '潜客档案',
          icon: 'assets/images/home/archive.png',
          memo: '',
          extra: 0,
          tipValue: 0),
      MenuNavItem(
          title: '保客信息',
          icon: 'assets/images/home/retain_profile.png',
          memo: '',
          extra: 0,
          tipValue: 0),
      MenuNavItem(
          title: '库存查询',
          icon: 'assets/images/home/storage_search.png',
          memo: '',
          extra: 0,
          tipValue: 0),
      MenuNavItem(
          title: '今日计划',
          icon: 'assets/images/home/plan.png',
          memo: '',
          extra: 0,
          tipValue: 0),
    ]);
  }
}

/// The data structure of the main navigation menu
class MenuNavItem {
  MenuNavItem({
    this.tipValue,
    @required this.icon,
    @required this.title,
    this.memo = '',
    this.extra,
    this.callback,
  });

  final int tipValue;
  final String icon;
  final String title;
  final String memo;
  final int extra;
  final NavItemGestureTapCallBack callback;
}
