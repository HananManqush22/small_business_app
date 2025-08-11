import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/cubit/ideas_cubit/ideas_cubit.dart';
import 'package:small_business_app/widget/add_ideas_bottom_sheet.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_separator_line.dart';

class IdeasPage extends StatelessWidget {
  const IdeasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          print('Creating IdeasCubit');
          return IdeasCubit(DioConsume(dio: Dio()))..getIdeas();
        },
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
                  builder: (context) => BlocProvider.value(
                        value: IdeasCubit(DioConsume(dio: Dio())),
                        child: AddIdeasBottomSheet(),
                      ));
            },
            child: const Icon(
              Icons.add,
              color: backgroundColor,
            ),
          ),
          body: CustomBackground(item: BlocBuilder<IdeasCubit, IdeasState>(
            builder: (context, state) {
              var cubit = IdeasCubit.get(context);

              return cubit.ideasList.isEmpty
                  ? Center(child: Text('لاتوجد اي افكار'))
                  : ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            title: Text(
                              cubit.ideasList[index].title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: primaryColor),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                cubit.ideasList[index].description ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: primaryFont),
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) =>
                          CustomSeparatorLine(),
                      itemCount: cubit.ideasList.length);
            },
          )),
        ));
  }
}
