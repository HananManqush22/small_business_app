import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_button_click.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.states,
    required this.cost,
    required this.date,
    required this.client,
    required this.days,
  });
  final String title;
  final String states;
  final String cost;
  final String date;
  final String client;
  final String days;

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
                  title,
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
                      title: states,
                      sizeWidth: 90.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      cost,
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
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: primaryColor),
                  ),
                  Text(
                    "يوم",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: primaryColor),
                  ),
                ],
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
            Container(
                width: 15,
                height: 15,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  ),
                  color: backgroundColor,
                ),
                child: Icon(
                  Icons.check,
                  color: primaryColor,
                  size: 10,
                )),
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
              client,
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
              date,
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
