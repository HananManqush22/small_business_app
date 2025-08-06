import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';

class ClientItem extends StatelessWidget {
  const ClientItem(
      {super.key,
      required this.name,
      required this.phone,
      required this.email});
  final String name;
  final String phone;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: primaryColor,
          child: Text(
            '${name[0]}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: backgroundColor),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: primaryColor),
            ),
            Row(
              spacing: 5,
              children: [
                Text(
                  phone,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: primaryFont),
                ),
                Text(
                  '/  $email ',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: primaryFont),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
