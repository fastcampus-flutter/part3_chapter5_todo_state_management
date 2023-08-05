import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color? color;
  final EdgeInsets? margin;

  const RoundedContainer({
    super.key,
    required this.child,
    this.margin,
    this.radius = 10,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
