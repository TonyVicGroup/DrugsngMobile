import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/add_shipping_address_page.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/choose_address_page.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_item_widget.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_loader.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_total_widget.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/empty_cart.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => CartPage(), settings: settings);
  }
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    if (context.read<AddressCubit>().state.status.isInitial) {
      context.read<AddressCubit>().getAddresses(refresh: true);
    }
    if (context.read<CartCubit>().state.getCartStatus.isInitialOrFailed) {
      context.read<CartCubit>().getCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: AppButtonAnimator(
          onTap: context.pop,
          child: Center(
            child: CustomImage(
              Assets.svg.chevronLeft,
              color: AppColor.color333333,
              width: 9.2.w,
            ),
          ),
        ),
        title: Text('Cart'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartCubit>().clearCart();
            },
            child: AppText.sp14('Clear Cart'),
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state.getCartStatus.isFailed) {
            AppToast.warn(
              context,
              title: 'Error',
              msg: state.error ?? 'An error occured',
            );
          }
        },
        builder: (context, state) {
          if (state.getCartStatus.isLoading) {
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
