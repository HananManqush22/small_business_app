import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/create_user_cubit/create_user_cubit.dart';
import 'package:small_business_app/screen/forgot_password_page.dart';
import 'package:small_business_app/screen/home_page.dart';
import 'package:small_business_app/screen/create_user_page.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_button.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: fillColor,
        body: BlocProvider(
          create: (context) => CreateUserCubit(),
          child: SafeArea(
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 45.h),
                          child: SizedBox(
                              width: 80.w,
                              height: 80.h,
                              child: Image.asset(
                                'assets/images/icon.png',
                              )),
                        ),
                        Text('تسجيل الدخول',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: primaryColor)),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextFiled(
                          hint: 'الايميل',
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextFiled(
                          hint: 'كلمة السر',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                          controller: password,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 195.w),
                            child: CustomTextButton(
                              onPressed: () {
                                navigateAndFinish(
                                    context: context,
                                    widget: ForgotPasswordPage());
                              },
                              title: 'نسيت كلمة السر؟',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: primaryColor),
                            )),
                        BlocConsumer<CreateUserCubit, CreateUserState>(
                          listener: (context, state) {
                            if (state is UserCreateSuccessState) {
                              navigateAndReplacement(
                                  context: context, widget: HomePage());
                            }
                          },
                          builder: (context, state) {
                            return CustomButtonClick(
                              isLoading: state is SingInLoadingState,
                              onTap: () async {
                                var cubit = CreateUserCubit.get(context);
                                if (formKey.currentState!.validate()) {
                                  await cubit.singInUser(
                                      email: email.text,
                                      password: password.text);
                                }
                              },
                              title: 'تسجيل',
                              sizeWidth: MediaQuery.of(context).size.width,
                            );
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'لاتملك حساب؟',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: primaryFont),
                            ),
                            InkWell(
                              onTap: () {
                                navigateAndFinish(
                                    context: context, widget: CreateUserPage());
                              },
                              child: Text(
                                'سجل',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          spacing: 3,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width / 3.5,
                              height: 1,
                              color: primaryFont,
                            ),
                            Text(
                              'التسجيل عبر',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: primaryColor),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width / 3.5,
                              //width: 93.w,
                              height: 1,
                              color: primaryFont,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BlocConsumer<CreateUserCubit, CreateUserState>(
                          listener: (context, state) {
                            if (state is SingInGooglSuccessState) {
                              navigateAndReplacement(
                                  context: context, widget: HomePage());
                            }
                          },
                          builder: (context, state) {
                            return Row(
                              spacing: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage('assets/images/login.png'),
                                  backgroundColor: backgroundColor,
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage('assets/images/login_fec.png'),
                                  backgroundColor: backgroundColor,
                                ),
                                InkWell(
                                  onTap: () {
                                    CreateUserCubit.get(context)
                                        .signInWithGoogle();
                                  },
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                        'assets/images/login_googl.png'),
                                    backgroundColor: backgroundColor,
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
