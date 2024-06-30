import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/utils/app_validators.dart';
import 'package:drugs_ng/src/features/auth/presentation/widgets/gender_select_widget.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  TextEditingController firstNameCntrl = TextEditingController();
  TextEditingController lastNameCntrl = TextEditingController();
  TextEditingController birthdayCntrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool gender = true;

  @override
  void dispose() {
    firstNameCntrl.dispose();
    lastNameCntrl.dispose();
    birthdayCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              148.verticalSpace,
              AppText.sp30("Set up profile").w800.black,
              30.verticalSpace,
              AppText.sp14("First name").w400.black,
              6.verticalSpace,
              AppTextField.text(
                controller: firstNameCntrl,
                keyboardType: TextInputType.text,
                hint: "Your name",
                validator: AppValidators.name,
              ),
              22.verticalSpace,
              AppText.sp14("Last name").w400.black,
              6.verticalSpace,
              AppTextField.text(
                controller: lastNameCntrl,
                hint: "Your surname",
                keyboardType: TextInputType.text,
                validator: AppValidators.name,
              ),
              22.verticalSpace,
              AppText.sp14("Your birthday").w400.black,
              6.verticalSpace,
              AppTextField.text(
                controller: birthdayCntrl,
                hint: "DD/MM/YYYY",
                keyboardType: TextInputType.none,
                onTap: _pickDate,
              ),
              22.verticalSpace,
              AppText.sp14("Gender").w400.black,
              6.verticalSpace,
              Row(
                children: [
                  GenderSelectWidget(
                    selected: gender,
                    onTap: () {
                      setState(() {
                        gender = true;
                      });
                    },
                    text: "Male",
                  ),
                  15.horizontalSpace,
                  GenderSelectWidget(
                    selected: !gender,
                    onTap: () {
                      setState(() {
                        gender = false;
                      });
                    },
                    text: "Female",
                  ),
                ],
              ),
              const Spacer(),
              AppButton.primary(text: "Done", onTap: _done),
              54.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
    if (date != null) {
      setState(() {
        birthdayCntrl.text = DateFormat("dd/MM/yyyy").format(date);
      });
    }
  }

  void _done() {
    if (formKey.currentState?.validate() ?? false) {
      AppUtils.navKey.currentState?.pushAndRemoveUntil(
        PageTransition(
          type: PageTransitionType.fade,
          child: const TabOverlay(),
          duration: const Duration(milliseconds: 600),
        ),
        (route) => route.isFirst,
      );
    }
  }
}
