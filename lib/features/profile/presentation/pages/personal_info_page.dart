// import 'package:collection_ext/collection_ext.dart';
import 'package:collection/collection.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/gender_enum.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/core/widgets/textfield/fixed_label_dropdown_field.dart';
import 'package:drugs_ng/core/widgets/textfield/fixed_label_textfield.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/data/models/country_code.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/profile_update_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart' show Assets;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create:
                (context) =>
                    ProfileUpdateCubit(authCubit: context.read<AuthCubit>()),
            child: const PersonalInfoPage(),
          ),
    );
  }
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late final TextEditingController firstName;
  late final TextEditingController lastName;
  late final TextEditingController phoneNumber;
  late final TextEditingController email;
  late final TextEditingController gender;
  late final TextEditingController dateOfBirth;
  DateTime? dob;
  CountryCode? countryCode;
  GenderEnum? selectedGender;

  @override
  void initState() {
    super.initState();
    final userData = (context.read<AuthCubit>().state.user)!;

    firstName = TextEditingController(text: userData.firstName);
    lastName = TextEditingController(text: userData.lastName);
    email = TextEditingController(text: userData.email);
    phoneNumber = TextEditingController(text: '');
    selectedGender = userData.gender;
    dob = userData.dob;
    dateOfBirth = TextEditingController(
      text: (dob != null) ? DateFormat('yyyy-MM-dd').format(dob!) : null,
    );
    if (userData.phoneNumber.isNotEmpty && userData.phoneNumber.contains(' ')) {
      final parts = userData.phoneNumber.split(' ');
      final code = parts[0];
      countryCode = CountryCode.all.firstWhereOrNull(
        (element) => element.code == code,
      );
      phoneNumber.text = parts.sublist(1).join(' ');
    } else {
      phoneNumber.text = userData.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: "Personal Info"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColor.colorFFFFFF,
                boxShadow: AppColor.blueShadow,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    profileAvatar(),
                    25.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: FixedLabelTextfield(
                            labelText: "First Name",
                            controller: firstName,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15.r),
                            ),
                            validator: () {
                              if (firstName.text.isEmpty) {
                                return "Enter a valid name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: FixedLabelTextfield(
                            labelText: "Last Name",
                            controller: lastName,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(15.r),
                            ),
                            validator: () {
                              if (lastName.text.isEmpty) {
                                return "Enter a valid name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: FixedLabelDropdownField(
                            options: CountryCode.all,
                            labelText: "Code",
                            onChanged: (code) {
                              countryCode = code;
                            },
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15.r),
                            ),
                            validator:
                                () => AppValidators.notNull(
                                  countryCode,
                                  "Select country code",
                                ),
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: FixedLabelTextfield(
                            labelText: "Phone Number",
                            controller: phoneNumber,
                            keyboardType: TextInputType.number,
                            validator:
                                () => AppValidators.phone(phoneNumber.text),
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(15.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    FixedLabelTextfield(
                      controller: email,
                      labelText: "E-mail Address",
                      enabled: false,
                      validator: () => AppValidators.email(email.text),
                    ),
                    20.verticalSpace,
                    FixedLabelTextfield(
                      controller: dateOfBirth,
                      labelText: "Birthday",
                      onTap: () async {
                        final dob = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1000),
                          lastDate: DateTime.now(),
                        );
                        if (dob != null) {
                          setState(() {
                            this.dob = dob;
                            dateOfBirth.text = DateFormat(
                              'yyyy-MM-dd',
                            ).format(dob);
                          });
                        }
                      },
                      validator: () {
                        if (dateOfBirth.text.isEmpty) {
                          return "Select your date of birth";
                        } else {
                          return null;
                        }
                      },
                    ),
                    20.verticalSpace,
                    FixedLabelDropdownField(
                      labelText: "Gender",
                      options: GenderEnum.all,
                      selectedValue: selectedGender,
                      onChanged: (gender) {
                        selectedGender = gender;
                      },
                      validator:
                          () => AppValidators.notNull(
                            selectedGender,
                            'Select your gender',
                          ),
                    ),
                    30.verticalSpace,
                    BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
                      listenWhen: (prev, current) {
                        return AppUtils.isOnScreen(context);
                      },
                      listener: (context, state) {
                        if (state.status.isFailed) {
                          AppToast.warn(
                            context,
                            title: 'Error',
                            msg: state.error?.message ?? '',
                          );
                        } else if (state.status.isSuccess) {
                          AppToast.success(
                            context,
                            title: 'Success',
                            msg: "Profile updated successfully",
                          );
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return AppGradientButton(
                          status:
                              state.status.isLoading
                                  ? ButtonStatus.loading
                                  : ButtonStatus.active,
                          text: "Save changes",
                          onTap: _saveChanges,
                        );
                      },
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox profileAvatar() {
    return SizedBox(
      width: 77.r,
      height: 78.r,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.colorEAEFF5,
              ),

              child:
                  AppText.sp41(
                    context.read<AuthCubit>().state.user?.avatar ?? '',
                  ).w700.primaryColor,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 20.r,
              height: 20.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.color0B8AE1,
              ),
              child: CustomImage(
                Assets.svg.cameraOutline,
                width: 11.r,
                color: AppColor.colorFFFFFF,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges() async {
    if (formKey.currentState?.validate() ?? false) {
      final userProfile = AuthUserProfile(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        phone: '${countryCode!.code} ${phoneNumber.text}',
        birthday: dob!,
        gender: selectedGender!,
      );
      context.read<ProfileUpdateCubit>().updateProfile(userProfile);
    }
  }
}
