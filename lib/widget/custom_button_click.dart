import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';

class CustomButtonClick extends StatelessWidget {
  const CustomButtonClick(
      {super.key,
      required this.sizeWidth,
      required this.title,
      this.isLoading = false,
      this.isChoose = true,
      required this.onTap});
  final double sizeWidth;
  final String title;
  final bool isLoading;
  final bool isChoose;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: sizeWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isChoose ? primaryColor : fillColor,
        ),
        child: Center(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: backgroundColor,
                    ),
                  )
                : Text(
                    title,
                    style: TextStyle(
                      color: isChoose ? backgroundColor : primaryColor,
                    ),
                  )),
      ),
    );
  }
}
// MediaQuery.of(context).size.width
