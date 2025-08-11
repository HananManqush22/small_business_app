import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/screen/ideas_page.dart';
import 'package:small_business_app/screen/show_profiled_page.dart';
import 'package:small_business_app/screen/create_user_page.dart';
import 'package:small_business_app/screen/sing_in_page.dart';
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
              onTap: () async {
                await signOutUser();
                navigateAndReplacement(
                    context: context, widget: const SingInPage());
              },
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

Future<void> signOutUser() async {
  try {
    // تسجيل الخروج من Google (إن كان مستخدمًا)
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    // تسجيل الخروج من Facebook (إن كان مستخدمًا)
    // await FacebookAuth.instance.logOut();

    // تسجيل الخروج من Firebase
    await FirebaseAuth.instance.signOut();

    print("تم تسجيل الخروج بنجاح");
  } catch (e) {
    print("حدث خطأ أثناء تسجيل الخروج: $e");
  }
}
