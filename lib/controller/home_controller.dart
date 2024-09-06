import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gate/data/network/home_network.dart';
import 'package:flutter_gate/data/service/storage_service.dart';
import 'package:flutter_gate/models/GetProductsResponse.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final storageService = StorageService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  var getProductsResponse = GetProductsResponse().obs;
  var user = Rxn<User>();

  RxString name = "".obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString photoUrl = "".obs;
  @override
  void onInit() {
    fetchHomeFeeds();
    user.value = _auth.currentUser;

    // Load user details from GetStorage
    name.value = storageService.read<String>('name') ?? '';
    email.value = storageService.read<String>('email') ?? '';
    phoneNumber.value = storageService.read<String>('number') ?? '';
    photoUrl.value = storageService.read<String>('photo') ?? '';
    super.onInit();
  }



  void fetchHomeFeeds() async {
    try {
      isLoading.value = true;
      var response = await HomeNetwork.homeFeeds();

      getProductsResponse.value = response!;
    } finally {
      isLoading.value = false;
    }
  }
}
