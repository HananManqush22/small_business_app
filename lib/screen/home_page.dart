import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_card.dart';
import 'package:small_business_app/widget/custom_tap_bar.dart';
import 'package:small_business_app/widget/item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              SvgPicture.asset(
                'assets/images/logo_icon.svg',
                height: 20.h,
                width: 20.w,
              ),
              Text(
                'هانلي',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: backgroundColor),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_outlined,
                  color: backgroundColor,
                )),
            IconButton(
                onPressed: () {},
                icon: Badge.count(
                  count: 77,
                  child: const Icon(
                    Icons.notifications,
                    color: backgroundColor,
                  ),
                )),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.segment_outlined,
                    color: backgroundColor,
                  ));
            }),
          ],
        ),
        endDrawer: Drawer(
          backgroundColor: primaryColor,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
              color: fillColor,
            ),
            child: Column(
              children: [
                CustomTapBar(),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => CustomCard(
                      heigh: 150,
                      item: ItemCard(),
                    ),
                    itemCount: 7,
                    shrinkWrap: true,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
