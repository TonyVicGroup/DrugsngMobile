import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/utils/rest_service.dart';
import 'package:drugs_ng/src/features/auth/data/datasource/get_local_token.dart';
import 'package:drugs_ng/src/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/explore/data/datasource/explore_datasource_impl.dart';
import 'package:drugs_ng/src/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/src/features/explore/domain/repository/explore_datasource.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_filter/explore_filter_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:drugs_ng/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:drugs_ng/src/features/home/domain/repositories/home_repository.dart';
import 'package:drugs_ng/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:drugs_ng/src/features/lab_test/data/repository/lab_test_repo_impl.dart';
import 'package:drugs_ng/src/features/lab_test/domain/repository/lab_test_repo.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/cubit/lab_test_discovery_cubit.dart';
import 'package:drugs_ng/src/features/onboarding/presentation/pages/onboarding.dart';
import 'package:drugs_ng/src/features/product/data/repositories/product_repo_impl.dart';
import 'package:drugs_ng/src/features/product/domain/repositories/product_repo.dart';
import 'package:drugs_ng/src/features/product/presentation/cubit/product_cubit.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RestService>(create: (context) => RestService()),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepositoryImpl(context.read()),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(context.read()),
        ),
        RepositoryProvider<ExploreDatasource>(
          create: (context) => ExploreDatasourceImpl(context.read()),
        ),
        RepositoryProvider<ExploreRepository>(
          create: (context) => ExploreRepository(context.read()),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepositoryImpl(context.read()),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(context.read()),
        ),
        RepositoryProvider<LabTestRepository>(
          create: (context) => LabTestRepositoryImpl(context.read()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => ExploreBloc(context.read()),
          ),
          BlocProvider(
            create: (context) =>
                ExploreFilterBloc(exploreBloc: context.read<ExploreBloc>()),
          ),
          BlocProvider(
            create: (context) => ExploreMajorCategoryCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => ProductCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => LabTestCubit(context.read()),
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
              home:
                  // UserPreference.getToken() == null
                  //     ? const OnboardingPage()
                  //     :
                  const TabOverlay(),
            );
          },
        ),
      ),
    );
  }
}
