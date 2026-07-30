import 'package:dotted_border/dotted_border.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_outline_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/widgets/recent_upload_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewUploadTab extends StatelessWidget {
  const NewUploadTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrescriptionCubit, PrescriptionState>(
      listenWhen: (prev, curr) => prev.uploadStatus != curr.uploadStatus,
      buildWhen:
          (prev, curr) =>
              prev.pickedFile != curr.pickedFile ||
              prev.uploadStatus != curr.uploadStatus,
      listener: (context, state) {
        if (state.uploadStatus.isFailed) {
          AppToast.warn(
            context,
            title: 'Successful',
            msg: state.error ?? "An error occurred",
          );
        } else if (state.uploadStatus.isSuccess) {
          AppToast.success(
            context,
            title: 'Successful',
            msg: "Upload Successful",
          );
        }
      },
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            20.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: SizedBox(
                height: 234.h,
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomImage(
                        Assets.images.prescriptionImage.path,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned.fill(
                      child: Container(
                        color: AppColor.color333333.withAlpha(125),
                      ),
                    ),

                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.sp25(
                              "Doctor's Prescription for a Timely 🕒Refill",
                            ).w600.setColor(AppColor.colorFFFFFF).centerText,
                            5.verticalSpace,
                            AppText.sp12(
                              "Upload your doctor's prescription to ensure your"
                              "medications are refilled accurately and delivered on time.",
                            ).w400.setColor(AppColor.colorFFFFFF).centerText,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            AppText.sp20("How it works").w600.setColor(AppColor.color333333),
            7.verticalSpace,
            AppText.sp14(
              "The key benefit of using the Medplus loyalty card is the seamless "
              "experience it provides.",
            ).w400.setColor(AppColor.color333333),
            26.verticalSpace,
            _infoRow(
              1,
              'Take a Clear Photo',
              "Capture a clear image of your doctor's prescription with all details visible.",
            ),
            19.verticalSpace,
            _infoRow(
              2,
              'Upload the Image',
              'Select the photo from your device and upload it securely to our platform.',
            ),
            19.verticalSpace,
            _infoRow(
              3,
              'Confirm & Submit',
              'Review the uploaded image for accuracy, then submit it for processing and timely refill.',
            ),
            26.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColor.colorFFFFFF,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  DottedBorder(
                    color: AppColor.colorBABABA,
                    dashPattern: [3, 2],
                    radius: Radius.circular(7.r),
                    borderType: BorderType.RRect,
                    child: Container(
                      height: 190,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColor.colorF1F1F1,
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.pickedFile == null) ...[
                            Container(
                              width: 53.r,
                              height: 53.r,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.color0B8AE1.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: CustomImage(
                                Assets.svg.upload,
                                width: 16.w,
                                color: AppColor.color0B8AE1,
                              ),
                            ),
                            8.verticalSpace,
                            AppText.sp16(
                              "Drag & Drop the image or PDF File to upload",
                            ).w400.setColor(AppColor.color333333).centerText,
                            8.verticalSpace,
                            AppOutlineButton(
                              text: 'Select file',
                              borderRadius: 0,
                              height: 42.h,
                              width: 123.w,
                              fontWeight: FontWeight.w400,
                              borderColor: AppColor.color75869D,
                              onTap: () => selectFile(context),
                            ),
                          ] else
                            _temporalFilePicked(context, state.pickedFile!),
                        ],
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  AppText.sp12(
                    'File Support JPEG,PDF,PNG and limit size of 3MB',
                  ).w400.setColor(AppColor.color5B5B5B),
                  // 39.verticalSpace,
                  // BorderTextField(
                  //   hint: "Leave a note",
                  //   maxLines: 4,
                  //   borderColor: AppColor.colorF1F1F1,
                  //   fillColor: AppColor.colorF1F1F1,
                  //   filled: true,
                  // ),
                  20.verticalSpace,
                  AppGradientButton(
                    text: 'Submit Prescriptions',
                    onTap: () {
                      context.read<PrescriptionCubit>().submitPrescription();
                    },
                    status:
                        state.pickedFile == null
                            ? ButtonStatus.disabled
                            : (state.uploadStatus.isLoading
                                ? ButtonStatus.loading
                                : ButtonStatus.active),
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
            50.verticalSpace,
          ],
        );
      },
    );
  }

  Widget _infoRow(int index, String title, String detail) {
    return Row(
      children: [
        Container(
          width: 64.r,
          height: 64.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.color0B8AE1,
            shape: BoxShape.circle,
          ),
          child: AppText.sp20(
            index.toString(),
          ).w600.setColor(AppColor.colorFFFFFF),
        ),
        9.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.sp20(title).w600.setColor(AppColor.color333333),
              2.verticalSpace,
              AppText.sp13(detail).w400.setColor(AppColor.color333333),
            ],
          ),
        ),
      ],
    );
  }

  Widget _temporalFilePicked(BuildContext context, PlatformFile file) {
    return Row(
      children: [
        Expanded(child: PrescriptionUploadWidget.fromFile(file: file)),
        GestureDetector(
          onTap: () => clearFile(context),
          child: CustomImage(
            Assets.svg.delete,
            width: 16.sp,
            color: AppColor.red,
          ),
        ),
        8.horizontalSpace,
      ],
    );
  }

  Future<void> selectFile(BuildContext context) async {
    final pickedFile = await pickFile();

    if (pickedFile == null) return;

    if (pickedFile.size >= 10485760) {
      AppToast.warn(
        context,
        title: 'Warning',
        msg: "Your File's size should be less than 10MB.",
      );
    } else {
      context.read<PrescriptionCubit>().pickFile(pickedFile);
    }
  }

  void clearFile(BuildContext context) {
    context.read<PrescriptionCubit>().clearPickedFile();
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
