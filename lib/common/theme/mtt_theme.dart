import 'package:flutter/material.dart';

///
/// @Class: MTTTheme
/// @Description: 主题model类
/// @author: lca
/// @Date: 2019-08-01
///
class MTTTheme {
  final Color textColor;
  final Color homeMenuColor;
  final Color homeIconContainerColor;
  final Color homeIconColor;
  final ThemeData themeData;

  MTTTheme({
    this.textColor,
    this.homeIconContainerColor,
    this.homeMenuColor,
    this.homeIconColor,
    this.themeData});
}
