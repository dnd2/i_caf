import 'package:flutter/material.dart';
import 'package:i_caf/common/Screen.dart';
import 'package:i_caf/common/routes/Router.dart';
import 'package:i_caf/components/LoginFormField.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodeUserName = new FocusNode();
  final FocusNode _focusPassword = new FocusNode();
  final ScrollController _scrollController = ScrollController();
  double itemWidth = 0;
  String unCheckedIcon = 'assets/images/login/unselected@3x.png';
  String checkedIcon   = 'assets/images/login/selected@3x.png';
  bool rememberMeStatus = false;
  bool autoLoginStatus  = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Screen.init(context);
    itemWidth = Screen.getHorizontalSize(72);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.only(top: Screen.getVerticalSize(8), bottom: 100.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login/login_bg.png'),
                fit: BoxFit.fill
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _pageHeader(),
                Container(
                  margin: EdgeInsets.only(top: Screen.getVerticalSize(1), bottom: Screen.getVerticalSize(13)),
                  child: Image(
                    image: AssetImage('assets/images/login/fwt@3x.png'),
                    width: Screen.getHorizontalSize(30),
                    fit: BoxFit.fitWidth,
                  )
                ),
                _formFields(),  
              ],
            ),
          ),
        )
      ) 
      
      
    );
  }

  Widget _pageHeader() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 100.0
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Positioned(
            left: 25.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 70.0
              ),
              child: Image.asset('assets/images/login/logo@3x.png'),
            ),
          ),
          Positioned(
            right: 25.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 130.0
              ),
              child: Image.asset('assets/images/login/quality.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formFields() {
    return Form(
      key: _formKey,
     // child: SingleChildScrollView(
        //controller: _scrollController,
        child: Column(
          children: <Widget>[
            LoginFormField(
              type: LoginFormField.text,
              iconSrc: 'assets/images/login/sname@3x.png',
              placeholder: '请选择经销商',
              fieldWidth: itemWidth,
            ),
            LoginFormField(
              iconSrc: 'assets/images/login/username@3x.png',
              placeholder: '请输入用户名',
              fieldWidth: itemWidth,
            ),
            LoginFormField(
              iconSrc: 'assets/images/login/pwd@3x.png',
              placeholder: '请输密码',
              fieldWidth: itemWidth,
              isHideWord: true,
            ),
            Container(
              width: itemWidth + 30.0,
              margin: EdgeInsets.only(top: Screen.getVerticalSize(4)),
              child: FlatButton(
                  padding: EdgeInsets.only(
                    top: Screen.getVerticalSize(1.3), bottom: Screen.getVerticalSize(1.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: Color(0xFF01B9FF)
                    ),
                  ),
                  color: Color(0xFF01B9FF),
                  textColor: Colors.white,
                  child: Text('登 录', style: TextStyle(fontSize: 19.0)),
                  onPressed: () {
                    Navigator.push(context, Router.redirectTo('home'));
                  },
              )
            ),
            /// Remember me
            _checkboxItems(),
           _version()
          ],
        ),
     // )
      
    );
  }

  Widget _checkboxItems() {
    return Container(
       width: itemWidth + 20.0,
        margin: EdgeInsets.only(top: Screen.getVerticalSize(.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(rememberMeStatus ? checkedIcon : unCheckedIcon),
                    width: 20.0,
                  ),
                  Text('  记住密码', style: TextStyle(fontSize: 14.0, color: Colors.white),)
                ],
              ),
              onPressed: () {
                rememberMeStatus = ! rememberMeStatus;
                setState(() {});
              },
            ),
            Spacer(),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(autoLoginStatus ? checkedIcon : unCheckedIcon),
                    width: 20.0,
                  ),
                  Text('  自动登录', style: TextStyle(fontSize: 14.0, color: Colors.white),)
                ],
              ),
              onPressed: () {
                autoLoginStatus = ! autoLoginStatus;
                setState(() {});
              },
            ),
          ],
        ),
    );
  }

  Widget _version() {
    return Align(
      //padding: EdgeInsets.only(top: Screen.getVerticalSize(0)),
      alignment: Alignment(0, 1),
      child: Text('v1.0.0', style: TextStyle(fontSize: 12.0, color: Colors.white60)),
    );
  }
}