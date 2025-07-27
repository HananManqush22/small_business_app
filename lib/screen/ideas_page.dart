import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/cubit/ideas_cubit/ideas_cubit.dart';
import 'package:small_business_app/widget/add_ideas_bottom_sheet.dart';
import 'package:small_business_app/widget/custom_background.dart';

class IdeasPage extends StatelessWidget {
  const IdeasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: IdeasCubit(DioConsume(dio: Dio()))..getIdeas(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            '  الافكار ',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: backgroundColor),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                context: context,
                builder: (context) => const AddIdeasBottomSheet());
          },
          child: const Icon(
            Icons.add,
            color: backgroundColor,
          ),
        ),
        body: CustomBackground(
            item: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                        'note.title',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: primaryColor),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "note.subTitlenote.subTitlenote.subTitlenote.subTitlenote.subTitlenote.subTitlenote.subTitlenote.subTitlenote.subTitlenote.subTitle",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: primaryFont),
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 1.h,
                        width: MediaQuery.sizeOf(context).width,
                        color: fillColor,
                      ),
                    ),
                itemCount: 5)),
      ),
    );
  }
}
