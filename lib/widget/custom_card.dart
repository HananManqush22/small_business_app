import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.item,
    required this.heigh,
  });
  final Widget item;
  final double heigh;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        height: heigh.h,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: item,
        ));
  }
}
