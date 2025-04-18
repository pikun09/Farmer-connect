import 'package:flutter/material.dart';

//purpose: This class will be used to manage and notify listiner about the change
class ProductProvider extends ChangeNotifier {
  //This map will store the product_related information
  Map<String, dynamic> productData = {};

  //This method will be used to update the product related field

  getFormData(
      {String? productName,
      double? productPrice,
      int? quantity,
      String? category,
      String? description,
      DateTime? scheduleDate,
      List<String>? imageUrlList,
      bool? chargeShipping,
      int? shippingCharge,
      String? brandName,
      List<String>? sizeList}) {
    //check if product name is not null

    //purpose : Ensure that only not null valuse were added
    if (productName != null) {
      productData['productName'] = productName;
    }
    if (productPrice != null) {
      productData['productPrice'] = productPrice;
    }
    if (quantity != null) {
      productData['quantity'] = quantity;
    }
    if (category != null) {
      productData['category'] = category;
    }
    if (description != null) {
      productData['description'] = description;
    }
    if (scheduleDate != null) {
      productData['scheduleDate'] = scheduleDate;
    }
    if (imageUrlList != null) {
      productData['imageUrlList'] = imageUrlList;
    }
    if (chargeShipping != null) {
      productData['chargeShipping'] = chargeShipping;
    }
    if (shippingCharge != null) {
      productData['shippingCharge'] = shippingCharge;
    }
    if (brandName != null) {
      productData['brandName'] = brandName;
    }
    if (sizeList != null) {
      productData['sizeList'] = sizeList;
    }
    notifyListeners();
  }

  clearData() {
    productData.clear();
    notifyListeners();
  }
}
