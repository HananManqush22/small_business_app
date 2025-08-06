import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_card.dart';

class CustomStatCard extends StatelessWidget {
  const CustomStatCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.number});
  final String title;
  final IconData icon;
  final String number;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        item: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 30,
              color: primaryColor,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: fontColor),
            ),
            Container(
              height: 5,
              width: MediaQuery.sizeOf(context).width,
              color: primaryColor,
            ),
            Text(
              '$number ',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: fontColor),
            )
          ],
        ),
        heigh: 130);
  }
}
