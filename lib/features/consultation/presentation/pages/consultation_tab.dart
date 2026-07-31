import 'dart:math' as math;
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/error_banner.dart';
import 'package:drugs_ng/core/widgets/error_page.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/consultation/data/models/consult_service.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/consultation_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/doctor_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/doctor_appointment_page.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/find_doctor_page.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/consultation_doctor_carousel.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/consultation_loader.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_list_tile.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/service_list_tile.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_header_widget.dart';
import 'package:drugs_ng/features/notification/presentation/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultationTab extends StatefulWidget {
  const ConsultationTab({super.key});

  @override
  State<ConsultationTab> createState() => _ConsultationTabState();
}

class _ConsultationTabState extends State<ConsultationTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ConsultationCubit, ConsultationState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ConsultationCubit>().getHomeData(
                  refreshPage: false,
                );
              },
              child:
                  (state.homeData.isEmpty &&
                          state.getConsultationsStatus.isFailed)
                      ? ErrorPage(message: state.error!)
                      : ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          if (state.getConsultationsStatus.isFailed)
                            ErrorBanner(
                              text: "${state.error}. Pull down to refresh",
                            ),
                          16.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: HomeHeaderWidget(),
                          ),
                          10.verticalSpace,
                          Builder(
                            builder: (context) {
                              if (state.getConsultationsStatus.isInitial) {
                                context.read<ConsultationCubit>().getHomeData();
                                return const ConsultationLoader();
                              } else if (state
                                  .getConsultationsStatus
                                  .isLoading) {
                                return const ConsultationLoader();
                              }
                              return appBody(state);
                            },
                          ),
                        ],
                      ),
            );
          },
        ),
      ),
    );
  }

  Widget appBody(ConsultationState state) {
    int doctorLength = math.min(10, state.homeData.doctors.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConsultationDoctorCarousel(),
        30.verticalSpace,
        if (state.homeData.service.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: AppText.sp16("Our Services").w500.black,
          ),
          30.verticalSpace,
          SizedBox(
            width: double.maxFinite,
            height: 63.h,
            child: ListView.separated(
              itemCount: state.homeData.service.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemBuilder: (context, index) {
                final service = state.homeData.service[index];
                return ServiceListTile(
                  service: service,
                  onTap: () => setConsultService(service),
                );
              },
              separatorBuilder: (context, index) => 25.horizontalSpace,
            ),
          ),
          30.verticalSpace,
        ],
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.sp16("Top Consulted Doctors").w500.black,
              AppText.sp16("View All").w400.primaryColor.clickable(viewAll),
            ],
          ),
        ),
        if (doctorLength <= 0)
          SizedBox(
            height: 100.h,
            width: double.maxFinite,
            child: Center(child: AppText.sp16("No Top Doctor")),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
            itemBuilder: (context, index) {
              final doctor = state.homeData.doctors[index];
              return DoctorListTile(
                doctor: doctor,
                onTap: () => _nextPage(DoctorAppointmentPage(id: doctor.id)),
              );
            },
            separatorBuilder: (context, index) => 20.verticalSpace,
            itemCount: doctorLength,
          ),
      ],
    );
  }

  void notification() {
    Navigator.push(context, AppUtils.transition(const NotificationPage()));
  }

  void cart() {
    Navigator.push(context, AppUtils.transition(const CartPage()));
  }

  void setConsultService(ConsultService service) {
    context.read<DoctorCubit>().setService(service.specialist);
    context.read<DoctorCubit>().findDoctor();
    _nextPage(const FindDoctorPage());
  }

  void viewAll() {
    context.read<DoctorCubit>().setService('');
    context.read<DoctorCubit>().findDoctor();
    _nextPage(const FindDoctorPage());
  }

  Future _nextPage(Widget page) async {
    // context.read<NavigationTabCubit>().hide();
    // await Navigator.push(context, AppUtils.transition(page));
    // // ignore: use_build_context_synchronously
    // context.read<NavigationTabCubit>().show();
  }
}
