import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.addFunction,
      this.isLoading = false});
  final String title;

  final void Function() addFunction;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: backgroundColor),
          ),
          IconButton(
            onPressed: addFunction,
            icon: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: backgroundColor,
                    ),
                  )
                : Icon(
                    Icons.check,
                    color: backgroundColor,
                    size: 25,
                  ),
          ),
        ],
      ),
    );
  }
}
