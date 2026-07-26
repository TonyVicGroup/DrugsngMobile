import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditReviewPage extends StatefulWidget {
  final Review review;

  const EditReviewPage({super.key, required this.review});

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  late final TextEditingController msgCntrl;
  late int rating;

  @override
  void initState() {
    msgCntrl = TextEditingController(text: widget.review.reviewComment);
    rating = widget.review.ratingStar.toInt();
    super.initState();
  }

  @override
  void dispose() {
    msgCntrl.dispose();
    super.dispose();
  }

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
        title: AppText.sp18("Write a review").w700.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state.isLoggedIn) {
                  return Row(
                    children: [
                      Container(
                        width: 50.r,
                        height: 50.r,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFEDF8FF),
                        ),
                        child: Text(
                          state.user!.avatar,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.sp16(state.user!.fullName).w800.black,
                          4.verticalSpace,
                          AppText.sp12(
                            "Posting Publicly",
                          ).w400.setColor(const Color(0xFF6D6D6D)),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            20.verticalSpace,
            starRow(),
            20.verticalSpace,
            TextField(
              controller: msgCntrl,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
              maxLines: 7,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8B96A5),
                ),
                fillColor: const Color(0xFFF9F9F9),
                focusColor: const Color(0xFFF9F9F9),
                border: borderStyle(),
                enabledBorder: borderStyle(),
                focusedBorder: borderStyle(),
                disabledBorder: borderStyle(),
              ),
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 58.sp,
                    width: 150.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: AppText.sp16(
                      "Cancel",
                    ).w800.setColor(const Color(0xFF6D6D6D)),
                  ),
                ),
                10.horizontalSpace,
                SizedBox(
                  width: 150.w,
                  child: BlocConsumer<ReviewsCubit, ReviewsState>(
                    listener: (context, state) {
                      if (state.addEditStatus.isSuccess) {
                        Navigator.pop(context);
                      } else if (state.addEditStatus.isFailed) {
                        AppToast.warn(
                          context,
                          title: "Failed",
                          msg: state.error?.message ?? "Failed to post review",
                        );
                      }
                    },
                    builder: (context, state) {
                      return AppButton.primary(
                        status:
                            state.addEditStatus.isLoading
                                ? ButtonStatus.loading
                                : ButtonStatus.active,
                        text: "Post",
                        onTap: () => postReview(context),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 0.5),
    );
  }

  Widget starRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        rating >= 1 ? _starFilled(1) : _starOutline(1),
        15.horizontalSpace,
        rating >= 2 ? _starFilled(2) : _starOutline(2),
        15.horizontalSpace,
        rating >= 3 ? _starFilled(3) : _starOutline(3),
        15.horizontalSpace,
        rating >= 4 ? _starFilled(4) : _starOutline(4),
        15.horizontalSpace,
        rating >= 5 ? _starFilled(5) : _starOutline(5),
      ],
    );
  }

  Widget _starOutline(int idx) {
    return InkWell(
      onTap: () {
        setState(() {
          rating = idx;
        });
      },
      child: SvgPicture.asset(
        AppSvg.starOutline,
        height: 20.r,
        width: 20.r,
        colorFilter: const ColorFilter.mode(Color(0xFF8B96A5), BlendMode.srcIn),
      ),
    );
  }

  Widget _starFilled(int idx) {
    return InkWell(
      onTap: () {
        setState(() {
          rating = rating > idx ? idx : idx - 1;
        });
      },
      child: SvgPicture.asset(
        AppSvg.starFilled,
        height: 20.r,
        width: 20.r,
        colorFilter: const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
      ),
    );
  }

  void postReview(BuildContext context) {
    context.read<ReviewsCubit>().editReviews(
      reviewId: widget.review.id,
      comment: msgCntrl.text.trim(),
      rating: rating,
    );
  }
}
