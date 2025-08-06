import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';

class FinancialReports extends StatelessWidget {
  const FinancialReports(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});
  final String title;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: primaryFont,
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
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: fontColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Container(
          height: 1,
          width: MediaQuery.sizeOf(context).width,
          color: primaryFont,
        ),
        SizedBox(
          height: 7.h,
        ),
      ],
    );
  }
}
