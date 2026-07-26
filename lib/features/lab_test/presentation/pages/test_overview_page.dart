import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/lab_test/data/repository/lab_test_repository.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test_detail.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/diagnostic_list_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/diagnostic_test_info_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/lab_location_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/lab_test_specification_widget.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_detail_carousel.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_detail_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestOverviewPage extends StatefulWidget {
  final int productId;

  const TestOverviewPage({super.key, required this.productId});

  @override
  State<TestOverviewPage> createState() => _TestOverviewPageState();
}

class _TestOverviewPageState extends State<TestOverviewPage> {
  ValueNotifier<ButtonStatus> btnStatus = ValueNotifier<ButtonStatus>(
    ButtonStatus.active,
  );

  ValueNotifier<LoadStatusEnum> loadingStatus = ValueNotifier<LoadStatusEnum>(
    LoadStatusEnum.loading,
  );
  String? errorMsg;
  DiagnosticTestDetail? diagnosticTest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reload();
    });
  }

  @override
  void dispose() {
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
              width: 20.sp,
              height: 20.sp,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Test Overview").w700.black,
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: loadingStatus,
        builder: (context, status, child) {
          if (status.isLoading) {
            return const ProductDetailLoader();
          } else if (status.isSuccess) {
            DiagnosticTestDetail test = diagnosticTest!;
            return ListView(
              children: [
                ProductDetailCarousel(
                  images: test.imageUrls == null ? [] : [test.imageUrls!],
                  produtId: test.id,
                  itemType: ItemTypeEnum.test,
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.labTest,
                            width: 9.w,
                            colorFilter: const ColorFilter.mode(
                              AppColor.green,
                              BlendMode.srcIn,
                            ),
                          ),
                          8.horizontalSpace,
                          AppText.sp12(
                            "In-Lab Testing",
                          ).w400.setColor(AppColor.green),
                        ],
                      ),
                      4.verticalSpace,
                      AppText.sp16(test.name).w700.black,
                      20.verticalSpace,
                      LabTestSpecificationWidget(
                        info1: "Blood",
                        title1: "Collection",
                        info2: test.duration,
                        title2: "Duration",
                        info3: "No fasting",
                        title3: "Preparation",
                      ),
                      20.verticalSpace,
                      DiagnosticTestInformationWidget(test: test),
                      30.verticalSpace,
                      if (test.labouratories.isNotEmpty) ...[
                        AppText.sp16("Lab Location").w500.black,
                        22.verticalSpace,
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (context, index) => LabLocationWidget(
                                laboratory: test.labouratories[index],
                              ),
                          separatorBuilder: (context, index) {
                            return 10.verticalSpace;
                          },
                          itemCount: test.labouratories.length,
                        ),
                        43.verticalSpace,
                      ],
                      BlocConsumer<CartCubit, CartState>(
                        listener: (context, state) {
                          if (state is CartStateError) {
                            AppToast.warn(
                              context,
                              title: 'Error',
                              msg: state.error.message,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is CartStateInitial) {
                            context.read<CartCubit>().getCart();
                          }
                          int idx = state.cart.items.indexWhere((ct) {
                            return ct.name == test.name && ct.itemId == test.id;
                          });
                          if (idx >= 0) {
                            return AppText.sp12(
                              "${state.cart.items[idx].quantity} item added to cart",
                            ).w400.black;
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      5.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: btnStatus,
                              builder: (context, value, child) {
                                return AppButton.primary(
                                  text: "ADD TO CART",
                                  onTap: () async {
                                    await addToCart(context, test);
                                  },
                                  status: value,
                                );
                              },
                            ),
                          ),
                          21.horizontalSpace,
                          AppButton.checkout(),
                        ],
                      ),
                      40.verticalSpace,
                      AppText.sp16("Recommended Tests").w500.black,
                      22.verticalSpace,
                    ],
                  ),
                ),
                BlocBuilder<LabTestCubit, LabTestState>(
                  builder: (context, state) {
                    return DiagnosticListWidget(state: state);
                  },
                ),
                20.verticalSpace,
              ],
            );
          } else if (status.isFailed) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(),
                AppText.sp16(errorMsg ?? '').w500,
                IconButton(
                  onPressed: () => reload(showLoader: true),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            );
          }
          return Center(child: AppText.sp16(AppError.unknown.message).w500);
        },
      ),
    );
  }

  Future addToCart(BuildContext context, DiagnosticTestDetail test) async {
    btnStatus.value = ButtonStatus.loading;
    final items = context.read<CartCubit>().state.cart.items;
    bool exists =
        items.indexWhere((ct) {
          return ct.name == test.name && ct.itemId == test.id;
        }) >=
        0;

    if (exists) {
      await context.read<CartCubit>().increase(test.name, widget.productId, 1);
    } else {
      await context.read<CartCubit>().addItem(
        CartItem(
          itemId: widget.productId,
          name: test.name,
          size: "1",
          form: null,
          quantity: 1,
          amount: test.price,
          url: null,
          type: null,
        ),
      );
    }
    btnStatus.value = ButtonStatus.active;
  }

  Future reload({bool showLoader = false}) async {
    errorMsg = null;
    if (showLoader) {
      loadingStatus.value = LoadStatusEnum.loading;
    }
    final result = await LabTestRepository().getTest(widget.productId);
    if (result.isRight) {
      diagnosticTest = result.right;
      loadingStatus.value = LoadStatusEnum.success;
    } else {
      errorMsg = result.left.message;
      loadingStatus.value = LoadStatusEnum.failed;
    }
  }
}
