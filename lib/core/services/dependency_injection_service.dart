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
import 'package:drugs_ng/features/navigation/presentation/cubit/tab_navigation_cubit.dart';
import 'package:drugs_ng/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/features/product/presentation/cubit/product_detail_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/card/card_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_history_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/reviews_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:drugs_ng/features/search/presentation/cubit/search_cubit.dart';
import 'package:drugs_ng/features/verification/presentation/cubit/doctor_registration_cubit.dart';
import 'package:get_it/get_it.dart';

class DependencyInjectionService {
  static final GetIt inst = GetIt.instance;

  static void init() {
    inst
      // datasources
      ..registerLazySingleton<HomeCubit>(HomeCubit.new)
      ..registerLazySingleton<AuthCubit>(AuthCubit.new)
      ..registerLazySingleton<LoginCubit>(LoginCubit.new)
      ..registerLazySingleton<SignupCubit>(SignupCubit.new)
      ..registerLazySingleton<ExploreCubit>(ExploreCubit.new)
      // repositories
      ..registerLazySingleton<ExploreMajorCategoryCubit>(
        ExploreMajorCategoryCubit.new,
      )
      ..registerLazySingleton<ProductDetailCubit>(ProductDetailCubit.new)
      ..registerLazySingleton<LabTestCubit>(LabTestCubit.new)
      // cubits
      ..registerLazySingleton<CartCubit>(CartCubit.new)
      ..registerLazySingleton<PrescriptionCubit>(PrescriptionCubit.new)
      ..registerLazySingleton<OrderHistoryCubit>(OrderHistoryCubit.new)
      ..registerLazySingleton<WishlistCubit>(WishlistCubit.new)
      ..registerLazySingleton<AddressCubit>(AddressCubit.new)
      ..registerLazySingleton<DoctorCubit>(DoctorCubit.new)
      ..registerLazySingleton<ConsultationCubit>(ConsultationCubit.new)
      ..registerLazySingleton<UserConsultationsCubit>(
        UserConsultationsCubit.new,
      )
      ..registerLazySingleton<CardCubit>(CardCubit.new)
      ..registerLazySingleton<StateAndCityCubit>(StateAndCityCubit.new)
      ..registerLazySingleton<GetCountryCubit>(GetCountryCubit.new)
      ..registerLazySingleton<ReviewsCubit>(ReviewsCubit.new)
      ..registerLazySingleton<DoctorRegistrationCubit>(
        DoctorRegistrationCubit.new,
      )
      ..registerLazySingleton<TabNavigationCubit>(
        () => TabNavigationCubit(inst.get<AuthCubit>()),
      )
      ..registerLazySingleton<NotificationCubit>(NotificationCubit.new)
    // ..registerLazySingleton<SearchCubit>(SearchCubit.new)
    ;
  }
}
