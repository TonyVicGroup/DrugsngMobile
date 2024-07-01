import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/home/data/datasources/home_datasource.dart';
import 'package:drugs_ng/src/features/home/data/repositories/home_repository.dart';
import 'package:drugs_ng/src/features/home/domain/repositories/home_datasource.dart';
import 'package:drugs_ng/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:drugs_ng/src/features/onboarding/presentation/pages/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeDatasource>(
          create: (context) => HomeLocalDatasource(),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(context.read()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(context.read()),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(430, 932),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, context) {
              return MaterialApp(
                restorationScopeId: 'app',
                navigatorKey: AppUtils.navKey,
                title: 'Drugs Ng',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: const Color(0xFF0B8AE1)),
                  useMaterial3: true,
                  fontFamily: AppText.fontFamily,
                  scaffoldBackgroundColor: AppColor.white,
                ),
                home: const OnboardingPage(),
              );
            }),
      ),
    );
  }
}
