import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/cubit/explore_search_cubit.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_list_tile.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_search_field.dart';
import 'package:drugs_ng/src/features/product/domain/models/product.dart';
import 'package:drugs_ng/src/features/product/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreSearchPage extends StatelessWidget {
  const ExploreSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExploreSearchCubit(context.read<ExploreBloc>())..init(),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black.withOpacity(0.2),
          elevation: 5,
          surfaceTintColor: AppColor.white,
          backgroundColor: AppColor.white,
          leading: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(AppSvg.chevronThick),
              ),
            ),
          ),
          title: AppText.sp18("Search").w700.black,
          centerTitle: true,
        ),
        body: BlocBuilder<ExploreSearchCubit, List<Product>>(
          builder: (context, state) {
            return Column(
              children: [
                30.verticalSpace,
                ExploreSearchField(
                  onChanged: (value) {
                    context.read<ExploreSearchCubit>().search(value ?? "");
                  },
                  onSubmitted: (value) {
                    context.read<ExploreSearchCubit>().search(value ?? "");
                  },
                ),
                20.verticalSpace,
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
                    itemBuilder: (context, index) {
                      Product product = state[index];
                      return ExploreListTile(
                        img: product.imageUrls.first,
                        // rating: product.rating,
                        // totalRating: product.ratingCount,
                        genericName: product.genericName,
                        name: product.name,
                        price: product.price,
                        // prevPrice: product.prevPrice,
                        // percentReduction: product.discountPercent,
                        onTap: () => openProduct(context, product),
                      );
                    },
                    separatorBuilder: (context, index) => 25.verticalSpace,
                    itemCount: state.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void openProduct(BuildContext context, Product product) {
    Navigator.push(
      context,
      AppUtils.transition(ProductDetailPage(product: product)),
    );
  }
}
