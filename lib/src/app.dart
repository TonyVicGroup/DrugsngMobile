import 'package:drugs_ng/features/onboarding/presentation/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, context) {
          return MaterialApp(
            restorationScopeId: 'app',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: 'Satoshi',
              // scaffoldBackgroundColor: NbColors.background,
            ),
            home: const OnboardingPage(),
          );
        });
  }
}
