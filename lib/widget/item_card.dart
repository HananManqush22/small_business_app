import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_button_click.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تصميم شعار شركة المتحدة',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: primaryFont),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    CustomButtonClick(
                      isLoading: false,
                      onTap: () {},
                      title: 'قيد التنفيذ',
                      sizeWidth: 90.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '500.560',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: primaryColor),
                    ),
                    Icon(
                      Icons.attach_money,
                      color: primaryColor,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            CircularPercentIndicator(
              radius: 33.0,
              lineWidth: 6.0,
              animation: true,
              percent: 0.5,
              center: Text(
                "50%",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: primaryColor),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: primaryColor,
              backgroundColor: fillColor,
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 8,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'انهاء',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: primaryColor),
            ),
            const Spacer(),
            Icon(
              Icons.person,
              color: primaryColor,
              size: 15,
            ),
            Text(
              'عبدالرحمن منقوش',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: primaryFont),
            ),
            SizedBox(
              width: 10.w,
            ),
            Icon(
              Icons.calendar_today,
              color: primaryColor,
              size: 15,
            ),
            Text(
              '  19 / 4 / 2002 م',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: primaryFont),
            ),
          ],
        ),
      ],
    );
  }
}
