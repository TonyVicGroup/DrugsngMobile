import 'package:dotted_border/dotted_border.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/buttons/app_multiple_tab_widget.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/loader/app_loader_overlay.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/pages/tabs/new_upload_tab.dart';
import 'package:drugs_ng/features/prescription/presentation/pages/tabs/recent_uploads_tab.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionOrderPage extends StatefulWidget {
  const PrescriptionOrderPage({super.key});

  @override
  State<PrescriptionOrderPage> createState() => _PrescriptionOrderPageState();

  static Route<dynamic> route(RouteSettings routeSettings) {
    return MaterialPageRoute(builder: (_) => PrescriptionOrderPage());
  }
}

class _PrescriptionOrderPageState extends State<PrescriptionOrderPage> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<PrescriptionCubit>();
    controller = PageController(initialPage: cubit.state.tab.indexNumber);
    context.read<PrescriptionCubit>().getData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrescriptionCubit, PrescriptionState>(
      buildWhen: (prev, curr) => prev.tab != curr.tab,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.colorF3F5F9,
          appBar: AppBar(
            leading: AppButtonAnimator(
              onTap: context.pop,
              child: Center(
                child: CustomImage(
                  Assets.svg.chevronLeft,
                  color: AppColor.color333333,
                  width: 9.2.w,
                ),
              ),
            ),
            title: Text('Order with Prescription'),
          ),

          body: AppLoaderOverlay(
            isLoading: state.uploadStatus.isLoading,
            child: Column(
              children: [
                20.verticalSpace,
                SizedBox(
                  width: 302.w,
                  child: AppMultipleTabWidget(
                    tabs: PrescriptionTabEnum.values,
                    selectedTab: state.tab,
                    onTabSelected: (tab) {
                      context.read<PrescriptionCubit>().changeTab(tab);
                      controller.animateToPage(
                        tab.indexNumber,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    onPageChanged: (value) {
                      context.read<PrescriptionCubit>().changeTab(
                        PrescriptionTabEnum.fromIndex(value),
                      );
                    },
                    children: [NewUploadTab(), RecentUploadsTab()],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
