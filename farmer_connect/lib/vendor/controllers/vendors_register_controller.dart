import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //Function to store image in firebase storage

  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storeImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  //End of the Function
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePiker = ImagePicker();

    XFile? _file = await _imagePiker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

//Function to  Save Vendor Data
  Future<String> registerVendor(
    String businessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegistered,
    String taxNumber,
    Uint8List? image,
  ) async {
    String res = 'Some Error Occure';
    try {
      String storeImage = await _uploadVendorImageToStorage(image);
      // Here I am trying to upload the image to Firebase Storage
      await _firebaseFirestore
          .collection('vendors')
          .doc(_auth.currentUser!.uid)
          .set({
        'businessName': businessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'taxRegistered': taxRegistered,
        'taxNumber': taxNumber,
        'image': storeImage,
        'approved': false,
        'vendorId': _auth.currentUser!.uid,
      });
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
