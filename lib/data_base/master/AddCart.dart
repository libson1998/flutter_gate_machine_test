import 'package:floor/floor.dart';

@Entity(tableName: 'addCart')
class AddCart {
  /*
    id
    image
    productName
    price
    qty
     */

  @PrimaryKey(autoGenerate: true)
  final int? cartId;
  late final int? productId;
  late final String? image;
  late final String? productName;
  late final double? price;
  late final String? currency;
  late final int? quantity;

  AddCart(
    this.cartId,
    this.productId,
    this.image,
    this.productName,
    this.price,
    this.currency,
    this.quantity,
  );
}
