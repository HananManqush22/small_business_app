import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key, required this.item});
  final Widget item;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
        color: fillColor,
      ),
      child: Container(
          height: MediaQuery.sizeOf(context).height,
          margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: item,
          )),
    );
  }
}
