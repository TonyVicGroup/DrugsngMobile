import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<CartCubit>().state.getCartStatus.isInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CartCubit>().getCart();
      });
    }
    //
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return AppButtonAnimator(
          onTap: () => _openCart(context),
          child: Container(
            width: 37.r,
            height: 37.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.colorDBE2EA,
            ),
            child: CustomImage(
              Assets.svg.shoppingCart,
              color: AppColor.color333333,
              width: 19.r,
              height: 19.r,
            ),
          ),
        );
      },
    );
  }

  void _openCart(BuildContext context) {
    context.pushNamed(AppRoutes.cartPage);
  }
}
