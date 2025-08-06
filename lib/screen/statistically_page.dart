import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_card.dart';
import 'package:small_business_app/widget/custom_stat_card.dart';
import 'package:small_business_app/widget/financial_reports.dart';

class StatisticallyPage extends StatelessWidget {
  const StatisticallyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("لوحة التقارير والإحصائيات",
            style: TextStyle(color: backgroundColor)),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
          color: fillColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "تقارير عامة",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.h,
                ),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: const [
                    CustomStatCard(
                        title: 'إجمالي الطلبات',
                        icon: Icons.list_alt,
                        number: "123"),
                    CustomStatCard(
                        title: 'المنجزة',
                        icon: Icons.check_circle,
                        number: '95'),
                    CustomStatCard(
                        title: 'قيد التنفيذ',
                        icon: Icons.pending_actions,
                        number: "25"),
                    CustomStatCard(
                        title: 'ملغاة', icon: Icons.cancel, number: '3'),
                  ],
                ),
                CustomCard(
                    item: Column(
                      children: [
                        Text(
                          "تقارير مالية",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        FinancialReports(
                          icon: Icons.attach_money,
                          title: "إجمالي الدخل",
                          value: '12,000',
                        ),
                        FinancialReports(
                          icon: Icons.money_off,
                          title: 'المصروفات',
                          value: '12,000',
                        ),
                        FinancialReports(
                          icon: Icons.trending_up,
                          title: "الربح الصافي",
                          value: '12,000',
                        ),
                        FinancialReports(
                          icon: Icons.bar_chart,
                          title: "أرباح المشاريع",
                          value: "اضغط للتفاصيل",
                        ),
                      ],
                    ),
                    heigh: 310),
                CustomCard(
                    item: Column(
                      children: [
                        Text(
                          " تقارير زمنية",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        FinancialReports(
                          icon: Icons.calendar_today,
                          title: " عدد المشاريع هذا الشهر",
                          value: '3',
                        ),
                        FinancialReports(
                          icon: Icons.timer,
                          title: 'متوسط وقت التسليم',
                          value: '3 أيام',
                        ),
                        FinancialReports(
                          icon: Icons.check,
                          title: " سُلّمت قبل الموعد",
                          value: '12',
                        ),
                        FinancialReports(
                          icon: Icons.warning,
                          title: " مشاريع تأخرت",
                          value: "3 ",
                        ),
                      ],
                    ),
                    heigh: 310)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
