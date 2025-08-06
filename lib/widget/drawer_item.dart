import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: backgroundColor,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: backgroundColor),
      ),
      onTap: onTap,
    );
  }
}
