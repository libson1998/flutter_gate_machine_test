import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProductCardWidget extends StatelessWidget {
  final String productTitle;
  final String price;
  final String discountPrice;
  final String imageUrl;
  final Function() onPress;

  const ProductCardWidget({
    super.key,
    required this.productTitle,
    required this.price,
    required this.discountPrice,
    required this.imageUrl,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPress,
      child: SizedBox(
        height: screenWidth * 0.59,
        width: screenWidth * 0.42,
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFDFFFD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDcH_MxdsTsK6KMVon-Ybfa2WiT-R70ZjWw&s");
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  color: const Color(0xffF6F6F6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              productTitle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                                color: const Color(0xffA7A5A5),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: const Color(0xffA7A5A5),
                                decorationThickness: 1),
                          ),
                          const SizedBox(width: 6),
                          // Text(
                          //   discountPrice,
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.black,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
