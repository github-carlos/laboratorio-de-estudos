class ItemSize {
  String name;
  double price;
  int stock;

  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }
  ItemSize({this.name, this.price, this.stock});

  bool get hasStock => stock > 0;
}