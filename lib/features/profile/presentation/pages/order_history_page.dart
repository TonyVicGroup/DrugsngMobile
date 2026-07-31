import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_multiple_tab_widget.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/generic/empty_widget.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/core/widgets/tab_title_widget.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/navigation/presentation/cubit/tab_navigation_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_history_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/order_history_tile.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const OrderHistoryPage());
  }
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
      listener: (context, state) {
        if (state.inProgressStatus.isFailed) {
          AppToast.warn(
            context,
            title: 'Error',
            msg: state.inProgressError?.message ?? "",
          );
        }
        if (state.settledStatus.isFailed) {
          AppToast.warn(
            context,
            title: 'Error',
            msg: state.settledError?.message ?? "",
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBarWidget(title: 'Order History'),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              20.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.colorFFFFFF,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    20.verticalSpace,
                    SizedBox(
                      width: 260.w,
                      child: AppMultipleTabWidget(
                        tabs: OrderHistoryStatus.values,
                        selectedTab: state.tabStatus,
                        onTabSelected: (v) {
                          context.read<OrderHistoryCubit>().changeTab(v);
                        },
                      ),
                    ),
                    31.verticalSpace,
                    AnimatedCrossFade(
                      firstChild: inProgress(),
                      secondChild: settled(),
                      crossFadeState:
                          state.tabStatus.isInProgress
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                      duration: AppUtils.kPageTransitionDuration,
                    ),
                  ],
                ),
              ),
              // Flexible(
              //   child: AnimatedContainer(
              //     duration: AppUtils.kPageTransitionDuration,
              //     child: AnimatedCrossFade(
              //       firstChild: inProgress(),
              //       secondChild: settled(),
              //       crossFadeState:
              //           state.tabStatus.isInProgress
              //               ? CrossFadeState.showFirst
              //               : CrossFadeState.showSecond,
              //       duration: AppUtils.kPageTransitionDuration,
              //     ),
              //   ),
              // ),
            ],
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
    return EmptyWidget.shrinked(
      title: "No Order History",
      subtitle: message,
      svg: Assets.svg.orderHistory,
      buttonText: "Place and Order",
      onTap: _goToHome,
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

  void _goToHome() {
    context.pop();
    context.read<TabNavigationCubit>().setTab(0);
    AppUtils.tabController?.animateTo(0);
  }
}
