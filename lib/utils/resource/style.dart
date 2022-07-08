import 'package:flutter/material.dart';

const Color primary = Color(0xFF4D9A92);
const Color onPrimary = Color(0x8A4D9A92);
const Color secondary = Color(0xFF165993);
const Color light = Color(0xFFFFFFFF);
const Color dark = Color(0x000b0b15);

ThemeData lightMode = ThemeData(
  backgroundColor: light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

ThemeData darkMode = ThemeData.dark().copyWith(
  backgroundColor: Colors.black54,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
