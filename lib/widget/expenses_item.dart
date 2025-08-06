import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.title, required this.cost});
  final String title;
  final String cost;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: primaryFont,
          radius: 3,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: primaryFont),
        ),
        const Spacer(),
        Text(
          cost,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: primaryFont),
        ),
        Icon(
          Icons.attach_money,
          color: primaryFont,
          size: 18,
        ),
      ],
    );
  }
}
