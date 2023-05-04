import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final void Function()? onPressed;
  const IconCard({
    super.key,
    required this.icon,
    this.color,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Card(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Icon(icon,color: iconColor),
        ),
      ),
    );
  }
}
