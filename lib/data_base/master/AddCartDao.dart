
import 'package:floor/floor.dart';
import 'package:flutter_gate/data_base/master/AddCart.dart';

@dao
abstract class AddCartDao {
  @insert
  Future<int> insertCart(AddCart addCart);

  @Query("delete From addCart where cartId=:intCartID")
  Future<int?> delete(int intCartID);

  @Query('SELECT * FROM addCart')
  Future<List<AddCart>> fetchAll();

  @Query('UPDATE addCart SET quantity = :quantity  WHERE cartId = :cartId')
  Future<int?> updateQty(int cartId, int quantity);

  @Query('UPDATE addCart SET price = :price  WHERE cartId = :cartId')
  Future<int?> updateProductPrice(int cartId, double price);

  @Query('UPDATE addCart SET totalPrice = :totalPrice  WHERE cartId = :cartId')
  Future<int?> updateTotPrice(int cartId, double totalPrice);

  @Query("delete From addCart")
  Future<int?> deleteAll();
}
