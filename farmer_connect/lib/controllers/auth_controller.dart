import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePikcker = ImagePicker();
    XFile? _file = await _imagePikcker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      // ignore: avoid_print
      print('No image selected ');
    }
  }

  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password, Uint8List image) async {
    String res = 'Somthing Error Occured';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty &&
          // ignore: unnecessary_null_comparison
          image != null) {
        //
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profileImageUrl = await _uploadProfileImageToStorage(image);

        await _firestore.collection('buyers').doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'buyerId': cred.user!.uid,
          'address': '',
          'profileImage': profileImageUrl,
        });
        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (e) {}
    return res;
  }

  loginUser(String email, String password) async {
    String res = 'Something Went Wrong';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
