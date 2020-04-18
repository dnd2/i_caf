import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';

/// This class provides a simple way to get the data of device screen 
/// for device adaptation.
class Screen {
  static BuildContext context;
  static MediaQueryData _mediaQueryData;
  static Size _size;
  /// The screen width of the device
  static double width  = 0;
  /// The screen heigth of the device
  static double height = 0;

  static double get _ppi => (Platform.isAndroid || Platform.isIOS) ?
    150 : 96;
  /// Initialze the context data and screen size
  static init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _size = _mediaQueryData.size;
    width = _size.width;
    height = _size.height; 
  }
  static bool isLandscape() => 
    _mediaQueryData.orientation == Orientation.landscape;

  static double diagonal() =>
    sqrt((width * width) + (height * height));

  /// Method to get the size relative to screen width
  ///
  /// @param { double } size A percent rate
  static double getHorizontalSize(double size) => 
      width * double.parse((size / 100).toStringAsFixed(3));

  /// Method to get the size relative to screen height
  /// 
  /// @param { double } size A percent rate
  static double getVerticalSize(double size) => 
      height * double.parse((size / 100).toStringAsFixed(3));
  /// Inches
  static Size inches() {
    return Size(width / _ppi, height / _ppi);
  }
  static double widthInches(BuildContext c) => inches().width;
  static double heightInches(BuildContext c) => inches().height;
  static double diagonalInches(BuildContext c) => diagonal() / _ppi;
}