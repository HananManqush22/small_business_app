import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/cubit/profile_cubit/profile_cubit.dart';

class ShowProfiledPage extends StatelessWidget {
  const ShowProfiledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ProfileCubit(DioConsume(dio: Dio()))..getProfile(),
      child: Scaffold(
        backgroundColor: fillColor,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state is GetProfileStateLoadingState
                ? Center(child: CircularProgressIndicator())
                : state is GetProfileSuccessState
                    ? Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 230.h,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  // backgroundImage: NetworkImage(
                                  //     '${state.profiledModel[0].logo}'),
                                ),
                                Text(
                                  '${state.profiledModel[0].name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: backgroundColor),
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'الوصف',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: primaryColor),
                            ),
                            subtitle: Text(
                              '${state.profiledModel[0].description}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: fontColor),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'العنوان',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: primaryColor),
                            ),
                            subtitle: Text(
                              '${state.profiledModel[0].address}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: fontColor),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'رقم الهاتف',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: primaryColor),
                            ),
                            subtitle: Text(
                              '${state.profiledModel[0].phone}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: fontColor),
                            ),
                          ),
                        ],
                      )
                    : Container();
          },
        ),
      ),
    );
  }
}
