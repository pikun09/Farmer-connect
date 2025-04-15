import 'package:farmer_connect/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? productData;

  const ProductDetailScreen({super.key, this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outPutDateFormat = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormat.format(date);
    return outPutDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    if (widget.productData == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Product Detail')),
        body: Center(child: Text('No product data available.')),
      );
    }

    final imageUrls = widget.productData!['imageUrl'] as List<dynamic>? ?? [];
    final sizeList = widget.productData!['sizeList'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productData!['productName'] ?? 'Product',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                      imageProvider: NetworkImage(
                          imageUrls.isNotEmpty && _imageIndex < imageUrls.length
                              ? imageUrls[_imageIndex]
                              : '')),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _imageIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.yellow.shade900),
                                  ),
                                  height: 60,
                                  width: 60,
                                  child: Image.network(imageUrls.isNotEmpty
                                      ? imageUrls[index]
                                      : ''),
                                ),
                              ),
                            );
                          }),
                    ))
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                widget.productData!['productName'] ?? 'Product Name',
                style: TextStyle(
                  fontSize: 22,
                  color: const Color.fromARGB(255, 3, 1, 12),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Rs-' +
                  (widget.productData!['productPrice']?.toStringAsFixed(2) ??
                      '0.00'),
              style: TextStyle(
                fontSize: 22,
                color: const Color.fromARGB(255, 227, 5, 34),
                fontWeight: FontWeight.bold,
              ),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Description:',
                    style: TextStyle(color: Colors.yellow.shade900),
                  ),
                  Text(
                    'ViewMore',
                    style: TextStyle(color: Colors.yellow.shade900),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData!['description'] ??
                        'No description available.',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'This Product Will be Shipping on ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    widget.productData!['scheduleDate'] != null
                        ? formatedDate(
                            widget.productData!['scheduleDate'].toDate())
                        : 'No shipping date available.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: Text(
                'Available Size',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                sizeList.isNotEmpty
                    ? Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sizeList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedSize = sizeList[index];
                                    });
                                    print(_selectedSize);
                                  },
                                  child: Text(sizeList[index]),
                                ),
                              );
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('No sizes available.'),
                      ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (_selectedSize != null) {
              _cartProvider.addProductToCart(
                  widget.productData!['productName'],
                  widget.productData!['productId'],
                  widget.productData!['imageUrl'],
                  1,
                  widget.productData!['productPrice'],
                  widget.productData!['vendorId'],
                  _selectedSize!,
                  widget.productData!['scheduleDate']);
            } else {
              // Handle case where no size is selected
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select a size.')),
              );
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Text(
                  'Add To Cart',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
