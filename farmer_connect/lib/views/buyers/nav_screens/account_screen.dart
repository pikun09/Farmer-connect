import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    
    // Check if the user is authenticated
    if (_auth.currentUser == null) {
      return Center(child: Text("User not logged in"));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_auth.currentUser!.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          // Log the specific error
          print("Error fetching user data: ${snapshot.error}");
          return Text("Something went wrong: ${snapshot.error}");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.pinkAccent,
              title: Text(
                'Profile',
                style: TextStyle(letterSpacing: 4),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(Icons.star_border),
                )
              ],
            ),
            body: Column(
              children: [
                SizedBox(height: 25),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(data['profileImage']),
                    onBackgroundImageError: (error, stackTrace) {
                      // Handle image loading error
                      print("Error loading image: $error");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['fullName'],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['email'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Setting'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                ),
                ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Cart'),
                ),
                ListTile(
                  leading: Icon(Icons.shop_2),
                  title: Text('Order'),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: TextButton(
                    onPressed: () {
                      _auth.signOut(); // Implement logout functionality
                    },
                    child: Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
