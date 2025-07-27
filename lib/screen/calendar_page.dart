import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late ProjectCubit cubit;
  Set<DateTime> markedDays = {};

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void initState() {
    super.initState();
    cubit = ProjectCubit.get(context);
    cubit.getProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            " تسليم الطلبات",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: backgroundColor),
          ),
        ),
      ),
      body: CustomBackground(
        item: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            if (state is GetProjectSuccessState) {
              markedDays = cubit.getMarkedDates().toSet();
            }
            return TableCalendar(
              locale: 'ar_EG',
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.saturday,
              onDaySelected: null,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                isTodayHighlighted: false,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 12, color: Colors.black),
                weekendStyle: TextStyle(fontSize: 12, color: Colors.black),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  bool isMarked = markedDays.any((d) => isSameDay(d, day));
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: isMarked ? primaryColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '${day.day}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color:
                                    isMarked ? backgroundColor : Colors.black,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
