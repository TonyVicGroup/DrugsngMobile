import 'package:collection/collection.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/features/checkout/data/models/state_and_city.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/state_and_city_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddressFormFields {
  static Widget country({
    required void Function(CountryModel) onChanged,
    required int? id,
  }) {
    return BlocConsumer<StateAndCityCubit, StateAndCityState>(
      listenWhen: (prev, curr) {
        return prev.countryData != curr.countryData;
      },
      listener: (context, state) {
        if (state.countryData.status.isFailed) {
          AppToast.warn(
            context,
            title: 'Error',
            msg: state.countryData.error?.message ?? '',
          );
        }
        if (state.countryData.status.isSuccess && id != null) {
          context.read<StateAndCityCubit>().setCountry(
            state.countryData.list.firstWhere((e) => e.id == id),
          );
          context.read<StateAndCityCubit>().getStates();
        }
      },
      builder: (context, state) {
        return _FieldDropdown<CountryModel>(
          value: state.country,
          label: 'Country',
          options: state.countryData.list,
          isFailed: state.countryData.status.isFailed,
          isLoading: state.countryData.status.isLoading,
          onChanged: (cntry) {
            context.read<StateAndCityCubit>().setCountry(cntry);
            context.read<StateAndCityCubit>().getStates();
            onChanged.call(cntry);
          },
          onTap:
              state.countryData.isEmpty
                  ? () {
                    context.read<StateAndCityCubit>().getCountries();
                  }
                  : null,
          validator: () => (state.country == null) ? "Choose a country" : null,
        );
      },
    );
  }

  static Widget state({
    required void Function(StateModel) onChanged,
    required int? id,
  }) {
    return BlocConsumer<StateAndCityCubit, StateAndCityState>(
      listenWhen: (prev, curr) => prev.allStates != curr.allStates,
      listener: (context, state) {
        if (state.allStates.status.isFailed) {
          AppToast.warn(
            context,
            title: 'Warning',
            msg: state.allStates.error?.message ?? '',
          );
        }
        if (state.allStates.status.isSuccess && id != null) {
          context.read<StateAndCityCubit>().setState(
            state.allStates.list.firstWhere((e) => e.id == id),
          );
          context.read<StateAndCityCubit>().getCity();
        }
      },
      builder: (context, state) {
        return _FieldDropdown<StateModel>(
          value: state.state,
          label: 'State',
          options: state.allStates.list,
          isFailed: state.allStates.status.isFailed,
          isLoading: state.allStates.status.isLoading,
          onChanged: (st) {
            context.read<StateAndCityCubit>().setState(st);
            context.read<StateAndCityCubit>().getCity();
            onChanged.call(st);
          },
          onTap:
              state.allStates.isEmpty
                  ? () {
                    // if (state.state == null) {
                    //   AppToast.warn(context, 'Please select a State');
                    //   return;
                    // }
                    context.read<StateAndCityCubit>().getStates();
                  }
                  : null,
          validator: () => (state.state == null) ? "Choose a State" : null,
        );
      },
    );
  }

  static Widget city({
    required void Function(CityModel) onChanged,
    required int? id,
  }) {
    return BlocConsumer<StateAndCityCubit, StateAndCityState>(
      listenWhen: (prev, curr) => prev.allCities != curr.allCities,
      listener: (context, state) {
        if (state.allCities.status.isFailed) {
          AppToast.warn(
            context,
            title: 'Warning',
            msg: state.allCities.error?.message ?? '',
          );
        }
        if (state.allCities.status.isSuccess && id != null) {
          context.read<StateAndCityCubit>().setCity(
            state.allCities.list.firstWhereOrNull((e) => e.id == id),
          );
        }
      },
      builder: (context, state) {
        return _FieldDropdown<CityModel>(
          value: state.city,
          label: 'City',
          options: state.allCities.list,
          isFailed: state.allCities.status.isFailed,
          isLoading: state.allCities.status.isLoading,
          onChanged: (city) {
            context.read<StateAndCityCubit>().setCity(city);
            onChanged.call(city);
          },
          onTap:
              state.allCities.isEmpty
                  ? () {
                    // if (state.city == null) {
                    //   AppToast.warn(context, 'Please select a City');
                    //   return;
                    // }
                    context.read<StateAndCityCubit>().getCity();
                  }
                  : null,
          validator: () => (state.city == null) ? "Choose a City" : null,
        );
      },
    );
  }
}

class _FieldDropdown<T> extends StatelessWidget {
  final Key? _key;

  final String label;
  final T? value;
  final bool isLoading;
  final bool isFailed;
  final List<T> options;
  final void Function(T value) onChanged;
  final String? Function()? validator;
  final void Function()? onTap;

  const _FieldDropdown({
    Key? key,
    required this.label,
    required this.options,
    required this.onChanged,
    required this.isLoading,
    required this.isFailed,
    this.validator,
    this.onTap,
    this.value,
  }) : _key = key;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator != null ? (v) => validator!() : null,
      builder: (state) {
        String? errorText = state.errorText;
        final Color borderColor =
            errorText != null ? AppColor.red : const Color(0xFFEAEFF5);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: options.isEmpty && !isLoading ? onTap : null,
              child: Container(
                height: 56.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 11.h),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                ),
                child:
                    options.isEmpty
                        ? Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.sp12(
                                label,
                              ).w400.setColor(const Color(0xFF8B96A5)),
                              Padding(
                                padding: EdgeInsets.only(right: 11.w),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child:
                                      isLoading
                                          ? const Center(
                                            child: SizedBox.square(
                                              dimension: 16,
                                              child: CircularProgressIndicator(
                                                color: AppColor.primary,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                          : (isFailed
                                              ? const Icon(
                                                Icons.refresh,
                                                color: AppColor.primary,
                                              )
                                              : const SizedBox.shrink()),
                                ),
                              ),
                            ],
                          ),
                        )
                        : Theme(
                          data: _theme(),
                          child: DropdownButtonFormField(
                            key: _key,
                            value: value,
                            // onTap: onTap,
                            decoration: InputDecoration(
                              labelText: label,
                              border: InputBorder.none,
                            ),
                            dropdownColor: AppColor.white,
                            icon: Padding(
                              padding: EdgeInsets.only(right: 11.h),
                              child: SvgPicture.asset(
                                AppSvg.chevronLight,
                                width: 15.w,
                                colorFilter: const ColorFilter.mode(
                                  AppColor.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            items:
                                options
                                    .map(
                                      (e) => DropdownMenuItem<T>(
                                        value: e,
                                        child: AppText.sp16(e.toString()),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (item) {
                              if (item != null) {
                                onChanged(item);
                              }
                            },
                          ),
                        ),
              ),
            ),
            if (errorText != null)
              AppText.sp12(errorText).w400.setColor(AppColor.red),
          ],
        );
      },
    );
  }

  ThemeData _theme() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(maxHeight: 33.h),
        contentPadding: EdgeInsets.only(left: 20.w),
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF8B96A5),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColor.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColor.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColor.white),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColor.white),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColor.white),
        ),
      ),
    );
  }
}
