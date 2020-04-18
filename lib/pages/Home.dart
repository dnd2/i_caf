import 'package:flutter/material.dart';
import 'package:i_caf/common/Screen.dart';
import 'package:i_caf/components/MenuNavPanel.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage>createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<BannerItemData> _list = [
    BannerItemData(label: '本月建档', value: 600),
    BannerItemData(label: '剩余订单', value: 30),
    BannerItemData(label: '本月开票', value: 100),
  ];
  Shader _shader;
  final List<NavigationIconView> _navgationViews = [];

  @override
  void initState() {
    super.initState();
    _navgationViews.addAll([
      NavigationIconView(
        icon: ImageIcon(AssetImage('assets/images/home/home.png')),
        activeIcon: ImageIcon(AssetImage('assets/images/home/home_over.png')),
        title: Text('首页'),
        vsync: this
      ),
      NavigationIconView(
        icon: ImageIcon(AssetImage('assets/images/home/document.png')),
        activeIcon: ImageIcon(AssetImage('assets/images/home/document_over.png')),
        title: Text('文档'),
        vsync: this
      ),
      NavigationIconView(
        icon: ImageIcon(AssetImage('assets/images/home/report.png')),
        activeIcon: ImageIcon(AssetImage('assets/images/home/report_over.png')),
        title: Text('报表'),
        vsync: this
      ),
      NavigationIconView(
        icon: ImageIcon(AssetImage('assets/images/home/remind.png')),
        activeIcon: ImageIcon(AssetImage('assets/images/home/remind_over.png')),
        title: Text('提醒'),
        vsync: this
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = LinearGradient(
      colors: [Colors.white, Color(0xFFD8F1FF)], 
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
    );
    _shader = gradient.createShader(
      Rect.fromLTWH(0, 0, 200, 200),
    );
    Screen.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('福务通'),
        // Icons: https://material.io/resources/icons/?style=baseline
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30.0),
          onPressed: () {
            
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF2C96CD),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, size: 30.0),
            onPressed: () {
                
            },
          )
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF5F5F5),
          child: Column(
            children: <Widget>[
              _pageHeader(),
              MenuNavPanel(),
            ],
          ),
        )
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _pageHeader() {
    final spacer = Screen.getHorizontalSize(10);
    List<Widget> items = [];
    _list.forEach((element) {
      items.add(_buildStatistics(element));
    });

    return Container(
      height: Screen.getVerticalSize(14),
      padding: EdgeInsets.only(
        top: Screen.getVerticalSize(3),
        left: spacer,
        right: spacer
      ),
      decoration: BoxDecoration(
        color: Color(0xFF2C96CD),
        image: DecorationImage(
          image: AssetImage('assets/images/home/top_header_bg.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }
  
  Column _buildStatistics(BannerItemData item) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 5.0),
          child: Text(
            item.value.toString(),
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
              foreground: Paint()..shader = _shader
            )
          ),
        ),
        Text(item.label, style: TextStyle(fontSize: 16.0, color: Colors.white))
      ],
    );
  }

  BottomNavigationBar _bottomBar() {
    return BottomNavigationBar(
      items: _navgationViews
        .map((NavigationIconView navigationIconView) => navigationIconView.item)
        .toList(),
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {

      },
    );
  }
}

/// Some statistics displayed in the banner.
class BannerItemData {
  BannerItemData({
    this.value = 0,
    this.label = ''
  });

  final int value;
  final String label;
}

class NavigationIconView {
  NavigationIconView({
    ImageIcon icon,
    ImageIcon activeIcon,
    Widget title,
    TickerProvider vsync
  }): 
    item = BottomNavigationBarItem(
      icon: icon,
      activeIcon: activeIcon,
      title: title
    ),
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync
    );

  final BottomNavigationBarItem item;
  final AnimationController controller;
}
