import 'package:flutter/material.dart';
import 'package:flutter_gate/data_base/app_database.dart';
import 'package:flutter_gate/data_base/database_client.dart';
import 'package:flutter_gate/data_base/master/AddCart.dart';
import 'package:flutter_gate/models/GetProductsResponse.dart';
import 'package:flutter_gate/ui/cart/cart_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CartController extends GetxController {
  RxList<AddCart> getCartList = <AddCart>[].obs;
  RxBool isLoading = false.obs;
  RxDouble? totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> insertMastersToDb(Dishes mRow, BuildContext context) async {
    DatabaseClient databaseClient = DatabaseClient();
    Future<AppDatabase> database = databaseClient.dbClient();
    final db = await database;

    final addCartDao = db.addCartDao;
    final cartData = AddCart(
      null,
      mRow.id!.toInt(),
      mRow.imageUrl!,
      mRow.name,
      double.parse(mRow.price!),
      mRow.currency,
      1,
    );
    final lngId = await addCartDao.insertCart(cartData);

    if (lngId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Added To Cart"),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Go to cart',
            textColor: Colors.white,
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
        ),
      );
      fetchCartItems();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  Future<void> deleteCartItem(int itemId) async {
    try {
      isLoading.value = true;
      DatabaseClient databaseClient = DatabaseClient();
      Future<AppDatabase> database = databaseClient.dbClient();
      final db = await database;

      final addCartDao = db.addCartDao;
      await addCartDao.delete(itemId);
      fetchCartItems();

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Item Removed"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCartItems() async {
    DatabaseClient databaseClient = DatabaseClient();
    Future<AppDatabase> database = databaseClient.dbClient();
    final db = await database;

    final addCartDao = db.addCartDao;
    getCartList.value = await addCartDao.fetchAll();
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in getCartList) {
      total += (item.price ?? 0) * (item.quantity ?? 0);
    }
    totalAmount!.value = total;
  }

  Future<void> clearCart(BuildContext context) async {
    try {
      DatabaseClient databaseClient = DatabaseClient();
      Future<AppDatabase> database = databaseClient.dbClient();
      final db = await database;

      final addCartDao = db.addCartDao;

      int? rowsDeletedFromCart = await addCartDao.deleteAll();

      if (rowsDeletedFromCart == null || rowsDeletedFromCart == 0) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Cart cleared successfully. $rowsDeletedFromCart items removed.")),
        );
      }

      fetchCartItems();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error clearing cart: $e")),
      );
    }
  }
}
