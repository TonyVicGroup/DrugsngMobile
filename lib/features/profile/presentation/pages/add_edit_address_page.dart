import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/address_type_enum.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_text_field.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/models/country_code.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/state_and_city_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_form_fields.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEditAddressPage extends StatefulWidget {
  final UserAddress? address;

  const AddEditAddressPage({super.key, this.address});

  @override
  State<AddEditAddressPage> createState() => _AddEditAddressPageState();
}

class _AddEditAddressPageState extends State<AddEditAddressPage> {
  late AddressTypeEnum addressType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ValueNotifier<ButtonStatus> btnStatus = ValueNotifier(ButtonStatus.active);
  late final bool isEdit;
  late TextEditingController nameCntrl;
  late TextEditingController phoneCntrl;
  late TextEditingController emailCntrl;
  late TextEditingController addressCntrl;
  int? cityId;
  int? countryId;
  int? stateId;
  String? countryCode;

  // static const CameraPosition _initialPosition = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  @override
  void initState() {
    super.initState();
    isEdit = widget.address != null;
    context.read<StateAndCityCubit>().resetData();
    context.read<StateAndCityCubit>().getCountries();
    final userData = context.read<AuthCubit>().user;
    addressType = widget.address?.addressType ?? AddressTypeEnum.home;
    nameCntrl = TextEditingController(text: userData?.fullName);
    phoneCntrl = TextEditingController(text: ''); // userData?.phoneNumber);
    emailCntrl = TextEditingController(text: userData?.email);
    addressCntrl = TextEditingController(text: widget.address?.address);
    cityId = widget.address?.localGovernmentId;
    countryId = widget.address?.countryId;
    stateId = widget.address?.stateId;

    // addressState = widget.address?.state;
    // addressCity = widget.address?.city;
    countryCode = CountryCode.all.first.code;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.address != null) {
        context.read<StateAndCityCubit>().setDataFromKeys(
          countryId: widget.address?.countryId,
          stateId: widget.address?.stateId,
          localGovId: widget.address?.localGovernmentId,
        );
      }
    });
  }

  @override
  void dispose() {
    nameCntrl.dispose();
    phoneCntrl.dispose();
    emailCntrl.dispose();
    addressCntrl.dispose();
    btnStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title:
            AppText.sp18(
              widget.address != null ? "Edit Address" : "Add Address",
            ).w700.black,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: double.maxFinite,
                    //   height: 300.h,
                    //   child: const GoogleMap(
                    //     initialCameraPosition: _initialPosition,
                    //   ),
                    // ),
                    25.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddressFormFields.country(
                            id: countryId,
                            onChanged: (cntry) => countryId = cntry.id,
                          ),
                          10.verticalSpace,
                          AddressFormFields.state(
                            id: stateId,
                            onChanged: (st) => stateId = st.id,
                          ),
                          10.verticalSpace,
                          AddressFormFields.city(
                            id: cityId,
                            onChanged: (lg) => cityId = lg.id,
                          ),
                          10.verticalSpace,
                          AppTextField.whiteBorder(
                            labelText: "Address",
                            controller: addressCntrl,
                            validator:
                                () =>
                                    addressCntrl.text.isEmpty
                                        ? "Enter a valid address"
                                        : null,
                          ),
                          25.verticalSpace,
                          AppText.sp14("Label as").w400.black,
                          10.verticalSpace,
                          SizedBox(
                            height: 40.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                AddressTypeEnum aType =
                                    AddressTypeEnum.all[index];
                                return AddressLabelWidget(
                                  selected: addressType == aType,
                                  onTap: () {
                                    setState(() {
                                      addressType = aType;
                                    });
                                  },
                                  text: aType.displayName,
                                );
                              },
                              separatorBuilder:
                                  (context, index) => 15.horizontalSpace,
                              itemCount: AddressTypeEnum.values.length,
                            ),
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: BlocConsumer<AddressCubit, AddressState>(
                listener: (context, state) {
                  if (state.addEditStatus.isFailed) {
                    AppToast.warning(
                      context,
                      state.error?.message ?? 'An error occurred',
                    );
                  } else if (state.addEditStatus.isSuccess) {
                    AppToast.success(
                      context,
                      isEdit
                          ? 'Address updated successfully'
                          : 'Address added successfully',
                    );
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return AppButton.primary(
                    text: isEdit ? "UPDATE ADDRESS" : "SAVE ADDRESS",
                    onTap: saveAddress,
                    status:
                        state.addEditStatus.isLoading
                            ? ButtonStatus.loading
                            : ButtonStatus.active,
                  );
                },
              ),
            ),

            32.verticalSpace,
          ],
        ),
      ),
    );
  }

  void saveAddress() async {
    if (_formKey.currentState?.validate() ?? false) {
      btnStatus.value = ButtonStatus.loading;
      final userAddress = UserAddress(
        id: widget.address?.id ?? 0,
        label: addressType.name,
        zipCode: '',
        localGovernmentId: cityId!,
        countryId: countryId!,
        stateId: stateId!,
        address: addressCntrl.text,
      );
      if (isEdit) {
        await context.read<AddressCubit>().editAddress(userAddress);
      } else {
        await context.read<AddressCubit>().addAddress(userAddress);
      }
      btnStatus.value = ButtonStatus.active;
      // ignore: use_build_context_synchronously
      if (context.read<AddressCubit>().state.status.isFailed) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }
}
