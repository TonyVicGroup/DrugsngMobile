import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/loader/app_loader_widget.dart';
import 'package:drugs_ng/core/widgets/wrapper/bloc_provider_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, _) {
        return BlocProviderWrapper(
          child: GlobalLoaderOverlay(
            overlayWidgetBuilder: (_) {
              return const Center(child: AppLoaderWidget());
            },
            child: MaterialApp(
              restorationScopeId: 'app',
              navigatorKey: AppUtils.navKey,
              title: 'Drugs Ng',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF0B8AE1),
                ),
                useMaterial3: true,
                fontFamily: AppText.fontFamily,
                scaffoldBackgroundColor: AppColor.colorF3F5F9,
              ),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: AppRoutes.splash,
            ),
          ),
        );
      },
    );
  }
}

// UserPreference.getToken() == null
//       ? const OnboardingPage()
//       : const FetchingUserDetailScreen(),
