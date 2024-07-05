import 'package:dotted_border/dotted_border.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/tab_title_widget.dart';
import 'package:drugs_ng/src/features/prescription/presentation/widgets/recent_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrescriptionOrderPage extends StatefulWidget {
  const PrescriptionOrderPage({super.key});

  @override
  State<PrescriptionOrderPage> createState() => _PrescriptionOrderPageState();
}

class _PrescriptionOrderPageState extends State<PrescriptionOrderPage> {
  bool newUpload = true;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
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
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Order with Prescription").w700.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          30.verticalSpace,
          Container(
            height: 241.h,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.04),
                    blurRadius: 48,
                    offset: const Offset(0, 0),
                  )
                ]),
            child: Column(
              children: [
                Container(
                  height: 78.h,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                    color: AppColor.white,
                  ),
                  child: TabTitleWidget(
                    title1: "New Upload",
                    title2: "Recent",
                    overallWidth: 215.w,
                    width1: 118.w,
                    width2: 86.w,
                    isTab1: newUpload,
                    onChanged: (v) {
                      controller.animateToPage(v ? 0 : 1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                      setState(() {
                        newUpload = v;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24.r),
                      ),
                      color: const Color(0xFFF9F9F9),
                    ),
                    child: PageView(
                      controller: controller,
                      children: [
                        newUploadWidget(),
                        recentUploads(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView recentUploads() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return RecentUploadWidget(
            isPdf: false, title: "title", time: DateTime.now(), size: "size");
      },
      itemCount: 2,
    );
  }

  DottedBorder newUploadWidget() {
    return DottedBorder(
      color: const Color(0xFFE5E5E5),
      borderType: BorderType.RRect,
      radius: Radius.circular(24.r),
      dashPattern: const [10, 5],
      child: SizedBox(
        width: 304.w,
        height: 109.w,
        child: Center(
          child: AppText.sp16("Click to browse or\n drag and drop your files")
              .w400
              .setColor(const Color(0xFFE5E5E5))
              .centerText,
        ),
      ),
    );
  }
}
