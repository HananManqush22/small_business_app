import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/screen/ideas_page.dart';
import 'package:small_business_app/screen/show_profiled_page.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: primaryColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                  child: Text(
                'هانلي ',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: backgroundColor),
              )),
            ),
            DrawerItem(
              title: 'البراند',
              icon: Icons.storefront,
              onTap: () {
                navigateAndFinish(context: context, widget: ShowProfiledPage());
              },
            ),
            DrawerItem(
              title: 'افكار تطويرية',
              icon: Icons.lightbulb,
              onTap: () {
                navigateAndFinish(context: context, widget: IdeasPage());
              },
            ),
            DrawerItem(
              title: 'تسجيل الخروج',
              icon: Icons.logout,
              onTap: () {},
            ),
            DrawerItem(
              title: 'تواصل معنا',
              icon: Icons.email,
              onTap: () {},
            ),
            DrawerItem(
              title: 'قيمنا',
              icon: Icons.star,
              onTap: () {},
            ),
            DrawerItem(
              title: 'مشاركة التطبيق',
              icon: Icons.share,
              onTap: () {},
            ),
            DrawerItem(
              title: 'عن التطبيق',
              icon: Icons.info,
              onTap: () {},
            ),
          ],
        ));
  }
}
// CustomTextButton(
//           title: 'البراند',
//           textStyle: Theme.of(context)
//               .textTheme
//               .bodyLarge
//               ?.copyWith(color: backgroundColor),
//           onPressed: () {
//             navigateAndFinish(context: context, widget: ShowProfiledPage());
//           }),
