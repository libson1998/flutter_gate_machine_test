import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/cart_controller.dart';
import 'package:flutter_gate/models/GetProductsResponse.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ItemView extends StatelessWidget {
  final Dishes product;

    ItemView({super.key, required this.product});
  final homeController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                      // Ensures the image covers the available space
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDcH_MxdsTsK6KMVon-Ybfa2WiT-R70ZjWw&s",
                            fit: BoxFit
                                .cover // Ensures the fallback image also clips properly
                            );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 4, bottom: 4, right: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 210,
                              child: Text(
                                product.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      product.description!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: 8, right: 8),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                product.description.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                maxLines: 20,
                              ),
                            )
                          : const SizedBox(
                              height: 65,
                            ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                        child: Text(
                          "${product.price!} ${product.currency!}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      'assets/icons/close-circle.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                homeController.insertMastersToDb(product, context);
              },
              child: Container(
                height: 45,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Text(
                      "Add To Cart ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Quantity: 1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
