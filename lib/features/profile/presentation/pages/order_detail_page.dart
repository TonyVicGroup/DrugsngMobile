import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/num_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_detail_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/order_detail_header.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/order_detail_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailCubit, OrderDetailState>(
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
            title: AppText.sp18("Order Details").w700.black,
            centerTitle: true,
          ),
          // appBar: AppBar(title: Text('Order #${order.orderReference}')),
          body: Builder(
            builder: (context) {
              if (state.status.isLoading) {
                return OrderDetailLoader();
              } else if (state.error != null || state.orderDetail == null) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      const Spacer(),
                      AppText.sp18('An Error occured').w600,
                      10.verticalSpace,
                      AppText.sp16(state.error?.message ?? '').w500,
                      20.verticalSpace,
                      const Row(),
                      ElevatedButton(
                        onPressed: refresh,
                        child: Text('Refresh'),
                      ),

                      const Spacer(flex: 2),
                    ],
                  ),
                );
              }

              final order = state.orderDetail!;

              return Column(
                children: [
                  // Order Status Header
                  OrderDetailHeader(order: order),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // Order Items Section
                        _SectionHeader(title: 'Order Items'),
                        const SizedBox(height: 12),
                        ...order.orderItems.map(
                          (item) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF1B3B50,
                                  ).withOpacity(0.06),
                                  blurRadius: 30,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:
                                      item.imageUrl != null
                                          ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              item.imageUrl!,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (_, __, ___) => Icon(
                                                    Icons.medication,
                                                    color: Colors.grey[400],
                                                  ),
                                            ),
                                          )
                                          : Icon(
                                            Icons.medication,
                                            color: Colors.grey[400],
                                          ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.genericName,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Qty: ${item.itemQty}',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  item.price.toMoneyFormat(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Delivery Information
                        _SectionHeader(title: 'Delivery Information'),
                        const SizedBox(height: 12),
                        _InfoCard(
                          children: [
                            _InfoRow(label: 'Name', value: order.customerName),
                            _InfoRow(label: 'Phone', value: order.phoneNumber),
                            _InfoRow(label: 'Email', value: order.email),
                            _InfoRow(label: 'Address', value: order.address),
                            if (order.arrivalDate != null)
                              _InfoRow(
                                label: 'Expected Arrival',
                                value: order.arrivalDate!,
                              ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Payment Information
                        _SectionHeader(title: 'Payment Details'),
                        const SizedBox(height: 12),
                        _InfoCard(
                          children: [
                            ...order.orderItems.map(
                              (e) => Row(
                                children: [
                                  Expanded(child: Text(e.name)),
                                  10.horizontalSpace,
                                  Text('₦${e.price.toStringAsFixed(2)}'),
                                ],
                              ),
                            ),

                            if (order.paymentStatus != null)
                              _InfoRow(
                                label: 'Payment Status',
                                value: order.paymentStatus!,
                              ),
                            if (order.paymentReference != null)
                              _InfoRow(
                                label: 'Reference',
                                value: order.paymentReference!,
                              ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  order.total.toMoneyFormat(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Order Timeline
                        if (order.orderActivities.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          _SectionHeader(title: 'Order Timeline'),
                          const SizedBox(height: 12),
                          _InfoCard(
                            children: [
                              ...order.orderActivities.asMap().entries.map((
                                entry,
                              ) {
                                final activity = entry.value;
                                final isLast =
                                    entry.key ==
                                    order.orderActivities.length - 1;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: isLast ? 0 : 16,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          if (!isLast)
                                            Container(
                                              width: 2,
                                              height: 40,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).dividerColor,
                                            ),
                                        ],
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              activity.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              activity.description,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              activity.dateCreated != null
                                                  ? DateFormat.yMMMMd()
                                                      .add_jm()
                                                      .format(
                                                        activity.dateCreated!,
                                                      )
                                                  : '',
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void refresh() {
    context.read<OrderDetailCubit>().getDetail(showLoader: true);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B3B50).withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
