class SupplierModel {
  final String name;
  final String contact;
  final String city;
  final String district;
  final String state;
  final int pincode;
  final List<String> products;
  String? id;

  SupplierModel({
    required this.name,
    required this.contact,
    required this.city,
    required this.district,
    required this.state,
    required this.pincode,
    this.products = const [],
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'city': city,
      'district': district,
      'state': state,
      'pincode': pincode,
      'products': products,
      'id': id,
    };
  }

  static SupplierModel fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
      city: map['city'] ?? '',
      district: map['district'] ?? '',
      state: map['state'] ?? '',
      pincode: map['pincode'] ?? 0,
      products: List<String>.from(map['products'] ?? []),
      id: map['id'],
    );
  }
}
