import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_connect/vendor/models/vendor_user_models.dart';
import 'package:farmer_connect/vendor/views/auth/vendor_registration_screen.dart';
import 'package:farmer_connect/vendor/views/screens/main_vendor_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (!snapshot.data!.exists) {
          return VendorRegistrationScreen();
        }
        VendorUserModels vendorUserModels = VendorUserModels.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>);

        if (vendorUserModels.approved == true) {
          return MainVendorScreen();
        }
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                vendorUserModels.image.toString(),
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              vendorUserModels.businessName.toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Your Application sent to the Admin\n Admin will get back to you soon .',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text(
                'SignOut',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
      },
    ));
  }
}
