import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class ProjectExpensesPage extends StatelessWidget {
  const ProjectExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'خرج المشروع',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: backgroundColor),
          ),
        ),
      ),
      body: CustomBackground(
          item: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: SliverList.separated(
              itemCount: 10,
              itemBuilder: (context, index) => Row(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryFont,
                    radius: 3,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'هذه النص تجربي لا اكثر فقط للتجربة',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: primaryFont),
                  ),
                  const Spacer(),
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
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 1.h,
                  width: MediaQuery.sizeOf(context).width,
                  color: fillColor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(child: CustomTextFiled(hint: 'اكتب هنا')),
                SizedBox(
                  width: 8.w,
                ),
                SizedBox(
                  width: 90.w,
                  child: CustomTextFiled(
                    hint: '0',
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check,
                    color: primaryColor,
                    size: 25,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
