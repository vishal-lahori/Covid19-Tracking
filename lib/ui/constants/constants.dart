import 'dart:ui';

import 'package:flutter/material.dart';

final List<BoxShadow> kBoxShadow = [
  BoxShadow(
    color: Colors.grey[700].withOpacity(0.1),
    offset: Offset(-2, -2),
    blurRadius: 2,
    spreadRadius: 1,
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.7),
    offset: Offset(2, 2),
    blurRadius: 2,
    spreadRadius: 1,
  ),
];

final kDecoration = BoxDecoration(
  color: Color(0XFF0C0C0C),
  borderRadius: BorderRadius.circular(20),
  boxShadow: kBoxShadow,
);

final kProfileDecoration = BoxDecoration(
  color: Color(0XFF0C0C0C),
  borderRadius: BorderRadius.circular(80),
  boxShadow: kBoxShadow,
);

final kBottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

Theme kDatePickerDecoration(Widget child) {
  return Theme(
    data: ThemeData(
      fontFamily: 'Acme',
      colorScheme: ColorScheme.dark(
        primary: Colors.yellow[700],
        onPrimary: Colors.black,
        surface: Colors.transparent,
        onSurface: Colors.white,
      ),
      dialogTheme: DialogTheme(backgroundColor: Colors.transparent),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: child,
    ),
  );
}
