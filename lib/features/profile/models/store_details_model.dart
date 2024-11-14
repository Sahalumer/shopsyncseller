class StoreDetailsModel {
  final String shopName;
  final String landMark;
  final String city;
  final String district;
  final String state;
  final String pincode;
  final String contact;
  final String openIn;
  final String closeIn;
  final String shopDescription;

  StoreDetailsModel({
    required this.shopName,
    required this.landMark,
    required this.city,
    required this.district,
    required this.state,
    required this.pincode,
    required this.contact,
    required this.openIn,
    required this.closeIn,
    required this.shopDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      "shopName": shopName,
      "landMark": landMark,
      "city": city,
      "district": district,
      "state": state,
      "pincode": pincode,
      "contact": contact,
      "openIn": openIn,
      "closeIn": closeIn,
      "shopDescription": shopDescription,
    };
  }

  static StoreDetailsModel fromMap(Map<String, dynamic> map) {
    return StoreDetailsModel(
      shopName: map["shopName"] ?? '',
      landMark: map["landMark"] ?? '',
      city: map["city"] ?? '',
      district: map["district"] ?? '',
      state: map["state"] ?? '',
      pincode: map["pincode"] ?? '',
      contact: map["contact"] ?? '',
      openIn: map["openIn"] ?? '',
      closeIn: map["closeIn"] ?? '',
      shopDescription: map["shopDescription"] ?? '',
    );
  }
}
