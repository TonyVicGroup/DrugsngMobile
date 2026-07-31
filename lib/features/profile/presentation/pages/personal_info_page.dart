// import 'package:collection_ext/collection_ext.dart';
import 'package:collection/collection.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/gender_enum.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/textfield/app_text_field.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/core/widgets/textfield/fixed_label_textfield.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/data/models/country_code.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/profile_update_cubit.dart';
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
                          child: FixedLabelTextfield(
                            options: CountryCode.all,
                            labelText: "Code",
                            onChanged: (code) {
                              countryCode = code;
                            },
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
                    AppTextField.greyDropdown<GenderEnum>(
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
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
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
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AppButton.primary(
                status:
                    state.status.isLoading
                        ? ButtonStatus.loading
                        : ButtonStatus.active,
                text: "Save changes",
                onTap: _saveChanges,
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox profileAvatar() {
    return SizedBox(
      width: 116.r,
      height: 116.r,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(33.r),
                color: const Color(0xFFEAEFF5),
                // image: const DecorationImage(
                //   image: AssetImage(AppImage.testAvatar),
                // ),
              ),
              child:
                  AppText.sp41(
                    context.read<AuthCubit>().state.user?.avatar ?? '',
                  ).w700.primaryColor,
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Container(
          //     width: 30.r,
          //     height: 30.r,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(color: AppColor.white),
          //       color: const Color(0xFFEAEFF5),
          //     ),
          //     child: SvgPicture.asset(
          //       AppSvg.camera,
          //       width: 16.r,
          //       height: 16.r,
          //       colorFilter: const ColorFilter.mode(
          //         AppColor.primary,
          //         BlendMode.srcIn,
          //       ),
          //     ),
          //   ),
          // ),
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
