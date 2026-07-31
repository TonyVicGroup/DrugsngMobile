import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/generic/empty_widget.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/add_shipping_address_page.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/choose_address_page.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_item_widget.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_loader.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/cart_total_widget.dart';
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
      context.read<AddressCubit>().getAddresses(showLoader: false);
    }
    if (context.read<CartCubit>().state.getCartStatus.isInitialOrFailed) {
      context.read<CartCubit>().getCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: 'Shop Cart',
        actions: [
          AppButtonAnimator(
            onTap: () {
              context.read<CartCubit>().clearCart();
            },
            child: AppText.sp14(
              'Clear Cart',
            ).w300.setColor(AppColor.color333333),
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
            return EmptyWidget(
              title: "Your Cart Is Empty",
              subtitle:
                  "It looks like you haven't added anything to your cart"
                  " yet. Browse our products and find what you need!",
              svg: Assets.svg.shoppingCartEmpty,
              buttonText: 'Start Shopping',
              onTap: context.pop,
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              20.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColor.colorFFFFFF,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.sp16(
                      'Cart Summary',
                    ).w600.setColor(AppColor.color333333),
                    13.verticalSpace,
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartItemWidget(item: state.cart.items[index]);
                      },
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemCount: state.cart.items.length,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              CartTotalWidget(
                subTotal: state.cart.subtotal,
                deliveryFee: state.cart.deliveryFee,
                total: state.cart.total,
                onProceed: () {
                  final addresses = context.read<AddressCubit>().state.addreses;
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
          );
        },
      ),
    );
  }
}
