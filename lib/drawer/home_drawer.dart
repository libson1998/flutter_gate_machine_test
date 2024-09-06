import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/auth_controller.dart';
import 'package:flutter_gate/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final AuthController authController = Get.put(AuthController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: InkWell(
        onTap: () {
          authController.signOut();
        },
        child: Container(
          height: 50,
          color: Colors.red.withOpacity(0.2),
          child: const Center(
              child: Text(
            "LOG OUT",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
          )),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hi,${homeController.name.toUpperCase()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: homeController.photoUrl.isEmpty
                                  ? Image.asset("assets/images/profile.png")
                                  : CachedNetworkImage(
                                      imageUrl:
                                          homeController.photoUrl.toString())),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          homeController.name.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Handle long names gracefully
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        "E-mail: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          homeController.email.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
