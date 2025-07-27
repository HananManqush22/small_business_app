import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';
import 'package:small_business_app/screen/show_profiled_page.dart';
import 'package:small_business_app/screen/show_project_page.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/custom_card.dart';
import 'package:small_business_app/widget/custom_text_button.dart';
import 'package:small_business_app/widget/item_card.dart';

import 'package:small_business_app/models/client_model.dart';

import 'package:small_business_app/models/project_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "الكل",
      'قيد التنفيد',
      'تحت الانتظار',
      "تحت المراجعة",
      "ثم الانهاء",
    ];
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
            child: CustomTextButton(
                title: 'البراند',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: backgroundColor),
                onPressed: () {
                  navigateAndFinish(
                      context: context, widget: ShowProfiledPage());
                }),
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected =
                  !connectivity.contains(ConnectivityResult.none);
              return connected
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(25)),
                        color: fillColor,
                      ),
                      child: BlocBuilder<ProjectCubit, ProjectState>(
                        builder: (context, state) {
                          var clientCubit = ClientsCubit.get(context);
                          var cubit = ProjectCubit.get(context);

                          return Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 15.h, right: 15.w, bottom: 5),
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
                                        final bool isSelected =
                                            index == cubit.selectedIndex;
                                        return InkWell(
                                          onTap: () {
                                            cubit.changeIndex(index);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 12.h),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? primaryColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              items[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : primaryFont,
                                                  ),
                                            ),
                                          ),
                                        );
                                      })),
                              Expanded(
                                child: BlocBuilder<ProjectCubit, ProjectState>(
                                  builder: (context, state) {
                                    List<Data> filterProject =
                                        cubit.getFilteredStatus(
                                            items[cubit.selectedIndex]);

                                    if (state is GetProjectLoadingState) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: primaryColor),
                                      );
                                    }
                                    return ListView.builder(
                                      itemCount: filterProject.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var projectItem = filterProject[index];
                                        List<ClientData> clientId =
                                            clientCubit.getClintById(
                                                    projectItem.clientID) ??
                                                [];
                                        int days = cubit.getProgressPercent(
                                            projectItem.date ?? '');

                                        return CustomCard(
                                          heigh: 150,
                                          item: InkWell(
                                            onTap: () {
                                              navigateAndFinish(
                                                context: context,
                                                widget: ShowProjectPage(
                                                  title: '${projectItem.name}',
                                                  states:
                                                      '${projectItem.status}',
                                                  cost: '${projectItem.cost}',
                                                  date: '${projectItem.date}',
                                                  client: clientId.isEmpty
                                                      ? ''
                                                      : '${clientId[0].name}',
                                                  description:
                                                      '${projectItem.description}',
                                                  days: '$days',
                                                ),
                                              );
                                            },
                                            child: ItemCard(
                                              title: '${projectItem.name}',
                                              states: '${projectItem.status}',
                                              cost: '${projectItem.cost}',
                                              date: '${projectItem.date}',
                                              client: clientId.isEmpty
                                                  ? ''
                                                  : '${clientId[0].name}',
                                              days: '$days',
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      ))
                  : Center(
                      child: Text('con not connected, check the internet '),
                    );
            },
            child: SizedBox(),
          )),
    );
  }
}
