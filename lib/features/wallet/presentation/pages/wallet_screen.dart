import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/wallet/presentation/widgets/wallet_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            12.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Row(
                children: [
                  Expanded(
                    child: AppText.sp20(
                      'Wallet',
                    ).w700.setColor(const Color(0xFF212B36)),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            const WalletListWidget(),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: AppButton.primary(text: 'Withdraw funds', onTap: () {}),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
