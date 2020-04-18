import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigAlertDialog {
  ConfigAlertDialog({
    this.headTitle,
    this.host,
    this.port,
  });

  /// Dialog title
  final String headTitle;

  /// The Host address of the reseller
  final String host;

  /// The Host port of the reseller
  final int port;
  /// AlertDialog: https://juejin.im/post/5c0aa283518825444612a1eb
  /// 自定义Dialog: https://www.jianshu.com/p/6266dd5636f5
  /// https://www.jianshu.com/p/6829edbf5037
  /// Dialog with animation: https://stackoverflow.com/questions/52408610/flutter-custom-animated-dialog
  static Future<Map<String, String>> alert(BuildContext context, String title) async {
    final TextEditingController ipController   = new TextEditingController();
    final TextEditingController portController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            titlePadding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16.0
              ),
            ),
            // backgroundColor: Colors.amber,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            children: <Widget>[
              Container(
                width: 200.0,
                // padding: EdgeInsets.all(10.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(bottom: 10.0),
                        //height: 25.0,
                        child: TextField(
                          controller: ipController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
                              labelText: '主机地址',
                              hintText: '请输入',
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: const Color(0xFF969896),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                width: .5,
                                style: BorderStyle.none,
                                color: const Color(0xFF000000),
                              ),
                            )
                          ),
                        ),
                      ),
                      Container(
                        child: TextField(
                          controller: portController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
                              labelText: '主机端口号',
                              hintText: '请输入',
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: const Color(0xFF969896),
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                width: .5,
                                style: BorderStyle.none,
                                color: const Color(0xFF000000),
                              )
                            )
                          ),
                          // 允许输入的格式
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FlatButton(
                      child: Text('确定'),
                      textColor: const Color(0xFF007FFF),
                      onPressed: () {
                        print('OK,' + ipController.text + ',' + portController.text);
                        Navigator.pop(context, { 
                          'ip': ipController.text, 
                          'port': portController.text });
                      },
                    ),
                    new FlatButton(
                      child: Text('取消'),
                      textColor: const Color(0xFF007FFF),
                      onPressed: () {
                        print('Cancel');
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              
            ],
       
            /* actions: <Widget>[
              new FlatButton(
                child: Text('确定'),
                onPressed: () {
                  print('OK');
                },
              ),
              new FlatButton(
                child: Text('取消'),
                onPressed: () {
                  print('Cancel');
                },
              ),
            ], */
          );
        });
  }
}
