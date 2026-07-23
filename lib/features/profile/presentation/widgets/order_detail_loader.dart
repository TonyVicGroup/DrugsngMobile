import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailLoader extends StatelessWidget {
  const OrderDetailLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: Column(
        children: [
          Container(height: 100, width: double.maxFinite, color: Colors.white),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header Shimmer
                  Container(height: 20, width: 120, color: Colors.grey[300]),

                  const SizedBox(height: 12),

                  // Order Items Shimmer
                  ...List.generate(
                    2,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 16,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 14,
                                  width: 150,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 14,
                                  width: 60,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 16,
                            width: 80,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Delivery Information Shimmer
                  Container(height: 20, width: 180, color: Colors.grey[300]),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: index < 4 ? 12 : 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 14,
                                width: 80,
                                color: Colors.grey[300],
                              ),
                              Container(
                                height: 14,
                                width: 150,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Payment Details Shimmer
                  Container(height: 20, width: 140, color: Colors.grey[300]),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ...List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 14,
                                  width: 120,
                                  color: Colors.grey[300],
                                ),
                                Container(
                                  height: 14,
                                  width: 80,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 16,
                              width: 100,
                              color: Colors.grey[300],
                            ),
                            Container(
                              height: 18,
                              width: 120,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
