import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/error_banner.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/consultation_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/doctor_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/doctor_appointment_page.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_filter_widget.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_list_tile.dart';
import 'package:drugs_ng/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/features/notification/presentation/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class FindDoctorPage extends StatefulWidget {
  const FindDoctorPage({super.key});

  @override
  State<FindDoctorPage> createState() => _FindDoctorPageState();
}

class _FindDoctorPageState extends State<FindDoctorPage> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DoctorCubit, DoctorState>(
        buildWhen: (previous, current) {
          return AppUtils.isOnScreen(context);
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                if (state is DoctorStateError)
                  ErrorBanner(
                    text: "${state.error.message}. Pull down to refresh",
                  ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    spacing: 5,
                    children: [
                      AppButton.back(() {
                        Navigator.pop(context);
                      }),
                      LocationChip.widget(context),
                      const Spacer(),
                      Row(
                        children: [
                          AppButton.svgIcon(
                            svg: AppSvg.notification,
                            onTap: () => notification(context),
                          ),
                          15.horizontalSpace,
                          AppButton.svgIcon(
                            svg: AppSvg.shopping,
                            onTap: () => cart(context),
                            color: AppColor.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      AppText.sp16("Find a doctor").w500.black,
                      const Spacer(),
                      if (state.hasFilter)
                        TextButton(
                          onPressed: () {
                            context.read<DoctorCubit>().clearFilter();
                          },
                          child: AppText.sp14('Clear Filter'),
                        ),
                      BlocBuilder<ConsultationCubit, ConsultationState>(
                        builder: (context, consultState) {
                          final services = consultState.homeData.service;
                          final String? selected =
                              (state.parameters.speciality?.isEmpty ?? true)
                                  ? null
                                  : state.parameters.speciality;
                          return DropdownButton<String>(
                            value: selected,
                            alignment: Alignment.centerRight,
                            underline: const SizedBox.shrink(),
                            elevation: 1,
                            padding: EdgeInsets.zero,
                            dropdownColor: AppColor.white,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: SvgPicture.asset(
                                  AppSvg.chevronThick,
                                  width: 10.sp,
                                  height: 10.sp,
                                  colorFilter: const ColorFilter.mode(
                                    AppColor.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            items:
                                services
                                    .map(
                                      (service) => DropdownMenuItem<String>(
                                        value: service.specialist,
                                        child:
                                            AppText.sp14(
                                              service.name,
                                            ).w400.black,
                                      ),
                                    )
                                    .toList(),
                            onChanged: (sType) {
                              if (sType != null) {
                                context.read<DoctorCubit>().setService(sType);
                                context.read<DoctorCubit>().findDoctor();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SizedBox(
                    height: 40.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: const Color(0xFFEDF2F7),
                            ),
                            child: Theme(
                              data: ThemeData(
                                inputDecorationTheme: InputDecorationTheme(
                                  constraints: BoxConstraints(maxHeight: 40.h),
                                ),
                              ),
                              child: TextField(
                                controller: controller,
                                onSubmitted: (query) {
                                  context.read<DoctorCubit>().findDoctor(query);
                                },
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.r),
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText: "Search",
                                  icon: InkWell(
                                    onTap:
                                        () => context
                                            .read<DoctorCubit>()
                                            .findDoctor(controller.text),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.r),
                                      child: const CustomImage(AppSvg.search),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const DoctorFilterWidget(),
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is DoctorStateLoading) {
                        return loader();
                      } else if (state.doctors.isEmpty) {
                        return Center(
                          child: AppText.sp16("Nothing doctor available!"),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          // vertical: 20.h,
                        ),
                        itemBuilder: (context, index) {
                          final doctor = state.doctors[index];
                          return DoctorListTile(
                            doctor: doctor,
                            showRating: true,
                            onTap: () => toDoctorPage(doctor.id),
                          );
                        },
                        separatorBuilder: (context, index) => 20.verticalSpace,
                        itemCount: state.doctors.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget loader() {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          // vertical: 20.h,
        ),
        itemBuilder: (context, index) {
          return Container(
            height: 101.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColor.shimmerHighlight,
              borderRadius: BorderRadius.circular(10.r),
            ),
          );
        },
        separatorBuilder: (context, index) => 20.verticalSpace,
        itemCount: 3,
      ),
    );
  }

  void notification(BuildContext context) {
    Navigator.push(context, AppUtils.transition(const NotificationPage()));
  }

  void cart(BuildContext context) {
    Navigator.push(context, AppUtils.transition(const CartPage()));
  }

  void toDoctorPage(int doctorId) {
    Navigator.push(
      context,
      AppUtils.transition(DoctorAppointmentPage(id: doctorId)),
    );
  }
}
