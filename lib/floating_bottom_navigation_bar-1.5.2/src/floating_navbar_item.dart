import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingNavbarItem {
  final String? title;
  final IconData? icon;
  final String customWidget;

  FloatingNavbarItem({
    this.icon,
    this.title,
    required this.customWidget,
  }) : assert(icon != null || customWidget != null);
}
