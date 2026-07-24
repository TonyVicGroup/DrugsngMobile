import 'package:drugs_ng/core/cubits/navigation_tab_cubit.dart';
import 'package:drugs_ng/core/services/dependency_injection_service.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/login_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/state_and_city_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/consultation_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/doctor_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/user_consultations_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:drugs_ng/features/home/presentation/cubit/get_country_cubit.dart';
import 'package:drugs_ng/features/home/presentation/cubit/home_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/features/product/presentation/cubit/product_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/card/card_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_history_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/reviews_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:drugs_ng/features/verification/presentation/cubit/doctor_registration_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviderWrapper extends StatelessWidget {
  const BlocProviderWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => DependencyInjectionService.inst.get<NavigationTabCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<HomeCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<SignupCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<ExploreCubit>(),
        ),
        BlocProvider(
          create:
              (_) =>
                  DependencyInjectionService.inst
                      .get<ExploreMajorCategoryCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<ProductCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<LabTestCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<CartCubit>(),
        ),
        BlocProvider(
          create:
              (_) => DependencyInjectionService.inst.get<PrescriptionCubit>(),
        ),
        BlocProvider(
          create:
              (_) => DependencyInjectionService.inst.get<OrderHistoryCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<WishlistCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<AddressCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<DoctorCubit>(),
        ),
        BlocProvider(
          create:
              (_) => DependencyInjectionService.inst.get<ConsultationCubit>(),
        ),
        BlocProvider(
          create:
              (_) =>
                  DependencyInjectionService.inst.get<UserConsultationsCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<CardCubit>(),
        ),
        BlocProvider(
          create:
              (_) => DependencyInjectionService.inst.get<StateAndCityCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<GetCountryCubit>(),
        ),
        BlocProvider(
          create: (_) => DependencyInjectionService.inst.get<ReviewsCubit>(),
        ),
        BlocProvider(
          create:
              (_) =>
                  DependencyInjectionService.inst
                      .get<DoctorRegistrationCubit>(),
        ),
      ],
      child: child,
    );
  }
}
