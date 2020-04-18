import 'package:flutter/material.dart';

/// Render a login form item
class LoginFormField extends StatelessWidget {
  /// Form rendering type
  static const form = 1001;
  static const text = 1002;

  LoginFormField({
    @required this.iconSrc,
    this.borderColor = const Color(0xFF8592A2),
    this.iconWidth = 26.0,
    this.fieldWidth = 220.0,
    this.placeholder = '请填写...',
    this.controller,
    this.isHideWord = false,
    this.focusNode,
    this.onTap,
    this.type = form,
    this.callback
  }): assert( iconSrc != null ),
       assert( iconWidth != null ),
       assert( fieldWidth != null ),
       assert( placeholder != null );

  /// Prefix icon
  final String iconSrc;
  /// The bottom border color of form item
  final Color borderColor;
  /// The width of the prefix icon  
  final double iconWidth;
  /// The width of the form field
  final double fieldWidth;
  /// The placeholder text
  final String placeholder;
  /// The controller of the form field
  final TextEditingController controller;
  /// The field content will be hide with some special characters.
  final bool isHideWord;
  /// Used to notify the control of gaining / losing focus
  final FocusNode focusNode;
  /// When the text field has been tapped, this function will be implemented.
  final GestureTapCallback onTap;
  /// Form field types
  final int type;
  /// Get the value of a form item
  final FormFieldSetter<String> callback;

  @override
  Widget build(BuildContext context) {
    final bottomSize = this.type == LoginFormField.text ?
      5.0 : 0.0;

    return Container(
      width: this.fieldWidth,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 5.0, bottom: bottomSize),
      decoration: BoxDecoration(
        border: new Border(
          bottom: BorderSide(
            width: .5,
            color: this.borderColor,
          ),
        ),
      ), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(this.iconSrc),
            width: this.iconWidth,
          ),
          Container(
            width: this.fieldWidth - 40,
            padding: EdgeInsets.only(left: 15.0, bottom: bottomSize),
            child: this.type == LoginFormField.text ?
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 3.0),
                child: GestureDetector(
                  child: Text(
                    this.placeholder, 
                    style: TextStyle(color: Colors.white, fontSize: 14.0)
                  ),
                  onTap: this.onTap,
                ),
              ) :
              Padding(
                padding: EdgeInsets.only(bottom: 0.0),
                child: TextFormField(
                controller: this.controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: this.placeholder,
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: const Color(0xFFFFFFFF),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  ),
                  obscureText: this.isHideWord,
                  focusNode: this.focusNode,
                  onSaved: this.callback,
                ),
              )
          ),
        ],
      ),
    );
  }
}