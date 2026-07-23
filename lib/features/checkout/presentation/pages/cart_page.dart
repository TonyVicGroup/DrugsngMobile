import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/add_shipping_address_page.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/choose_address_page.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_item_widget.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_loader.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_total_widget.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    if (context.read<AddressCubit>().state.status.isInitial) {
      context.read<AddressCubit>().getAddresses(refresh: true);
    }
    if (context.read<CartCubit>().state is CartStateInitial) {
      context.read<CartCubit>().getCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartCubit>().clearCart();
            },
            child: AppText.sp14('Clear Cart'),
          ),
        ],
        title: AppText.sp18("Cart").w700.black,
        centerTitle: true,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartStateError) {
            AppToast.warning(context, state.error.message);
          }
        },
        builder: (context, state) {
          if ((state is CartStateInitial) || (state is CartStateLoading)) {
            return const CartLoader();
          } else if (state.cart.items.isEmpty) {
            return const EmptyCart();
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CartItemWidget(item: state.cart.items[index]);
                    },
                    separatorBuilder: (context, index) => 10.verticalSpace,
                    itemCount: state.cart.items.length,
                  ),
                ),
                CartTotalWidget(
                  subTotal: state.cart.subtotal,
                  deliveryFee: state.cart.deliveryFee,
                  total: state.cart.total,
                  onProceed: () {
                    final addresses =
                        context.read<AddressCubit>().state.addreses;
                    Navigator.of(context).push(
                      AppUtils.transition(
                        addresses.isEmpty
                            ? const AddShippingAddressPage()
                            : const ChooseAddressPage(),
                      ),
                    );
                  },
                ),
                24.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
