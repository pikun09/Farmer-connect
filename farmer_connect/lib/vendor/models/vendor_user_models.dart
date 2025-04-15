class VendorUserModels {
  final bool? approved;
  final String? vendorId;
  final String? businessName;
  final String? email;
  final String? phoneNumber;
  final String? countryValue;
  final String? stateValue;
  final String? cityValue;
  final String? image;
  final String? taxNumber;
  final String? taxRegistered;

  VendorUserModels(
      {required this.approved,
      required this.vendorId,
      required this.businessName,
      required this.email,
      required this.phoneNumber,
      required this.countryValue,
      required this.stateValue,
      required this.cityValue,
      required this.image,
      required this.taxNumber,
      required this.taxRegistered});

  VendorUserModels.fromJson(Map<String, Object?> json)
      : this(
            approved: json['approved']! as bool,
            vendorId: json['vendorId']! as String,
            businessName: json['businessName']! as String,
            email: json['email']! as String,
            phoneNumber: json['phoneNumber']! as String,
            countryValue: json['countryValue']! as String,
            stateValue: json['stateValue']! as String,
            cityValue: json['cityValue']! as String,
            image: json['image']! as String,
            taxNumber: json['taxNumber']! as String,
            taxRegistered: json['taxRegistered']! as String);

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'vendorId': vendorId,
      'businessName': businessName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryValue': countryValue,
      'stateValue': stateValue,
      'cityValue': cityValue,
      'image': image,
      'taxNumber': taxNumber,
      'taxRegistered': taxRegistered,
    };
  }
}
