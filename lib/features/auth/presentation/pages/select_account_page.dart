import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_back_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/features/auth/presentation/widgets/account_type_selection_tile.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectAccountPage extends StatelessWidget {
  const SelectAccountPage({super.key});

  static Route<dynamic> route(RouteSettings settings) => MaterialPageRoute(
    builder: (_) => const SelectAccountPage(),
    settings: settings,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorFFFFFF,
      appBar: AppBar(
        leading: Center(child: AppBackButton.grey(() => _goBack(context))),
        forceMaterialTransparency: true,
        title: AppText.sp18('Select Account'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          20.verticalSpace,
          AppText.sp24(
            "How would you like to use DrugsNG?",
          ).w700.setColor(AppColor.color333333).centerText,
          5.verticalSpace,
          AppText.sp14(
            "Select your account type to continue",
          ).w400.setColor(AppColor.color666666).centerText,
          10.verticalSpace,
          AccountTypeSelectionTile(
            isSelected: false,
            title: 'Patient',
            subtitle:
                'Book consultations, order medications, and manage your health journey',
            svg: Assets.svg.person,
            onTap: () {},
          ),
          20.verticalSpace,
          AccountTypeSelectionTile(
            isSelected: true,
            title: 'Doctor',
            subtitle:
                'Provide consultations, manage patients, and grow your practice',
            svg: Assets.svg.people,
            onTap: () {},
          ),
          40.verticalSpace,
          AppGradientButton(text: 'Continue', onTap: () {}),
          20.verticalSpace,
        ],
      ),
    );
  }

  void _goBack(BuildContext context) {
    context.pop();
  }
}
