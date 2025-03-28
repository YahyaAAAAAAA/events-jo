import 'package:events_jo/config/extensions/string_extensions.dart';

class WeddingVenueMeal {
  late String id;
  late String name;
  late int amount;
  late double price;

  //local variables
  bool isChecked = false;
  int selectedAmount = 1;
  double calculatedPrice = 1;

  WeddingVenueMeal({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    this.isChecked = false,
    this.selectedAmount = 1,
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
  WeddingVenueMeal.fromJson(Map<String, dynamic> jsonVenue) {
    id = jsonVenue['id'];
    name = jsonVenue['name'].toString().toCapitalized;
    amount = jsonVenue['amount'];
    price = jsonVenue['price'].toDouble();
  }
  WeddingVenueMeal copyWith({
    String? id,
    String? name,
    int? amount,
    double? price,
    bool? isChecked,
    int? selectedAmount,
    double? calculatedPrice,
  }) {
    return WeddingVenueMeal(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      isChecked: isChecked ?? this.isChecked,
      selectedAmount: selectedAmount ?? this.selectedAmount,
    )..calculatedPrice = calculatedPrice ?? this.calculatedPrice;
  }
}
