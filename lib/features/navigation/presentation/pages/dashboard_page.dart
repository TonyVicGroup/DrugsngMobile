import 'package:drugs_ng/core/enum/account_type_enum.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/navigation/presentation/cubit/tab_navigation_cubit.dart';
import 'package:drugs_ng/features/navigation/presentation/pages/tabs/delivery_tab_view.dart';
import 'package:drugs_ng/features/navigation/presentation/pages/tabs/doctor_tab_view.dart';
import 'package:drugs_ng/features/navigation/presentation/pages/tabs/patient_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();

  static PageRoute route(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const DashboardPage());
  }
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    AppUtils.tabController = TabController(length: 5, vsync: this);
    // listen for 401 errors globally
    // _errorStream = context.read<RestService>().errorStream.listen((event) {
    //   if (event.statusCode == 401) {
    //     context.read<AuthCubit>().logout();
    //     AppToast.warn(context, ApiError.unauthorized.message);
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    AppUtils.tabController = null;
    // _errorStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavigationCubit, TabNavigationState>(
      builder: (context, state) {
        return switch (state.accountType) {
          AccountTypeEnum.patient => const PatientTabView(),
          AccountTypeEnum.doctor => const DoctorTabView(),
          AccountTypeEnum.delivery => const DeliveryTabView(),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
