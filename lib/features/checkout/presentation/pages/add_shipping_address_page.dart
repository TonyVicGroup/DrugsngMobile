import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/address_type_enum.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/textfield/app_text_field.dart';
import 'package:drugs_ng/core/utils/app_functions.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/models/country_code.dart';
import 'package:drugs_ng/features/checkout/data/models/order_information.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/state_and_city_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/payment_page.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_form_fields.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddShippingAddressPage extends StatefulWidget {
  final UserAddress? address;

  const AddShippingAddressPage({super.key, this.address});

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  late AddressTypeEnum addressType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ValueNotifier<ButtonStatus> btnStatus = ValueNotifier(ButtonStatus.active);

  late TextEditingController nameCntrl;
  late TextEditingController phoneCntrl;
  late TextEditingController emailCntrl;
  late TextEditingController addressCntrl;
  int? stateId;
  int? countryId;
  int? cityId;
  String? countryCode;

  @override
  void initState() {
    super.initState();
    final userData = context.read<AuthCubit>().state.user;
    final phoneInfo = (userData?.phoneNumber ?? '').split(' ');

    addressType = widget.address?.addressType ?? AddressTypeEnum.home;
    nameCntrl = TextEditingController(text: userData?.fullName);

    phoneCntrl = TextEditingController(text: phoneInfo.last);
    emailCntrl = TextEditingController(text: userData?.email);
    addressCntrl = TextEditingController(text: widget.address?.address);
    countryCode =
        CountryCode.all
            .firstWhere(
              (cCode) => cCode.code == phoneInfo.first,
              orElse: () => CountryCode.all.first,
            )
            .code;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.address != null) {
        stateId = widget.address?.stateId;
        countryId = widget.address?.countryId;
        cityId = widget.address?.localGovernmentId;
        context.read<StateAndCityCubit>().setDataFromKeys(
          countryId: widget.address?.countryId,
          stateId: widget.address?.stateId,
          localGovId: widget.address?.localGovernmentId,
        );
      }
    });
  }

  @override
  void dispose() {
    nameCntrl.dispose();
    phoneCntrl.dispose();
    emailCntrl.dispose();
    addressCntrl.dispose();
    btnStatus.dispose();
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
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Add Address").w700.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      25.verticalSpace,
                      AppText.sp16("Recipient Information").w700.black,
                      25.verticalSpace,
                      AppTextField.grey(
                        enabled: true,
                        labelText: "Full Name",
                        controller: nameCntrl,
                        validator: () {
                          if (nameCntrl.text.isEmpty) {
                            return "Enter a valid name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      8.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 109.w,
                            color: const Color(0xFFEAEFF5),
                            height: 56.h,
                            child: DropdownButtonFormField(
                              icon: const SizedBox.shrink(),
                              isExpanded: true,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              value: CountryCode.all.first,
                              items:
                                  CountryCode.all
                                      .map(
                                        (cCode) => DropdownMenuItem(
                                          value: cCode,
                                          child: Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 40.w,
                                                ),
                                                child: FittedBox(
                                                  child: Text(
                                                    cCode.imageUrl,
                                                    style: TextStyle(
                                                      fontSize: 28.sp,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              AppText.sp15(
                                                cCode.code,
                                              ).w400.black,
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (code) {
                                countryCode = code?.code;
                              },
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: AppTextField.grey(
                              enabled: true,
                              labelText: "Phone Number",
                              controller: phoneCntrl,
                              keyboardType: TextInputType.number,
                              validator:
                                  () => AppValidators.phone(phoneCntrl.text),
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      AppText.sp12(
                        "For shipping related questions only.",
                      ).w400.setColor(const Color(0xFF868E96)),
                      8.verticalSpace,
                      AppTextField.grey(
                        enabled: true,
                        controller: emailCntrl,
                        labelText: "E-mail Address",
                        validator: () => AppValidators.email(emailCntrl.text),
                      ),
                      8.verticalSpace,
                      AppText.sp12(
                        "We will send your order and bill details to this address.",
                      ).w400.setColor(const Color(0xFF868E96)),
                      25.verticalSpace,
                      AppText.sp16("Shipping Address").w700.black,
                      25.verticalSpace,
                      AddressFormFields.country(
                        id: countryId,
                        onChanged: (cntry) => countryId = cntry.id,
                      ),
                      10.verticalSpace,
                      AddressFormFields.state(
                        id: stateId,
                        onChanged: (st) => stateId = st.id,
                      ),
                      10.verticalSpace,
                      AddressFormFields.city(
                        id: cityId,
                        onChanged: (lg) => cityId = lg.id,
                      ),
                      10.verticalSpace,
                      AppTextField.whiteBorder(
                        labelText: "Address",
                        controller: addressCntrl,
                        validator:
                            () =>
                                addressCntrl.text.isEmpty
                                    ? "Enter a valid address"
                                    : null,
                      ),
                      25.verticalSpace,
                      AppText.sp14("Label as").w400.black,
                      10.verticalSpace,
                      SizedBox(
                        height: 40.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            AddressTypeEnum aType = AddressTypeEnum.all[index];
                            return AddressLabelWidget(
                              selected: addressType == aType,
                              onTap: () {
                                setState(() {
                                  addressType = aType;
                                });
                              },
                              text: aType.displayName,
                            );
                          },
                          separatorBuilder:
                              (context, index) => 15.horizontalSpace,
                          itemCount: AddressTypeEnum.values.length,
                        ),
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: btnStatus,
                builder: (context, value, child) {
                  return AppButton.primary(
                    text: "PLACE ORDER",
                    onTap: placeOrder,
                    status: value,
                  );
                },
              ),
              32.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void placeOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      UserAddress address = UserAddress(
        id: 0,
        label: addressType.name,
        zipCode: '',
        stateId: stateId!,
        countryId: countryId!,
        localGovernmentId: cityId!,
        address: addressCntrl.text,
      );

      btnStatus.value = ButtonStatus.loading;
      await context.read<AddressCubit>().addAddress(address);
      // do the paystack implementation

      // ignore: use_build_context_synchronously
      final result = await context.read<CartCubit>().placeOrder(
        OrderInformation(
          fullname: nameCntrl.text,
          phoneNumber: phoneCntrl.text,
          email: emailCntrl.text,
          address: address,
          cart: context.read<CartCubit>().state.cart,
        ),
      );
      btnStatus.value = ButtonStatus.active;
      // if (result != null) {
      //   final orderInfo = context.read<CartCubit>().state.orderInformation!;
      //   // ignore: use_build_context_synchronously
      //   context.read<CartCubit>().clearCart();
      //   // ignore: use_build_context_synchronously
      //   await PaymentPage.start(context, result.link);
      //   // await Navigator.of(context)
      //   //     .push(AppUtils.transition(PaymentPage(url: result.link)))
      //   //     .then((success) {
      //   //       if (success ?? false) {
      //   //         AppFunctions.showOrderConfirmation(
      //   //           context,
      //   //           orderResponse: orderInfo,
      //   //           email: emailCntrl.text,
      //   //         );
      //   //       }
      //   //     });
      // }
    }
  }
}
