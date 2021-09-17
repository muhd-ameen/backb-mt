import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(14.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF989898), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(14.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF989898), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(14.0)),
  ),
);
const kSecondaryTextColor = const TextStyle(
  fontFamily: 'Montserrat',
  color: Color(0xFF6B7280),
  fontWeight: FontWeight.w500,
  fontSize: 13.0,
);
const kPrimaryTextStyle = const TextStyle(
  fontFamily: 'Montserrat',
  color: Color(0xFF4B5563),
  fontWeight: FontWeight.w700,
  fontSize: 18.0,
);

const kThemeColor = const Color(0xFF32B768);

const ColorFilter greyscale = ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
]);

const kGrey = const TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w700,
    fontSize: 20);

