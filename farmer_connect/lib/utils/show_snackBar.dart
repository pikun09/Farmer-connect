import 'package:flutter/material.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.amberAccent,
      content: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
  );
}
