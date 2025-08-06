import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';
import 'package:small_business_app/screen/show_project_page.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/custom_card.dart';
import 'package:small_business_app/widget/custom_drawer.dart';
import 'package:small_business_app/widget/custom_tap_bar.dart';
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
      'مكتمل ',
      ' ثم التسليم',
      ' ثم الالغاء',
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
          endDrawer: CustomDrawer(),
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
                              CustomTapBar(
                                items: items,
                                selectedIndex: cubit.selectedIndex,
                              ),
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

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: CustomCard(
                                            heigh: 150,
                                            item: InkWell(
                                              onTap: () {
                                                navigateAndFinish(
                                                  context: context,
                                                  widget: ShowProjectPage(
                                                    reminderDate:
                                                        '${projectItem.remendDate}',
                                                    title:
                                                        '${projectItem.name}',
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
                                                    projectId: projectItem.id!,
                                                    status:
                                                        '${projectItem.status}',
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
