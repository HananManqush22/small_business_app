import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_card.dart';
import 'package:small_business_app/widget/custom_text_button.dart';
import 'package:small_business_app/widget/item_card.dart';

class ShowProjectPage extends StatelessWidget {
  const ShowProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillColor,
      body: Stack(
        children: [
          Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 30.h, right: 7.w, left: 7.w),
                  child: Column(
                    children: [
                      CustomCard(item: ItemCard(), heigh: 180),
                      Row(
                        children: [
                          Expanded(
                            child: CustomCard(
                                item: Column(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: primaryColor,
                                      size: 60,
                                    ),
                                    Text(
                                      'المصروفات',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: primaryColor),
                                    ),
                                  ],
                                ),
                                heigh: 130),
                          ),
                          Expanded(
                            child: CustomCard(
                                item: Column(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: primaryColor,
                                      size: 60,
                                    ),
                                    Text(
                                      'المصروفات',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: primaryColor),
                                    ),
                                  ],
                                ),
                                heigh: 130),
                          ),
                        ],
                      ),
                      CustomCard(
                          item: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                'المفكرة',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: primaryColor),
                              ),
                              Text(
                                'هذه النص تجربي لا اكثر فقط للتجربة هذه النص تجربي لا اكثر فقط للتجربة هذه النص تجربي لا اكثر فقط للتجربة هذه النص تجربي لا اكثر فقط للتجربة هذه النص تجربي لا اكثر فقط للتجربة هذه النص تجربي لا اكثر فقط للتجربة هذه النص تجربي لا اكثر فقط للتجربة',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: primaryFont,
                                    ),
                              )
                            ],
                          ),
                          heigh: 170),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.only(right: 17.w, left: 17.w, top: 7.h),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'مهام المشروع',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              // SliverList.separated(
              //   itemCount: 3,
              //   itemBuilder: (context, index) => Container(
              //     color: backgroundColor,
              //     child: Row(
              //       children: [
              //         CircleAvatar(
              //           backgroundColor: primaryFont,
              //           radius: 3,
              //         ),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Text(
              //           'هذه النص تجربي لا اكثر فقط للتجربة',
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodySmall
              //               ?.copyWith(color: primaryFont),
              //         ),
              //         const Spacer(),
              //         Text(
              //           '55',
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodySmall
              //               ?.copyWith(color: primaryFont),
              //         ),
              //         Icon(
              //           Icons.attach_money,
              //           color: primaryFont,
              //           size: 18,
              //         ),
              //       ],
              //     ),
              //   ),
              //   separatorBuilder: (context, index) => Padding(
              //     padding: const EdgeInsets.all(15.0),
              //     child: Container(
              //       height: 1.h,
              //       width: MediaQuery.sizeOf(context).width,
              //       color: fillColor,
              //     ),
              //   ),
              // ),

              SliverPadding(
                padding: EdgeInsets.only(
                  right: 10.w,
                  left: 10.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    margin: EdgeInsets.only(right: 7.w, left: 7.w),
                    color: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: List.generate(3, (index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: primaryFont,
                                  radius: 3,
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Text(
                                    'هذه النص تجربي لا اكثر فقط للتجربة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: primaryFont),
                                  ),
                                ),
                                Text(
                                  '55',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: primaryFont),
                                ),
                                Icon(
                                  Icons.attach_money,
                                  color: primaryFont,
                                  size: 18,
                                ),
                              ],
                            ),
                            if (index != 2) // لا تضف فاصل بعد العنصر الأخير
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  height: 1.h,
                                  width: double.infinity,
                                  color: fillColor,
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 15.h),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(right: 7.w, left: 7.w),
                    alignment: Alignment.topRight,
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
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: CustomTextButton(
                        title: 'اضافة مهمه',
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: primaryFont,
                                ),
                        onPressed: () {}),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
