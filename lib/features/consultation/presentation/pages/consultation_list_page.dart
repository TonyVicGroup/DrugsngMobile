import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/enum/request_status.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/widgets/error_reload_widget.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/user_consultations_cubit.dart';
import 'package:drugs_ng/features/chat/presentation/pages/consultation_chat_page.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/consultation_tile.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/expandable_consultation_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ConsultationListPage extends StatefulWidget {
  const ConsultationListPage({super.key});

  @override
  State<ConsultationListPage> createState() => _ConsultationListPageState();
}

class _ConsultationListPageState extends State<ConsultationListPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    context.read<UserConsultationsCubit>().getConsultations();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.sp20("Consultation").setColor(const Color(0xFF212B36)),
            4.verticalSpace,
            AppText.sp14(
              "You can see your consultations here",
            ).setColor(const Color(0xFF6D6D6D)),
          ],
        ),
        bottom: TabBar(
          indicatorWeight: 2.r,
          indicatorColor: AppColor.primary,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: controller,
          dividerColor: Colors.transparent,
          onTap: (index) {
            context.read<UserConsultationsCubit>().changeTab(index);
          },
          tabs: const [
            Tab(text: "Not Started"),
            Tab(text: "Ongoing"),
            Tab(text: "History"),
          ],
        ),
      ),
      body: BlocConsumer<UserConsultationsCubit, UserConsultationsState>(
        listenWhen: (prevSate, currState) {
          return AppUtils.isOnScreen(context);
        },
        listener: (context, state) {
          if (state.current.loadStatus.isFailed) {
            AppToast.warning(context, state.current.message ?? '');
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: context.read<UserConsultationsCubit>().getConsultations,
            child: TabBarView(
              controller: controller,
              children: [
                notStartedList(
                  state.pending.list,
                  state.pending.loadStatus,
                  state.pending.message,
                ),
                ongoingList(
                  state.ongoing.list,
                  state.ongoing.loadStatus,
                  state.ongoing.message,
                ),
                ongoingList(
                  state.completed.list,
                  state.completed.loadStatus,
                  state.completed.message,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ongoingList(
    List<ConsultationDetails> list,
    LoadStatusEnum status,
    String? message,
  ) {
    if (status.isLoading) {
      return loadingConsultation();
    } else if (status.isFailed) {
      return errorConsultation(message);
    } else if (list.isEmpty) {
      return emptyConsultation();
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemBuilder: (context, index) {
        final consultation = list[index];
        return ConsultationTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ConsultationChatPage(consultation: consultation);
                },
              ),
            );
          },
          consultation: consultation,
        );
      },
      separatorBuilder: (context, index) => 8.verticalSpace,
      itemCount: list.length,
    );
  }

  Widget notStartedList(
    List<ConsultationDetails> list,
    LoadStatusEnum status,
    String? message,
  ) {
    if (status.isLoading) {
      return loadingConsultation();
    } else if (status.isFailed) {
      return errorConsultation(message);
    } else if (list.isEmpty) {
      return emptyConsultation();
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemBuilder: (context, index) {
        return ExpandableConsultationTile(consultation: list[index]);
      },
      separatorBuilder: (context, index) => 8.verticalSpace,
      itemCount: list.length,
    );
  }

  Column errorConsultation(String? message) {
    return Column(
      children: [
        const Row(),
        const Spacer(),
        ErrorReloadWidget(
          message: message ?? '',
          onReload: () {
            context.read<UserConsultationsCubit>().getConsultations();
          },
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  Column emptyConsultation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(),
        AppText.sp16("No consultation available"),
        20.verticalSpace,
        InkWell(
          onTap: () {
            context.read<UserConsultationsCubit>().getConsultations();
          },
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.sp16("Refresh").w500,
                10.horizontalSpace,
                const Icon(Icons.refresh),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loadingConsultation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Shimmer.fromColors(
        baseColor: AppColor.shimmerBase,
        highlightColor: AppColor.shimmerHighlight,
        child: ListView.separated(
          itemBuilder:
              (context, index) => Container(
                height: 101.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.shimmerBase,
                ),
              ),
          separatorBuilder: (context, index) => 8.verticalSpace,
          itemCount: 3,
        ),
      ),
    );
  }
}
