import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/cart_controller.dart';
import 'package:flutter_gate/ui/cart/cart_screen.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeAppBar extends StatelessWidget {
  final Function() onTap;

    HomeAppBar({super.key, required this.onTap});
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(onTap: onTap, child: const Icon(Icons.menu)),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 93,
            child: Image.asset(
              "assets/images/app_icon.png",
              width: 93,
              height: 30,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/location.svg"),
                const SizedBox(width: 10),
                const Expanded(
                    child: Text(
                  'Deliver to\nCrystal Lagoon Kochi',
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                )),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {
              Get.to(CartScreen());
            },
            child: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                Positioned(
                  left: 11,
                  top: 0,
                  child: Container(
                    width: 13,
                    height: 13,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFDA0000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child:  Obx(()=>
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              cartController.getCartList?.length.toString()??"0",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.12,
                              ),
                            ),
                          ],
                        ),)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
