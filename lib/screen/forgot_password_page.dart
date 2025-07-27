import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: fillColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 100.h),
                      child: SizedBox(
                          width: 80.w,
                          height: 80.h,
                          child: Image.asset(
                            'assets/images/icon.png',
                          )),
                    ),
                    CustomTextFiled(
                      hint: ' الايميل',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButtonClick(
                      isLoading: false,
                      onTap: () {},
                      title: 'تسجيل',
                      sizeWidth: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
