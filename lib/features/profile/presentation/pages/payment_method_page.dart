import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/profile/data/models/debit_card.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/card/card_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/pages/add_card_page.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/debit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, CardState>(
      buildWhen: (prev, current) {
        return AppUtils.isOnScreen(context);
      },
      builder: (context, state) {
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
            title: AppText.sp18("Payment Method").w700.black,
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Builder(
              builder: (context) {
                if (state.status.isInitial) {
                  context.read<CardCubit>().getCards();
                  return loadingCards();
                } else if (state.status.isLoading) {
                  return loadingCards();
                } else if (state.cards.isEmpty) {
                  return emptyCards(context);
                } else {
                  return cardsList(state.cards);
                }
              },
            ),
          ),
          bottomNavigationBar:
              state.status.isLoading
                  ? null
                  : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: AppButton.primary(
                        text: "Add Card",
                        onTap: () {
                          Navigator.push(
                            context,
                            AppUtils.transition(const AddCardPage()),
                          );
                        },
                      ),
                    ),
                  ),
        );
      },
    );
  }

  SizedBox cardsList(List<DebitCard> cards) {
    return SizedBox(
      height: 200.h,
      width: double.maxFinite,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return DebitCardWidget(card: cards[index]);
        },
        separatorBuilder: (context, index) => 15.horizontalSpace,
        itemCount: cards.length,
      ),
    );
  }

  Widget loadingCards() {
    return SizedBox(
      height: 200.h,
      width: double.maxFinite,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: AppColor.shimmerBase,
            highlightColor: AppColor.shimmerHighlight,
            child: Container(
              width: 314.w,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColor.shimmerBase,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => 15.horizontalSpace,
        itemCount: 2,
      ),
    );
  }

  Widget emptyCards(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CardCubit>().getCards();
      },
      child: ListView(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          20.verticalSpace,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 327.w,
              height: 257.h,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color(0xFFF9F9F9),
              ),
              child: Column(
                children: [
                  Image.asset(
                    AppImage.noDebitCard,
                    width: 201.w,
                    height: 129.h,
                  ),
                  15.verticalSpace,
                  AppText.sp16("No Debit Card Added").w700.black,
                  1.verticalSpace,
                  AppText.sp14(
                    "You can add a card and save it for later",
                  ).w400.setColor(const Color(0xFF6D6D6D)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
