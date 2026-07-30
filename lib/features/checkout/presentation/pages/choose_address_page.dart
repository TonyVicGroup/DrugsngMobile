import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_functions.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/models/order_information.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/add_shipping_address_page.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/payment_page.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseAddressPage extends StatefulWidget {
  const ChooseAddressPage({super.key});

  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {
  ValueNotifier<ButtonStatus> btnStatus = ValueNotifier(ButtonStatus.disabled);
  UserAddress? selected;

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
        title: AppText.sp16("Choose an Address").w700.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                return ListView.separated(
                  padding: EdgeInsets.only(top: 24.h),
                  itemBuilder: (context, index) {
                    UserAddress address = state.addreses[index];
                    return addressTile(address.id == selected?.id, address, () {
                      Navigator.push(
                        context,
                        AppUtils.transition(
                          AddShippingAddressPage(address: address),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (context, index) => 28.verticalSpace,
                  itemCount: state.addreses.length,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ValueListenableBuilder(
              valueListenable: btnStatus,
              builder: (context, value, child) {
                return AppButton.primary(
                  text: "PLACE ORDER",
                  onTap: placeOrder,
                  status: value,
                );
              },
            ),
          ),
          32.verticalSpace,
        ],
      ),
    );
  }

  Widget addressTile(
    bool selected,
    UserAddress address,
    void Function() onEdit,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 16.w),
      child: GestureDetector(
        onTap: () {
          this.selected = address;
          btnStatus.value = ButtonStatus.active;
          setState(() {});
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28.r,
              height: 28.r,
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: selected ? AppColor.primary : AppColor.darkGrey,
                ),
              ),
              child:
                  selected
                      ? Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primary,
                        ),
                      )
                      : null,
            ),
            Expanded(
              child: AddressInfoWidget(
                svg: address.addressType.icon,
                title: address.addressType.displayName,
                address: address.address,
                cityAndState: '${address.city ?? ''} ${address.state ?? ''}',
                onEdit: () {
                  Navigator.push(
                    context,
                    AppUtils.transition(
                      AddShippingAddressPage(address: address),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future placeOrder() async {
    if (selected != null) {
      btnStatus.value = ButtonStatus.loading;
      final userData = context.read<AuthCubit>().state.user;
      final result = await context.read<CartCubit>().placeOrder(
        OrderInformation(
          fullname: userData?.fullName ?? '',
          phoneNumber: '', // userData?.phoneNumber ?? '',
          email: userData?.email ?? '',
          address: selected!,
          cart: context.read<CartCubit>().state.cart,
        ),
      );
      btnStatus.value = ButtonStatus.active;
      // if (result != null) {
      //   final orderInfo = context.read<CartCubit>().state.orderInformation!;
      //   // ignore: use_build_context_synchronously
      //   context.read<CartCubit>().clearCart();
      //   // ignore: use_build_context_synchronously
      //   PaymentPage.start(context, result.link);
      //   // await Navigator.of(context)
      //   //     .push<bool>(AppUtils.transition(PaymentPage(url: result.link)))
      //   //     .then((result) {
      //   //       if (result ?? false) {
      //   //         AppFunctions.showOrderConfirmation(
      //   //           context,
      //   //           orderResponse: orderInfo,
      //   //           email: userData?.email ?? '',
      //   //         );
      //   //       } else {
      //   //         // failed page
      //   //       }
      //   //     });
      // }
    }
  }
}
