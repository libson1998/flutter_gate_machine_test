import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/auth_controller.dart';
import 'package:flutter_gate/controller/home_controller.dart';
import 'package:flutter_gate/drawer/home_drawer.dart';
import 'package:flutter_gate/ui/home/home_appbar.dart';
import 'package:flutter_gate/ui/home/item/item_view.dart';
import 'package:flutter_gate/ui/home/list_view_widget.dart';
import 'package:flutter_gate/widgets/form_widget.dart';
import 'package:flutter_gate/widgets/gridview_widget.dart';
import 'package:flutter_gate/widgets/item_caution.dart';
import 'package:flutter_gate/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {
    Get.lazyPut(() => AuthController());
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final homeController = Get.put(HomeController());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: _buildDrawer(context, authController),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
          child: Obx(() {
            return authController.user.value != null
                ? homeController.isLoading.value
                    ? const Center(
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                    )
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          HomeAppBar(
                                            onTap: () {
                                              _scaffoldKey.currentState
                                                  ?.openDrawer();
                                              _scaffoldKey.currentState
                                                  ?.openDrawer();
                                            },
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: FormFieldWidget(
                                              passwordObscure: false,
                                              isIconVisible: true,
                                              onSave: (newValue) {},
                                              onChange: (value) {},
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "This field cannot be empty";
                                                } else if (value.length > 9) {
                                                  return "Please enter valid mobile number";
                                                }
                                                return null;
                                              },
                                              hintText:
                                                  "Search on Dana plaza...",
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffCFCFCF),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              errorBorder: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              iconColor: Colors.black,
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: SvgPicture.asset(
                                                    "assets/icons/search.svg"),
                                              ),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff7A7979),
                                                  fontWeight: FontWeight.w500),
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                    "assets/icons/Microphone.svg"),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                  homeController.getProductsResponse.value
                                                  .categories !=
                                              null &&
                                          homeController.getProductsResponse
                                              .value.categories!.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: ListViewWidget(
                                            itemCount: homeController
                                                    .getProductsResponse
                                                    .value
                                                    .categories
                                                    ?.length ??
                                                0,
                                            scrollPhysics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            // Ensures ListView takes minimal space
                                            itemBuilder: (context, index) {
                                              final categories = homeController
                                                  .getProductsResponse
                                                  .value
                                                  .categories![index];
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20.0),
                                                    child: Text(
                                                      categories.name ?? "",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xff221F1F),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    // height: 200,
                                                    child: GridViewWidget(
                                                      scrollPhysics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: categories
                                                              .dishes?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final product =
                                                            categories
                                                                .dishes![index];
                                                        print(
                                                            product.toString());
                                                        return InkWell(
                                                          onTap: () {
                                                            showBottomSheet(
                                                              context: context,
                                                              builder: (context) =>
                                                                  SingleChildScrollView(
                                                                child: ItemView(
                                                                  product:
                                                                      product,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius: const BorderRadius
                                                                      .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              12),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              12)),
                                                                  child: Image
                                                                      .network(
                                                                    product
                                                                        .imageUrl!,
                                                                    errorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Image
                                                                          .network(
                                                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDcH_MxdsTsK6KMVon-Ybfa2WiT-R70ZjWw&s");
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0,
                                                                          right:
                                                                              8),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              product.name!,
                                                                              style: const TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              maxLines: 2,
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showBottomSheet(
                                                                                context: context,
                                                                                backgroundColor: Colors.transparent,
                                                                                builder: (context) => SingleChildScrollView(
                                                                                  child: ItemCaution(
                                                                                    itemName: product.name,
                                                                                    itemDescription: product.description,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              width: 16,
                                                                              height: 16,
                                                                              child: SvgPicture.asset(
                                                                                "assets/icons/detailsIcon.svg",
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      Text(
                                                                        product
                                                                            .description!,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            3,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0,
                                                                          right:
                                                                              8,
                                                                          bottom:
                                                                              8),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        " ${"${product.price!} ${product.currency!}"}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Color(0xff221F1F),
                                                                            fontWeight: FontWeight.w700),
                                                                      ),
                                                                      const Spacer(),
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                          color:
                                                                              Colors.white,
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Color(0xffEFF0F6),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                4.0,
                                                                              ),
                                                                              blurRadius: 5,
                                                                              spreadRadius: 1,
                                                                            ),
                                                                            BoxShadow(
                                                                              color: Color(0xffEFF0F6),
                                                                              offset: Offset(
                                                                                1.0,
                                                                                0.0,
                                                                              ),
                                                                              blurRadius: 1,
                                                                              spreadRadius: 0,
                                                                            ),
                                                                            //BoxShadow
                                                                            //BoxShadow
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 12,
                                                                              height: 12,
                                                                              child: SvgPicture.asset(
                                                                                'assets/icons/cart.svg',
                                                                                fit: BoxFit.cover,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 2,
                                                                            ),
                                                                            Text("ADD".tr,
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 12,
                                                                                  color: Colors.black,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      crossAxisSpacing: 12,
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 0,
                                                      childAspectRatio: 0.70,
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      : const Text("No Products Available"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                : const CircularProgressIndicator();
          }),
        ));
  }

  // Side navigation bar (Drawer)
  Drawer _buildDrawer(BuildContext context, AuthController authController) {
    return Drawer(
      child: HomeDrawer(),
    );
  }
}
