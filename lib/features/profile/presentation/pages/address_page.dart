import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/generic/empty_widget.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_info_widget.dart';
import 'package:drugs_ng/features/profile/presentation/pages/add_edit_address_page.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/app_dialog.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AddressPage());
  }
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    if (context.read<AddressCubit>().state.addreses.isEmpty) {
      context.read<AddressCubit>().getAddresses();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state.status.isFailed) {
          AppToast.warn(context, title: 'Error', msg: state.error!.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBarWidget(
            title: 'Address',
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
              return !state.addreses.isEmpty
                  ? emptyAddressWidget()
                  : RefreshIndicator(
                    onRefresh: () async {
                      await context.read<AddressCubit>().getAddresses(
                        showLoader: false,
                      );
                    },
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      children: [
                        20.verticalSpace,
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: AppColor.colorFFFFFF,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  UserAddress address =
                                      UserAddress
                                          .sampleAddresses[index]; // state.addreses[index];
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
                                    (context, index) => 17.verticalSpace,
                                itemCount: 4, // state.addreses.length,
                              ),
                              40.verticalSpace,
                              AppGradientButton(
                                text: 'Add Account',
                                onTap: addAddress,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
            },
          ),
        );
      },
    );
  }

  Widget emptyAddressWidget() {
    return EmptyWidget(
      title: 'No Addresses Yet',
      subtitle:
          "You haven't added any delivery addresses. Add one to make checkout faster!",
      svg: Assets.svg.map,
      buttonText: 'Add Address',
      onTap: addAddress,
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

  void addAddress() {
    context.pushNamed(AppRoutes.addAndEditAddressPage);
  }
}
