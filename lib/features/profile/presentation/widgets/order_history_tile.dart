import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/profile/data/models/order_history.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_detail_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/pages/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class OrderHistoryTile extends StatelessWidget {
  final OrderHistory orderHistory;
  const OrderHistoryTile({super.key, required this.orderHistory});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => OrderDetailCubit(orderHistory.id),
                child: OrderDetailPage(),
              );
            },
          ),
        );
      },
      child: Container(
        height: 68.h,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5))),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: AppColor.green.withOpacity(0.1),
                  color: orderHistory.status.backgroundColor,
                  border: Border.all(color: orderHistory.status.borderColor),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: SvgPicture.asset(
                  orderHistory.status.icon,
                  width: 21.r,
                  height: 21.r,
                  colorFilter: ColorFilter.mode(
                    orderHistory.status.color,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            11.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.sp16(orderHistory.orderReference).w600,
                  AppText.sp14(
                    DateFormat(
                      'dd/MM/yyyy hh:mm',
                    ).format(DateTime.parse(orderHistory.date)),
                  ).w400.setColor(const Color(0xFF8B96A5)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.sp16("₦${orderHistory.revenue}").w600,
                AppText.sp14(
                  orderHistory.orderReference,
                ).w500.setColor(const Color(0xFF8B96A5)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
