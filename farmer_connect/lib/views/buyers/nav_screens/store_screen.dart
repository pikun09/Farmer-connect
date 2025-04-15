import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});
  Widget vendorData(int? flex, Widget widget) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stores',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _vendorsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final vendorUserData = snapshot.data!.docs[index];
                return Container(
                    child: Row(
                  children: [
                    vendorData(
                      1,
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.network(vendorUserData['image']),
                      ),
                    ),
                    vendorData(
                      3,
                      Text(
                        vendorUserData['businessName'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ));
              });
        },
      ),
    );
  }
}
