import 'package:flutter/material.dart';

class InterTextStyle {
  static const String _fontFamily = 'Inter';

  static TextStyle light(
    double size, {
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: size,
      color: color ?? Colors.black,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle regular(
    double size, {
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: size,
      color: color ?? Colors.black,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle medium(
    double size, {
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: color ?? Colors.black,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle semiBold(
    double size, {
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: color ?? Colors.black,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle bold(
    double size, {
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: size,
      color: color ?? Colors.black,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }
}
