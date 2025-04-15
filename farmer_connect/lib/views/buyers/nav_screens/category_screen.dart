import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_connect/views/buyers/nav_screens/widgets/home_product.dart';
import 'package:farmer_connect/views/buyers/nav_screens/widgets/main_products_widget.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _categoriesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            );
          }

          return GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisExtent: 150, crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                final categoryData = snapshot.data!.docs[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        categoryData['image'],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        categoryData['categoryName'],
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
