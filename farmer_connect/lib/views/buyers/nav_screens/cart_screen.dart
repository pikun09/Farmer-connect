import 'package:farmer_connect/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);

    // Debug print to log cart items
    print("Cart items: ${_cartProvider.getCartItem}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 65, 238),
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: _cartProvider.getCartItem.isEmpty
          ? Center(
              child: Text(
                'Your Shopping Cart is Empty',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Card(
                  child: SizedBox(
                    height: 170,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(cartData.imageUrl[0]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.productName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                              Text(
                                'Rs-' + cartData.price.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                  color: Colors.redAccent,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: null,
                                child: Text(
                                  cartData.productSize,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade900,
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: cartData.quantity == 1
                                          ? null
                                          : () {
                                              _cartProvider
                                                  .decreament(cartData);
                                            },
                                      icon: Icon(CupertinoIcons.minus),
                                    ),
                                    Text(cartData.quantity.toString()),
                                    IconButton(
                                      onPressed: () {
                                        _cartProvider.increament(cartData);
                                      },
                                      icon: Icon(CupertinoIcons.plus),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
