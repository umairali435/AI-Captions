import 'package:flutter/material.dart';

class IconSquare extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? color;
  final double? width;
  final double? height;
  const IconSquare({
    super.key,
    required this.child,
    required this.onTap,
    this.width = 40.0,
    this.height = 40.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40.0,
        width: width ?? 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color ?? const Color(0xFF626060).withOpacity(0.5),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
