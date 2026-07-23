import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_text_field.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/utils/app_input_formaters.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/profile/data/models/debit_card.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/card/card_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController cardHolderName = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController cvc = TextEditingController();
  final TextEditingController expireDate = TextEditingController();
  DateTime? date;
  ValueNotifier<ButtonStatus> loader = ValueNotifier(ButtonStatus.active);

  @override
  void dispose() {
    cardHolderName.dispose();
    cardNumber.dispose();
    cvc.dispose();
    expireDate.dispose();
    loader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
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
        title: AppText.sp18("Add Card").w700.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              20.verticalSpace,
              AppTextField.grey(
                labelText: "CARD HOLDER NAME",
                controller: cardHolderName,
                validator: () {
                  if (cardHolderName.text.isEmpty) {
                    return 'Enter a valid Card holder name';
                  }
                  return null;
                },
              ),
              20.verticalSpace,
              AppTextField.grey(
                labelText: "CARD NUMBER",
                controller: cardNumber,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CreditCardInputFormatter(),
                ],
                validator: () {
                  if (cardNumber.text.length < 5) {
                    return 'Enter a valid Card number';
                  }
                  return null;
                },
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppTextField.grey(
                      labelText: "EXPIRE DATE",
                      enabled: false,
                      onTap: _showDatePicker,
                      controller: expireDate,
                      validator: () {
                        if (expireDate.text.isEmpty) {
                          return 'Select an expiry date';
                        }
                        return null;
                      },
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: AppTextField.grey(
                      labelText: "CVC",
                      controller: cvc,
                      keyboardType: TextInputType.number,
                      validator: () {
                        if (int.tryParse(cvc.text) == null ||
                            cvc.text.length < 3) {
                          return 'Enter a valid Card cvc';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: loader,
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AppButton.primary(
                status: value,
                text: "Add this Card",
                onTap: addCard,
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ColoredBox(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      if (date != null) {
                        expireDate.text = DateFormat('MM/yyyy').format(date!);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ),
              SizedBox(
                height: 250.h,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.monthYear,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime(DateTime.now().year + 50),
                  onDateTimeChanged: (DateTime newDate) {
                    date = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addCard() async {
    if (formKey.currentState?.validate() ?? false) {
      final user = context.read<AuthCubit>().state.user;
      if (user == null) {
        AppToast.warning(context, 'Login session expired');
        Navigator.pushAndRemoveUntil(
          context,
          AppUtils.transition(const LoginPage()),
          (route) => route.isFirst,
        );
        return;
      }

      loader.value = ButtonStatus.loading;
      final result = await context.read<CardCubit>().addCard(
        DebitCard(
          id: 0,
          nameOnCard: cardHolderName.text,
          cardNumber: cardNumber.text,
          expiryDate: date!,
          cvc: cvc.text,
          userId: user.id,
          userFullName: user.fullName,
        ),
      );
      loader.value = ButtonStatus.active;
      if (result == null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        AppToast.warning(context, result.message);
      }
    }
  }
}
