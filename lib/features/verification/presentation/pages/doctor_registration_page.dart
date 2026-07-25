import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_back_button.dart';
import 'package:drugs_ng/features/verification/presentation/cubit/doctor_registration_cubit.dart';
import 'package:drugs_ng/features/verification/presentation/pages/tabs/bank_details_tab.dart';
import 'package:drugs_ng/features/verification/presentation/pages/tabs/face_verification_tab.dart';
import 'package:drugs_ng/features/verification/presentation/pages/tabs/id_verification_tab.dart';
import 'package:drugs_ng/features/verification/presentation/pages/tabs/medical_credentials_tab.dart';
import 'package:drugs_ng/features/verification/presentation/pages/tabs/personal_info_tab.dart';
import 'package:drugs_ng/features/verification/presentation/pages/tabs/review_application_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DoctorRegistrationPage extends StatefulWidget {
  const DoctorRegistrationPage({super.key});

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const DoctorRegistrationPage(),
      settings: settings,
    );
  }

  @override
  State<DoctorRegistrationPage> createState() => _DoctorRegistrationPageState();
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage> {
  late final PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
    context.read<DoctorRegistrationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorFFFFFF,
      appBar: AppBar(
        leading: Center(child: AppBackButton.lightArrow(_goBack)),
        forceMaterialTransparency: true,
        title: AppText.sp18('Doctor Registration'),
        actions: [
          BlocBuilder<DoctorRegistrationCubit, DoctorRegistrationState>(
            builder: (context, state) {
              return AppText.sp13(
                'Step ${state.stage + 1} of 5',
              ).w500.setColor(AppColor.color9CA3AF);
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10.w),
      ),
      body: Column(
        children: [
          SmoothPageIndicator(
            controller: controller, // PageController
            count: 6,
            effect: ExpandingDotsEffect(
              dotWidth: 8.r,
              dotHeight: 8.r,
              expansionFactor: 3,
              activeDotColor: AppColor.color0B8AE1,
              dotColor: AppColor.colorE0E0E0,
            ), // your preferred effect
          ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (int index) {
                context.read<DoctorRegistrationCubit>().changeStage(index);
              },
              children: [
                PersonalInfoTab(),
                MedicalCredentialsTab(),
                IdVerificationTab(),
                FaceVerificationTab(),
                BankDetailsTab(),
                ReviewApplicationTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goBack() {
    context.pop();
  }
}
