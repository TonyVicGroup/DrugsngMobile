import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/consultation/data/models/consult_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceListTile extends StatelessWidget {
  final void Function() onTap;
  const ServiceListTile({
    super.key,
    required this.service,
    required this.onTap,
  });

  final ConsultService service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEAEFF5),
            ),
            child: CustomImage(service.imageUrl, width: 20.r, height: 20.r),
          ),
          const Spacer(),
          AppText.sp12(service.name).w400.setColor(const Color(0xFF8B96A5)),
        ],
      ),
    );
  }
}
