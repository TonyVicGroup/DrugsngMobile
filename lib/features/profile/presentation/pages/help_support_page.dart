import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HelpSupportPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
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
        title: AppText.sp18("Help & Support").w700.black,
        centerTitle: true,
      ),
      // floatingActionButton: Container(
      //   width: 60.r,
      //   height: 60.r,
      //   alignment: Alignment.center,
      //   decoration: const BoxDecoration(
      //     color: Color(0xFF3047EC),
      //     shape: BoxShape.circle,
      //   ),
      //   child: SvgPicture.asset(
      //     AppSvg.message,
      //     width: 30.r,
      //     height: 30.r,
      //     colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
      //   ),
      // ),
      body: Column(
        children: [
          // Container(
          //   width: double.maxFinite,
          //   height: 255.h,
          //   padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: [Color(0xFF3C5BFF), Color(0xFF1D31B9)],
          //     ),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Image.asset(
          //         AppImage.helpSupport,
          //         width: 32.r,
          //         height: 32.r,
          //         color: AppColor.white,
          //       ),
          //       25.verticalSpace,
          //       AppText.sp31("Hi Sofiat 👋").w400.white,
          //       AppText.sp16(
          //         "Let us know if we can help you with anything \nat all.",
          //       ).w400.setColor(AppColor.white.withOpacity(0.7)),
          //     ],
          //   ),
          // ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                AppText.sp20("How can we help you?").w600.black,
                12.verticalSpace,
                AppText.sp14(
                  "Our support team is available 24/7 to assist you with any questions or concerns.",
                ).w400.setColor(Colors.grey),
                16.verticalSpace,
                // _buildSupportCard(
                //   icon: Icons.phone,
                //   title: "Call Us",
                //   subtitle: "+234 123 456 7890",
                //   onTap: () {},
                // ),
                // 12.verticalSpace,
                _buildSupportCard(
                  icon: Icons.email,
                  title: "Email Us",
                  subtitle: "support@drugs.ng",
                  onTap: _launchEmailClient,
                ),
                12.verticalSpace,
                // _buildSupportCard(
                //   icon: Icons.chat_bubble,
                //   title: "Live Chat",
                //   subtitle: "Chat with our support team",
                //   onTap: () {},
                // ),
                12.verticalSpace,
                // _buildSupportCard(
                //   icon: Icons.help_outline,
                //   title: "FAQs",
                //   subtitle: "Find answers to common questions on our website",
                //   onTap: () {},
                // ),
                24.verticalSpace,
                // AppText.sp20("Need more help?").w600.black,
                // 12.verticalSpace,
                // AppText.sp14(
                //   "Our support team is available 24/7 to assist you with any questions or concerns.",
                // ).w400.setColor(Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: AppColor.primary.withAlpha((0.08 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColor.primary, size: 24.sp),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.sp16(title).w600.black,
                  4.verticalSpace,
                  AppText.sp14(subtitle).w400.setColor(Colors.grey),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey, size: 24.sp),
          ],
        ),
      ),
    );
  }

  void _launchEmailClient() {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@drugs.ng',
      query: 'subject=Support Request&body=',
    );

    launchUrl(emailUri, mode: LaunchMode.externalApplication);
  }
}
