class WeddingVenueDrink {
  late String id;
  late String name;
  late String amount;
  late String price;
  bool isChecked = false;
  double selectedAmount = 0;

  WeddingVenueDrink({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    this.isChecked = false,
    this.selectedAmount = 0,
  });

  //convert wedding venue meal to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'price': price,
    };
  }

  //convert json to wedding venue
  WeddingVenueDrink.fromJson(Map<String, dynamic> jsonVenue) {
    id = jsonVenue['id'];
    name = jsonVenue['name'];
    amount = jsonVenue['amount'];
    price = jsonVenue['price'];
  }
}
