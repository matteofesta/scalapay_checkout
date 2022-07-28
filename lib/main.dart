import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scalapay_checkout/view/checkout.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Checkout(),
  ));
}
