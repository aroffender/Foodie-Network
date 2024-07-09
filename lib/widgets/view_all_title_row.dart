import 'package:flutter/material.dart';

class TColor {
  static const Color primaryText = Color(0xFF333333);
  static const Color secondaryText = Color(0xFF777777);
  static const Color primary = Color(0xFFFFD700);
  static const Color white = Color(0xFFFFFFFF); // Added white color
}


class ViewAllTitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onView;
  const ViewAllTitleRow({super.key, required this.title, required this.onView });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        TextButton(
          onPressed: onView,
          child: Text(
            "View all",
            style: TextStyle(
                color: TColor.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}