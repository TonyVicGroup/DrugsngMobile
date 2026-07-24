import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/core/widgets/tab_title_widget.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_history_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/order_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
      listener: (context, state) {
        if (state.inProgressStatus.isFailed) {
          AppToast.warn(context, state.inProgressError?.message ?? "");
        }
        if (state.settledStatus.isFailed) {
          AppToast.warn(context, state.settledError?.message ?? "");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 5,
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
            title: AppText.sp18("Order History").w700.black,
            centerTitle: true,
            // actions: [
            //   if (!(state.inProgressStatus.isLoading ||
            //       state.settledStatus.isLoading))
            //     IconButton(
            //       onPressed: loadHistory,
            //       icon: const Icon(Icons.refresh),
            //     ),
            // ],
          ),
          body: Builder(
            builder: (context) {
              return Column(
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
                      title1: "In Progress",
                      title2: "Settled",
                      overallWidth: 210.w,
                      width1: 112.w,
                      width2: 87.w,
                      isTab1: state.tabStatus.isInProgress,
                      onChanged: (v) {
                        context.read<OrderHistoryCubit>().changeTab(v);
                      },
                    ),
                  ),
                  Flexible(
                    child: AnimatedContainer(
                      duration: AppUtils.kPageTransitionDuration,
                      child: AnimatedCrossFade(
                        firstChild: inProgress(),
                        secondChild: settled(),
                        crossFadeState:
                            state.tabStatus.isInProgress
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                        duration: AppUtils.kPageTransitionDuration,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void loadHistory() {
    final historyCubit = context.read<OrderHistoryCubit>();

    /// check if page is not loaded yet
    if (historyCubit.state.stateNotLoaded()) {
      /// load the corresponding data
      if (historyCubit.state.tabStatus.isInProgress) {
        context.read<OrderHistoryCubit>().getInProgress(showLoader: true);
      } else {
        context.read<OrderHistoryCubit>().getSettled(showLoader: true);
      }
    }
  }

  Widget inProgress() {
    loadHistory();
    final state = context.read<OrderHistoryCubit>().state;
    if (state.inProgressStatus.isLoading || state.inProgressStatus.isInitial) {
      return listLoaderWidget();
    } else if (state.inProgress.isEmpty) {
      if (state.inProgressStatus.isFailed) {
        return errorOccuredWidget(() {
          context.read<OrderHistoryCubit>().getInProgress(showLoader: true);
        });
      } else {
        return emptyHistoryWidget("You haven't placed any orders yet");
      }
    }
    return FetchMoreIndicator(
      onAction: () async {
        await context.read<OrderHistoryCubit>().fetchMoreInProgress();
      },
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return OrderHistoryTile(orderHistory: state.inProgress[index]);
        },
        separatorBuilder: (context, index) => 20.verticalSpace,
        itemCount: state.inProgress.length,
      ),
    );
  }

  Widget settled() {
    loadHistory();
    final state = context.read<OrderHistoryCubit>().state;
    if (state.settledStatus.isLoading || state.settledStatus.isInitial) {
      return listLoaderWidget();
    } else if (state.settled.isEmpty) {
      if (state.settledStatus.isFailed) {
        return errorOccuredWidget(() {
          context.read<OrderHistoryCubit>().getSettled(showLoader: true);
        });
      } else {
        return emptyHistoryWidget("You have not settled any orders yet.");
      }
    }

    return FetchMoreIndicator(
      onAction: () async {
        await context.read<OrderHistoryCubit>().fetchMoreSettled();
      },
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return OrderHistoryTile(orderHistory: state.settled[index]);
        },
        separatorBuilder: (context, index) => 20.verticalSpace,
        itemCount: state.settled.length,
      ),
    );
  }

  Widget emptyHistoryWidget(String message) {
    return SizedBox(
      height: 200.h,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64.sp,
            color: AppColor.black.withOpacity(0.3),
          ),
          16.verticalSpace,
          AppText.sp16("No Order History").w600.black,
          8.verticalSpace,
          AppText.sp14(
            message,
          ).w400.copyWith(color: AppColor.black.withOpacity(0.6)),
        ],
      ),
    );
  }

  Widget errorOccuredWidget(void Function() reload) {
    return SizedBox(
      height: 200.h,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.sp16("An Error occured").w400,
          10.verticalSpace,
          IconButton(
            onPressed: reload,
            icon: const Icon(Icons.replay_outlined),
          ),
          5.verticalSpace,
          AppText.sp14("Reload"),
        ],
      ),
    );
  }

  Widget listLoaderWidget() {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Container(
            width: double.maxFinite,
            height: 68.h,
            color: AppColor.shimmerBase,
          );
        },
        separatorBuilder: (context, index) => 20.verticalSpace,
        itemCount: 5,
      ),
    );
  }
}
