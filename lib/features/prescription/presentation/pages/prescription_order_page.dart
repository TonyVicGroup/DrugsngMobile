import 'package:dotted_border/dotted_border.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/widgets/tab_title_widget.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/data/datasource/user_preference.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/widgets/recent_upload_loader.dart';
import 'package:drugs_ng/features/prescription/presentation/widgets/recent_upload_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrescriptionOrderPage extends StatefulWidget {
  const PrescriptionOrderPage({super.key});

  @override
  State<PrescriptionOrderPage> createState() => _PrescriptionOrderPageState();
}

class _PrescriptionOrderPageState extends State<PrescriptionOrderPage> {
  int tabIndex = 0;
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.2),
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Order with Prescription").w700.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            BlocListener<PrescriptionCubit, PrescriptionState>(
              listener: (context, state) {
                if (state is PrescriptionUploadSuccess) {
                  AppToast.success(
                    context,
                    'Your prescription has been uploaded',
                  );
                  setState(() => file = null);
                } else if (state is PrescriptionError) {
                  AppToast.warning(context, state.error.message);
                }
              },
              child: 30.verticalSpace,
            ),
            Flexible(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withOpacity(0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 78.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.r),
                        ),
                      ),
                      child: TabTitleWidget(
                        title1: "New Upload",
                        title2: "Recents",
                        overallWidth: 226.w,
                        width1: 126.w,
                        width2: 98.w,
                        isTab1: tabIndex == 0,
                        animationDuration: AppUtils.kPageTransitionDuration,
                        onChanged: (v) {
                          setState(() => tabIndex = v ? 0 : 1);
                          if (!v) {
                            context.read<PrescriptionCubit>().getData();
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(24.r),
                          ),
                          color: const Color(0xffF9F9F9),
                        ),
                        child: AnimatedCrossFade(
                          duration: kThemeAnimationDuration,
                          crossFadeState:
                              tabIndex == 0
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                          firstChild: newUploadWidget(),
                          secondChild: recentUploads(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (file != null) ...[
              30.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: PrescriptionUploadWidget.fromFile(file: file!),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => file = null),
                    child: SvgPicture.asset(
                      AppSvg.delete,
                      width: 16.sp,
                      colorFilter: const ColorFilter.mode(
                        AppColor.red,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                ],
              ),
            ],
            30.verticalSpace,
            BlocBuilder<PrescriptionCubit, PrescriptionState>(
              builder: (context, state) {
                return AppButton.primary(
                  text: 'Upload',
                  status:
                      file == null
                          ? ButtonStatus.disabled
                          : state is PrescriptionUploadLoading
                          ? ButtonStatus.loading
                          : ButtonStatus.active,
                  onTap: () async {
                    try {
                      final userId = context.read<AuthCubit>().state.user!.id;
                      context.read<PrescriptionCubit>().addData(userId, file!);
                    } catch (e) {
                      AppToast.warning(
                        context,
                        "Unable to upload prescription",
                      );
                    }
                  },
                );
              },
            ),
            120.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget recentUploads() {
    return BlocBuilder<PrescriptionCubit, PrescriptionState>(
      builder: (context, state) {
        if (state.prescriptions.isEmpty) {
          if (state is PrescriptionLoading) {
            return SizedBox(height: 180.sp, child: const RecentUploadLoader());
          }
          return SizedBox(
            height: 180.sp,
            child: Center(
              child:
                  AppText.sp16(
                    "You have no recent prescriptions.",
                  ).setColor(const Color(0xFF979797)).centerText,
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.prescriptions.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final pres = state.prescriptions[index];
            return PrescriptionUploadWidget(prescription: pres);
          },
        );
      },
    );
  }

  Widget newUploadWidget() {
    return SizedBox(
      height: 180.sp,
      child: DottedBorder(
        strokeWidth: 2,
        color: const Color(0xFFD6D6D6),
        borderType: BorderType.RRect,
        radius: Radius.circular(24.r),
        borderPadding: EdgeInsets.all(34.sp),
        dashPattern: const [10, 6],
        child: InkWell(
          borderRadius: BorderRadius.circular(24.r),
          onTap: () async {
            final pickedFile = await pickFile();

            if (pickedFile == null) {
              return;
            }
            if (pickedFile.size >= 10485760) {
              AppToast.warning(
                // ignore: use_build_context_synchronously
                context,
                "Your File's size should be less than 10MB.",
              );
            } else {
              setState(() => file = pickedFile);
            }
          },
          child: Center(
            child:
                AppText.sp16(
                  "Tap here to browse for your file",
                ).setColor(const Color(0xFF979797)).w400.centerText,
          ),
        ),
      ),
    );
  }

  Future<PlatformFile?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    // User canceled the picker
    if (result == null) return null;

    return result.files.first;
  }
}
