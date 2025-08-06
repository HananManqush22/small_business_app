import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({
    super.key,
    required this.items,
    required this.selectedIndex,
  });
  final List<String> items;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15.h, right: 15.w, bottom: 5),
        width: MediaQuery.of(context).size.width,
        height: 50.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final bool isSelected = index == selectedIndex;

              return BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      ProjectCubit.get(context).changeIndex(index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        items[index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isSelected ? Colors.white : primaryFont,
                            ),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
