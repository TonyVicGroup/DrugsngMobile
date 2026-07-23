import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/enum/request_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/widgets/error_page.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/doctor_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/schedule_consultation_page.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_appointment_loader.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_info_widget.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class DoctorAppointmentPage extends StatefulWidget {
  final int id;
  const DoctorAppointmentPage({super.key, required this.id});

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  ValueNotifier<LoadStatusEnum> status = ValueNotifier(LoadStatusEnum.initial);
  String? errorMsg;
  DoctorDetails? doctorDetails;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Appointment").w700.black,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getData();
        },
        child: BlocListener<DoctorCubit, DoctorState>(
          listener: (context, state) {
            if (state is DoctorStateError) {
              AppToast.warning(context, state.error.message);
            }
          },
          child: ValueListenableBuilder(
            valueListenable: status,
            builder: (context, value, child) {
              if (value == LoadStatusEnum.initial) {
                getData();
                return const DoctorAppointmentLoader();
              } else if (value == LoadStatusEnum.loading) {
                return const DoctorAppointmentLoader();
              } else if (value == LoadStatusEnum.failed) {
                return ErrorPage(message: errorMsg ?? '');
              }
              return appBody(doctorDetails!);
            },
          ),
        ),
      ),
    );
  }

  ListView appBody(DoctorDetails doctor) {
    return ListView(
      children: [
        30.verticalSpace,
        DoctorProfileWidget(doctor: doctor),
        30.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorInfoWidget(doctor: doctor),
              25.verticalSpace,
              AppText.sp16("About Doctor").w500.black,
              10.verticalSpace,
              ReadMoreText(
                doctor.about,
                trimMode: TrimMode.Length,
                trimLength: 140,
                trimCollapsedText: ' Read more',
                trimExpandedText: ' Show less',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8B96A5),
                ),
                moreStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.primary,
                ),
                lessStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.primary,
                ),
              ),

              if (doctor.availabilities.isNotEmpty) ...[
                25.verticalSpace,
                AppText.sp16("Consultation Hours").w500.black,
                10.verticalSpace,
                ...doctor.availabilities.map((avail) {
                  final timeSlots = avail.timeSlots;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.sp16(avail.dayOfWeek),
                      ...timeSlots.map((tSlot) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 3.r),
                          child: Row(
                            children: [
                              consultHourWidget(
                                tSlot.startTime.format(context),
                              ),
                              10.horizontalSpace,
                              AppText.sp14(
                                "-",
                              ).w500.setColor(const Color(0xFF6D6D6D)),
                              10.horizontalSpace,
                              consultHourWidget(tSlot.endTime.format(context)),
                            ],
                          ),
                        );
                      }),
                      10.verticalSpace,
                    ],
                  );
                }),
              ],
              25.verticalSpace,
              AppButton.primary(
                text: "Book for Consultation",
                onTap: bookConsultation,
              ),
              25.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }

  Container consultHourWidget(String txt) {
    return Container(
      width: 82.w,
      height: 42.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: AppText.sp14(txt).w500.setColor(const Color(0xFF6D6D6D)),
    );
  }

  Future<void> getData() async {
    status.value = LoadStatusEnum.loading;
    final result = await context.read<DoctorCubit>().getSingleDoctor(widget.id);
    if (result.$1 == null) {
      status.value = LoadStatusEnum.failed;
      errorMsg = result.$2;
    } else {
      status.value = LoadStatusEnum.success;
      doctorDetails = result.$1;
    }
  }

  void bookConsultation() {
    Navigator.push(
      context,
      AppUtils.transition(ScheduleConsultationPage(doctor: doctorDetails!)),
    );
  }
}
