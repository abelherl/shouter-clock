import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final deviceSize = (BuildContext context) => MediaQuery.of(context).size;

const aFontFamily = '';

// Colors
const Color aBackgroundColor = const Color(0xFFE4E9F2);
const Color aDarkTextColor = const Color(0xFF222B45);
const Color aLightTextColor = const Color(0xFF8F9BB3);
const Color aInactiveColor = const Color(0xFFEDF1F7);
const Color aShadowColor = const Color(0x15333333);
const Color aBorderColor = const Color(0xFFCDCDCD);

const Color aRed = const Color(0xFFC53D3C);
const Color aLightRed = const Color(0xFFFCF0EF);
const Color aGreen = const Color(0xFF28AF47);
const Color aLightGreen = const Color(0xFFD8FBD3);

const double aBorderWidth = 1.0;
const double aBorderRadius = 10.0;
const double aPadding = 15.0;
const double aLargerPadding = 30.0;
const double aStandardWidth = 380.0;

final aFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0,);