import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_info_widget.dart';
import 'package:drugs_ng/features/profile/presentation/pages/add_edit_address_page.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    context.read<AddressCubit>().getAddresses(refresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state.status.isFailed) {
          AppToast.warning(context, state.error!.message);
        }
      },
      builder: (context, state) {
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
            title: AppText.sp18("Addresses").w700.black,
            centerTitle: true,
            actions: [
              if (!state.status.isLoading)
                IconButton(
                  onPressed: () {
                    context.read<AddressCubit>().getAddresses();
                  },
                  icon: const Icon(Icons.refresh),
                ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state.status.isInitial || state.status.isLoading) {
                return listLoaderWidget();
              }
              //  else if (state.addreses.isEmpty) {
              //   return Center(
              //     child: AppText.sp16("You have not saved any address"),
              //   );
              // }
              return Column(
                children: [
                  Expanded(
                    child:
                        state.addreses.isEmpty
                            ? emptyAddressWidget()
                            : ListView.separated(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 20.h,
                              ),
                              itemBuilder: (context, index) {
                                UserAddress address = state.addreses[index];
                                return AddressInfoWidget(
                                  title: address.addressType.displayName,
                                  address: address.address,
                                  cityAndState:
                                      '${address.city ?? ''} ${address.state ?? ''}',
                                  svg: address.addressType.icon,
                                  onEdit: () {
                                    Navigator.push(
                                      context,
                                      AppUtils.transition(
                                        AddEditAddressPage(address: address),
                                      ),
                                    );
                                  },
                                  onDelete: () async {
                                    bool delete = await AppDialog.show(
                                      context,
                                      title: 'Delete Address',
                                      content:
                                          'Are you sure you want to delete this ${address.label} address',
                                    );
                                    if (delete) {
                                      context
                                          .read<AddressCubit>()
                                          .deleteAddress(address);
                                    }
                                  },
                                );
                              },
                              separatorBuilder:
                                  (context, index) => 28.verticalSpace,
                              itemCount: state.addreses.length,
                            ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AppButton.primary(
                      text: "Add Address",
                      onTap: () {
                        Navigator.push(
                          context,
                          AppUtils.transition(const AddEditAddressPage()),
                        );
                      },
                    ),
                  ),
                  32.verticalSpace,
                ],
              );
            },
          ),
        );
      },
    );
  }

  Column emptyAddressWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40.h),
        Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColor.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            AppSvg.location,
            width: 80.w,
            height: 80.h,
            colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
          ),
        ),
        32.verticalSpace,
        AppText.sp18("No Addresses Yet").w700.black,
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child:
              AppText.sp14(
                "You haven't added any delivery addresses. Add one to make checkout faster!",
              ).w400.darkGrey.centerText,
        ),
      ],
    );
  }

  Widget listLoaderWidget() {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemBuilder: (context, index) {
          return Container(
            width: double.maxFinite,
            height: 82.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.shimmerBase,
            ),
          );
        },
        separatorBuilder: (context, index) => 20.verticalSpace,
        itemCount: 5,
      ),
    );
  }
}
