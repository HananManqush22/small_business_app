import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/screen/client_add_page.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/custom_background.dart';

class ShowClientsPage extends StatelessWidget {
  const ShowClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Row(
            children: [
              Text(
                ' العملاء',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: backgroundColor),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: backgroundColor,
                  )),
            ],
          ),
        ),
        body: CustomBackground(
          item: BlocBuilder<ClientsCubit, ClientsState>(
            builder: (context, state) {
              var cubit = ClientsCubit.get(context);
              final clients = cubit.clients;
              return clients.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        final client = clients[index];

                        return Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: primaryColor,
                              child: Text(
                                'ع',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: backgroundColor),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Text(
                                  '${client.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: primaryColor),
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    Text(
                                      '${client.phone}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: primaryFont),
                                    ),
                                    Text(
                                      '/  ${client.email} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: primaryFont),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 1.h,
                              width: MediaQuery.sizeOf(context).width,
                              color: fillColor,
                            ),
                          ),
                      itemCount: clients.length)
                  : Center(
                      child: Text(
                      'لا يوجد اي عملاء ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            navigateAndFinish(context: context, widget: ClientAddPage());
          },
          child: const Icon(
            Icons.add,
            color: backgroundColor,
          ),
        ));
  }
}
