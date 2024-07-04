class Crypto {
  final String name;
  final double price;

  Crypto({required this.name, required this.price});

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      name: json['name'],
      price: json['price_usd'] != null ? double.parse(json['price_usd']) : 0.0,
    );
  }
}
