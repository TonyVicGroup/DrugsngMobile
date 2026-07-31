import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/address_type_enum.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/services/location_service.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/buttons/option_chip_tile.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/textfield/fixed_label_textfield.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/models/country_code.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/state_and_city_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_form_fields.dart';
import 'package:drugs_ng/features/checkout/presentation/widgets/address_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class AddEditAddressPage extends StatefulWidget {
  final UserAddress? address;

  const AddEditAddressPage({super.key, this.address});

  @override
  State<AddEditAddressPage> createState() => _AddEditAddressPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return AddEditAddressPage(address: settings.arguments as UserAddress?);
      },
    );
  }
}

class _AddEditAddressPageState extends State<AddEditAddressPage> {
  late AddressTypeEnum addressType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final bool isEdit;
  late TextEditingController nameCntrl;
  late TextEditingController phoneCntrl;
  late TextEditingController emailCntrl;
  late TextEditingController addressCntrl;
  int? cityId;
  int? countryId;
  int? stateId;
  String? countryCode;
  //
  double? latitude;
  double? longitude;

  MapController? _mapController;
  LatLng? _selectedLocation;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    isEdit = widget.address != null;
    context.read<StateAndCityCubit>().resetData();
    context.read<StateAndCityCubit>().getCountries();
    final userData = context.read<AuthCubit>().state.user;
    addressType = widget.address?.addressType ?? AddressTypeEnum.home;
    nameCntrl = TextEditingController(text: userData?.fullName);
    phoneCntrl = TextEditingController(text: ''); // userData?.phoneNumber);
    emailCntrl = TextEditingController(text: userData?.email);
    addressCntrl = TextEditingController(text: widget.address?.address);
    cityId = widget.address?.localGovernmentId;
    countryId = widget.address?.countryId;
    stateId = widget.address?.stateId;

    if (latitude != null && longitude != null) {
      _selectedLocation = LatLng(latitude!, longitude!);
    }

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
    _mapController?.dispose();
    nameCntrl.dispose();
    phoneCntrl.dispose();
    emailCntrl.dispose();
    addressCntrl.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });
    try {
      final latLng = await LocationService.getCurrentLatLng();
      final point = LatLng(latLng.latitude, latLng.longitude);
      setState(() {
        _selectedLocation = point;
        latitude = point.latitude;
        longitude = point.longitude;
      });
      _mapController?.move(point, 15.0);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: widget.address != null ? "Edit Address" : "Add Address",
      ),

      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (contex, state) {
          if (state.addEditStatus.isFailed) {
            AppToast.warn(
              context,
              title: 'Error',
              msg: state.error?.message ?? 'An error occured',
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                20.verticalSpace,
                Container(
                  height: 312.h,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColor.colorFFFFFF,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Stack(
                      children: [
                        FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter:
                                _selectedLocation ??
                                const LatLng(6.5244, 3.3792),
                            initialZoom: 13.0,
                            onTap: (tapPosition, point) {
                              setState(() {
                                _selectedLocation = point;
                                latitude = point.latitude;
                                longitude = point.longitude;
                              });
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.drugsng.mobile',
                            ),
                            if (_selectedLocation != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: _selectedLocation!,
                                    width: 40.r,
                                    height: 40.r,
                                    child: Icon(
                                      Icons.location_on,
                                      color: AppColor.red,
                                      size: 36.r,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        Positioned(
                          top: 12.h,
                          right: 12.w,
                          child: Material(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(30.r),
                            elevation: 2,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30.r),
                              onTap:
                                  _isLoadingLocation
                                      ? null
                                      : _getCurrentLocation,
                              child: Padding(
                                padding: EdgeInsets.all(8.r),
                                child:
                                    _isLoadingLocation
                                        ? SizedBox(
                                          width: 20.r,
                                          height: 20.r,
                                          child:
                                              const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                        )
                                        : Icon(
                                          Icons.my_location,
                                          color: AppColor.primary,
                                          size: 20.r,
                                        ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12.h,
                          left: 12.w,
                          right: 12.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: AppColor.shadow,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  size: 18.r,
                                  color: AppColor.primary,
                                ),
                                8.horizontalSpace,
                                Expanded(
                                  child: Text(
                                    _selectedLocation != null
                                        ? "Lat: ${_selectedLocation!.latitude.toStringAsFixed(5)}, Long: ${_selectedLocation!.longitude.toStringAsFixed(5)}"
                                        : "Tap on map to pick location",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.text,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.colorFFFFFF,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                            FixedLabelTextfield(
                              labelText: "Address",
                              controller: addressCntrl,
                              validator:
                                  () =>
                                      addressCntrl.text.isEmpty
                                          ? "Enter a valid address"
                                          : null,
                            ),
                            25.verticalSpace,
                            AppText.sp14(
                              "Label as",
                            ).w400.setColor(AppColor.color333333),
                            10.verticalSpace,
                            SizedBox(
                              height: 40.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  AddressTypeEnum aType =
                                      AddressTypeEnum.all[index];
                                  return OptionChipTile(
                                    text: aType.displayName,
                                    selected: addressType == aType,
                                    onTap: () {
                                      setState(() {
                                        addressType = aType;
                                      });
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => 15.horizontalSpace,
                                itemCount: AddressTypeEnum.values.length,
                              ),
                            ),
                            20.verticalSpace,

                            AppGradientButton(
                              text: 'Save Address',
                              onTap: saveAddress,
                              status:
                                  state.addEditStatus.isLoading
                                      ? ButtonStatus.loading
                                      : ButtonStatus.active,
                            ),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                40.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }

  void saveAddress() async {
    if (_formKey.currentState?.validate() ?? false) {
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
      // ignore: use_build_context_synchronously
      if (context.read<AddressCubit>().state.status.isFailed) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }
}
