import 'dart:convert';
/// categories : [{"id":1,"name":"Salads and Soup","dishes":[{"id":101,"name":"Spinach Salad","price":"7.95","currency":"INR","calories":15,"description":"Fresh spinach, mushrooms, and hard-boiled egg served with warm bacon vinaigrette","addons":[{"id":1,"name":"Extra Dressing","price":"1.00"}],"image_url":"https://example.com/spinach-salad.jpg","customizations_available":true},{"id":102,"name":"Traditional New England Seafood Chowder","price":"12.00","currency":"INR","calories":30,"description":"With clams, scallops, and shrimp","addons":[],"image_url":"https://example.com/seafood-chowder.jpg","customizations_available":false}]},{"id":2,"name":"From The Barnyard","dishes":[{"id":201,"name":"Grilled Chicken Breast","price":"10.50","currency":"INR","calories":200,"description":"Grilled chicken breast with herbs and spices","addons":[{"id":2,"name":"Extra Chicken Breast","price":"5.00"}],"image_url":"https://example.com/grilled-chicken.jpg","customizations_available":true},{"id":202,"name":"BBQ Pork Ribs","price":"18.00","currency":"INR","calories":450,"description":"Smoked BBQ pork ribs with BBQ sauce","addons":[{"id":3,"name":"Extra BBQ Sauce","price":"2.00"}],"image_url":"https://example.com/bbq-pork-ribs.jpg","customizations_available":true}]},{"id":3,"name":"From the Sea","dishes":[{"id":301,"name":"Grilled Salmon","price":"20.00","currency":"INR","calories":350,"description":"Grilled salmon served with lemon butter sauce","addons":[{"id":4,"name":"Extra Lemon Butter Sauce","price":"3.00"}],"image_url":"https://example.com/grilled-salmon.jpg","customizations_available":true},{"id":302,"name":"Shrimp Scampi","price":"15.00","currency":"INR","calories":400,"description":"Shrimp cooked in garlic butter and white wine sauce","addons":[],"image_url":"https://example.com/shrimp-scampi.jpg","customizations_available":false}]},{"id":4,"name":"Desserts","dishes":[{"id":401,"name":"Chocolate Lava Cake","price":"8.00","currency":"INR","calories":300,"description":"Molten chocolate cake served with vanilla ice cream","addons":[{"id":5,"name":"Extra Ice Cream","price":"2.00"}],"image_url":"https://example.com/lava-cake.jpg","customizations_available":true},{"id":402,"name":"New York Cheesecake","price":"7.00","currency":"INR","calories":320,"description":"Classic cheesecake with a graham cracker crust","addons":[],"image_url":"https://example.com/cheesecake.jpg","customizations_available":false}]},{"id":5,"name":"Beverages","dishes":[{"id":501,"name":"Coca-Cola","price":"2.00","currency":"INR","calories":150,"description":"Chilled Coca-Cola soft drink","addons":[],"image_url":"https://example.com/coke.jpg","customizations_available":false},{"id":502,"name":"Iced Tea","price":"2.50","currency":"INR","calories":120,"description":"Freshly brewed iced tea","addons":[],"image_url":"https://example.com/iced-tea.jpg","customizations_available":false}]}]

GetProductsResponse getProductsResponseFromJson(String str) => GetProductsResponse.fromJson(json.decode(str));
String getProductsResponseToJson(GetProductsResponse data) => json.encode(data.toJson());
class GetProductsResponse {
  GetProductsResponse({
      List<Categories>? categories,}){
    _categories = categories;
}

  GetProductsResponse.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
  }
  List<Categories>? _categories;
GetProductsResponse copyWith({  List<Categories>? categories,
}) => GetProductsResponse(  categories: categories ?? _categories,
);
  List<Categories>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "Salads and Soup"
/// dishes : [{"id":101,"name":"Spinach Salad","price":"7.95","currency":"INR","calories":15,"description":"Fresh spinach, mushrooms, and hard-boiled egg served with warm bacon vinaigrette","addons":[{"id":1,"name":"Extra Dressing","price":"1.00"}],"image_url":"https://example.com/spinach-salad.jpg","customizations_available":true},{"id":102,"name":"Traditional New England Seafood Chowder","price":"12.00","currency":"INR","calories":30,"description":"With clams, scallops, and shrimp","addons":[],"image_url":"https://example.com/seafood-chowder.jpg","customizations_available":false}]

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));
String categoriesToJson(Categories data) => json.encode(data.toJson());
class Categories {
  Categories({
      num? id, 
      String? name, 
      List<Dishes>? dishes,}){
    _id = id;
    _name = name;
    _dishes = dishes;
}

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    if (json['dishes'] != null) {
      _dishes = [];
      json['dishes'].forEach((v) {
        _dishes?.add(Dishes.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  List<Dishes>? _dishes;
Categories copyWith({  num? id,
  String? name,
  List<Dishes>? dishes,
}) => Categories(  id: id ?? _id,
  name: name ?? _name,
  dishes: dishes ?? _dishes,
);
  num? get id => _id;
  String? get name => _name;
  List<Dishes>? get dishes => _dishes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_dishes != null) {
      map['dishes'] = _dishes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 101
/// name : "Spinach Salad"
/// price : "7.95"
/// currency : "INR"
/// calories : 15
/// description : "Fresh spinach, mushrooms, and hard-boiled egg served with warm bacon vinaigrette"
/// addons : [{"id":1,"name":"Extra Dressing","price":"1.00"}]
/// image_url : "https://example.com/spinach-salad.jpg"
/// customizations_available : true

Dishes dishesFromJson(String str) => Dishes.fromJson(json.decode(str));
String dishesToJson(Dishes data) => json.encode(data.toJson());
class Dishes {
  Dishes({
      num? id, 
      String? name, 
      String? price, 
      String? currency, 
      num? calories, 
      String? description, 
      List<Addons>? addons, 
      String? imageUrl, 
      bool? customizationsAvailable,}){
    _id = id;
    _name = name;
    _price = price;
    _currency = currency;
    _calories = calories;
    _description = description;
    _addons = addons;
    _imageUrl = imageUrl;
    _customizationsAvailable = customizationsAvailable;
}

  Dishes.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _currency = json['currency'];
    _calories = json['calories'];
    _description = json['description'];
    if (json['addons'] != null) {
      _addons = [];
      json['addons'].forEach((v) {
        _addons?.add(Addons.fromJson(v));
      });
    }
    _imageUrl = json['image_url'];
    _customizationsAvailable = json['customizations_available'];
  }
  num? _id;
  String? _name;
  String? _price;
  String? _currency;
  num? _calories;
  String? _description;
  List<Addons>? _addons;
  String? _imageUrl;
  bool? _customizationsAvailable;
Dishes copyWith({  num? id,
  String? name,
  String? price,
  String? currency,
  num? calories,
  String? description,
  List<Addons>? addons,
  String? imageUrl,
  bool? customizationsAvailable,
}) => Dishes(  id: id ?? _id,
  name: name ?? _name,
  price: price ?? _price,
  currency: currency ?? _currency,
  calories: calories ?? _calories,
  description: description ?? _description,
  addons: addons ?? _addons,
  imageUrl: imageUrl ?? _imageUrl,
  customizationsAvailable: customizationsAvailable ?? _customizationsAvailable,
);
  num? get id => _id;
  String? get name => _name;
  String? get price => _price;
  String? get currency => _currency;
  num? get calories => _calories;
  String? get description => _description;
  List<Addons>? get addons => _addons;
  String? get imageUrl => _imageUrl;
  bool? get customizationsAvailable => _customizationsAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['currency'] = _currency;
    map['calories'] = _calories;
    map['description'] = _description;
    if (_addons != null) {
      map['addons'] = _addons?.map((v) => v.toJson()).toList();
    }
    map['image_url'] = _imageUrl;
    map['customizations_available'] = _customizationsAvailable;
    return map;
  }

}

/// id : 1
/// name : "Extra Dressing"
/// price : "1.00"

Addons addonsFromJson(String str) => Addons.fromJson(json.decode(str));
String addonsToJson(Addons data) => json.encode(data.toJson());
class Addons {
  Addons({
      num? id, 
      String? name, 
      String? price,}){
    _id = id;
    _name = name;
    _price = price;
}

  Addons.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
  }
  num? _id;
  String? _name;
  String? _price;
Addons copyWith({  num? id,
  String? name,
  String? price,
}) => Addons(  id: id ?? _id,
  name: name ?? _name,
  price: price ?? _price,
);
  num? get id => _id;
  String? get name => _name;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    return map;
  }

}