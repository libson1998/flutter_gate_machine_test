import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/cart_controller.dart';
import 'package:flutter_gate/ui/cart/screen_payment_success.dart';
import 'package:flutter_gate/ui/home/list_view_widget.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          bottomSheet: cartController.getCartList.isNotEmpty
              ? Material(
                  elevation: 8,
                  child: Container(
                    color: Colors.white,
                    height: 140,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total: ",style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 14),),
                                Text(
                                  " ${"${cartController.totalAmount!.value.toStringAsFixed(2)} INR"}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(PaymentSuccessScreen());

                            },
                            child: Container(
                              height: 45,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:   const Center(
                                  child: Text(
                                   "Purchase",
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 14,
                                       fontWeight: FontWeight.bold),
                                                                    )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Row(
              children: [
                const Text(
                  "My Cart",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Colors.black),
                ),
                Text(
                  " (${cartController.getCartList.length})",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ],
            ),
            titleSpacing: 0,
          ),
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: cartController.getCartList!.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ListViewWidget(
                                scrollPhysics:
                                    const NeverScrollableScrollPhysics(),
                                itemCount:
                                    cartController.getCartList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final cartData =
                                      cartController.getCartList![index];
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Image.network(
                                                  cartData.image!,
                                                  fit: BoxFit.cover,
                                                  // Ensures the image covers the available space
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.network(
                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDcH_MxdsTsK6KMVon-Ybfa2WiT-R70ZjWw&s",
                                                        fit: BoxFit
                                                            .cover // Ensures the fallback image also clips properly
                                                        );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                // height: 60,
                                                width: double.maxFinite,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 210,
                                                      child: Text(
                                                        cartData.productName ??
                                                            "",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Qty: 1",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "${cartData.price ?? ""} ${cartData.currency ?? ""}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Center(
                                                child: IconButton(
                                                    onPressed: () {
                                                      cartController.deleteCartItem(cartData.cartId!);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    )))
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        indent: 2,
                                        endIndent: 16,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        )
                      : const Center(
                          child: Text(
                          "Cart is Empty",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )))),
        ));
  }
}
