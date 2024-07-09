import 'package:flutter/material.dart';
class TColor {
  static const Color primaryText = Color(0xFF333333);
  static const Color secondaryText = Color(0xFF777777);
  static const Color primary = Color(0xFFFFD700);
  static const Color white = Color(0xFFFFFFFF); // Added white color
}


class RoundIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String icon;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  const RoundIconButton(
      {super.key,
        required this.title,
        required this.icon,
        required this.color,
        this.fontSize = 12,
        this.fontWeight = FontWeight.w500,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  color: TColor.white,
                  fontSize: fontSize,
                  fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}