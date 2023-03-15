import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  const IconCard({
    super.key,
    required this.icon,
    this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Card(
        elevation: 10,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
