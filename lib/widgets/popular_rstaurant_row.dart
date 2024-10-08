import 'dart:io';

import 'package:flutter/material.dart';

File image2u = File("images/delivered.jpg");
class TColor {
  static const Color primaryText = Color(0xFF333333);
  static const Color secondaryText = Color(0xFF777777);
  static const Color primary = Color(0xFFFFD700);
}


class PopularRestaurantRow extends StatelessWidget {
  final Map<dynamic, dynamic> pObj;
  final VoidCallback onTap;
  const PopularRestaurantRow({super.key, required this.pObj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              pObj["image"]?.toString() ?? '',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pObj["name"]?.toString() ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                         //place- "image",
                        image2u as String,
                        width: 10,
                        height: 10,
                        fit: BoxFit.cover,

                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        pObj["rate"]?.toString() ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: TColor.primary, fontSize: 11),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "(${pObj["rating"]?.toString() ?? ''} Ratings)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        pObj["type"]?.toString() ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        " . ",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: TColor.primary, fontSize: 11),
                      ),
                      Text(
                        pObj["food_type"]?.toString() ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
