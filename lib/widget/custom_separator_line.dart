import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';

class CustomSeparatorLine extends StatelessWidget {
  const CustomSeparatorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 1.h,
        width: MediaQuery.sizeOf(context).width,
        color: fillColor,
      ),
    );
  }
}
