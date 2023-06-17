import 'package:digiquran/common/color.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class StarWidget extends StatefulWidget {
  const StarWidget(
      {super.key, required this.top, required this.right, required this.size});
  final double top;
  final double right;
  final double size;

  @override
  State<StarWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      right: widget.right,
      child: Icon(
        Bootstrap.star_fill,
        color: secondaryColor,
        size: widget.size,
        shadows: const [
          Shadow(
            color: secondaryColor,
            offset: Offset(0, 1),
            blurRadius: 28,
          ),
        ],
      ),
    );
  }
}
