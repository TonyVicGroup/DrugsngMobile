import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<NotificationCubit>().state.status.isInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<NotificationCubit>().getNotification();
      });
    }
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return AppButtonAnimator(
          onTap: () => _openNotification(context),
          child: Container(
            width: 37.r,
            height: 37.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.colorDBE2EA,
            ),
            child: Stack(
              children: [
                Align(
                  child: CustomImage(
                    Assets.svg.bell,
                    color: AppColor.color333333,
                    width: 19.r,
                    height: 19.r,
                  ),
                ),
                Align(
                  alignment: Alignment(0.35, -0.35),
                  child: Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.colorFF5252,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openNotification(BuildContext context) {
    context.pushNamed(AppRoutes.notificationPage);
  }
}
