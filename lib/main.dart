import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/core/cache/cache_helper.dart';
import 'package:small_business_app/configuration/them_data.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';
import 'package:small_business_app/cubit/simple_observer_bloc.dart';
import 'package:small_business_app/firebase_options.dart';
import 'package:small_business_app/screen/log_in_page.dart';
import 'package:small_business_app/screen/navigation_bar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  Bloc.observer = SimpleObserverBloc();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          final Dio dio = Dio();
          final dioConsume = DioConsume(dio: dio);

          return MultiBlocProvider(
              providers: [
                BlocProvider(
                  lazy: false,
                  create: (context) => ClientsCubit(dioConsume)..getClint(),
                ),
                BlocProvider(
                  create: (context) => ProjectCubit(dioConsume)..getProject(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('ar'),
                ],
                theme: lightThem,
                home: user != null && user.emailVerified
                    ? const NavigationBarPage()
                    : const LoginPag(),
              ));
        });
  }
}
