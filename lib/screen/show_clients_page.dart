import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/screen/client_add_page.dart';
import 'package:small_business_app/widget/client_item.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_separator_line.dart';

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

                        return ClientItem(
                            name: '${client.name}',
                            phone: '${client.phone}',
                            email: '${client.email}');
                      },
                      separatorBuilder: (context, index) =>
                          CustomSeparatorLine(),
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
