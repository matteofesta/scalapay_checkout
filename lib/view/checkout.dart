import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scalapay_checkout/model/api_manager.dart';
import 'package:scalapay_checkout/model/constants.dart';
import 'package:scalapay_checkout/view_model/confirm_button.dart';
import 'package:scalapay_checkout/view_model/input_field.dart';

class Checkout extends StatefulWidget{
  @override
  State createState() => new CheckoutStates();
}

class CheckoutStates extends State<Checkout>{

  final TextEditingController _consumerPhoneNumber = TextEditingController();
  final TextEditingController _consumerGivenNames = TextEditingController();
  final TextEditingController _consumerSurname = TextEditingController();
  final TextEditingController _consumerEmail = TextEditingController();

  final TextEditingController _shippingPhoneNumber = TextEditingController();
  final TextEditingController _shippingCountryCode = TextEditingController();
  final TextEditingController _shippingName = TextEditingController();
  final TextEditingController _shippingPostcode = TextEditingController();
  final TextEditingController _shippingSuburb = TextEditingController();
  final TextEditingController _shippingLine1 = TextEditingController();

  final TextEditingController _billingPhoneNumber = TextEditingController();
  final TextEditingController _billingCountryCode = TextEditingController();
  final TextEditingController _billingName = TextEditingController();
  final TextEditingController _billingPostcode = TextEditingController();
  final TextEditingController _billingSuburb = TextEditingController();
  final TextEditingController _billingLine1 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }

  _placeOrder() async{

    if (!(_formKey.currentState!.validate())) {
      Fluttertoast.showToast(msg: "Please compile all the requested fields to continue", toastLength: Toast.LENGTH_LONG);
      return;
    }

    Map<String, dynamic> orderData = <String, dynamic>{};

    //Consumer
    orderData["consumer"] = {
      "givenNames": _consumerGivenNames.text,
      "surname": _consumerSurname.text,
      "email": _consumerEmail.text,
      "phoneNumber": _consumerPhoneNumber.text,
    };

    //Shipping Details
    orderData["shipping"] = {
      "name": _shippingName.text,
      "line1": _shippingLine1.text,
      "postcode": _shippingPostcode.text,
      "suburb": _shippingSuburb.text,
      "countryCode": _shippingCountryCode.text,
      "phoneNumber": _shippingPhoneNumber.text,
    };

    //Billing Details
    orderData["billing"] = {
      "name": _billingName.text,
      "line1": _billingLine1.text,
      "postcode": _billingPostcode.text,
      "suburb": _billingSuburb.text,
      "countryCode": _billingCountryCode.text,
      "phoneNumber": _billingPhoneNumber.text,
    };

    //Products
    orderData["items"] = [
      {
        "quantity": 1,
        "price": {"amount": "100.00", "currency": "EUR"},
        "name": "Test Product",
        "category": "Test",
        "sku": "00000"
      }
    ];

    //Total Amount
    orderData["totalAmount"] = {
      "amount": "100.00",
      "currency": "EUR"
    };

    //Merchant
    orderData["merchant"] = {
      "redirectCancelUrl": "https://portal.integration.scalapay.com/failure-url",
      "redirectConfirmUrl": "https://portal.integration.scalapay.com/success-url",
    };

    await APIManager.createNewOrder(Constants.apiURI, Constants.ordersEndpoint, orderData);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Constants.bgColor,

      body:GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Divider(height: 20, color: Colors.transparent),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Image.asset("resources/logo_text.jpeg"),
                    ),

                    Divider(height: 40, color: Colors.transparent),

                    Text("Create New Order", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                    Divider(height: 20, color: Colors.transparent),

                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                          Divider(height: 20, color: Colors.grey.shade300),

                          Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.asset("resources/logo.png", width: 40),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Test Product", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                            Divider(height: 15, color: Colors.grey.shade300),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Quantity: 1", style: TextStyle(fontSize: 12)),
                                                Text("100.00 €", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 20, color: Colors.transparent),

                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Consumer", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                          Divider(height: 20, color: Colors.grey.shade300),

                          InputField("Given Name", _consumerGivenNames, textCapitalization: TextCapitalization.words),
                          InputField("Surname", _consumerSurname),
                          InputField("E-Mail Address", _consumerEmail, inputType: TextInputType.emailAddress, isRequired: false),
                          InputField("Phone Number", _consumerPhoneNumber, inputType: TextInputType.phone, isRequired: false),
                        ],
                      ),
                    ),

                    Divider(height: 20, color: Colors.transparent),

                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Shipping", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                          Divider(height: 20, color: Colors.grey.shade300),

                          InputField("Name", _shippingName, textCapitalization: TextCapitalization.words),
                          InputField("Address", _shippingLine1, textCapitalization: TextCapitalization.words),
                          InputField("Postcode", _shippingPostcode, inputType: TextInputType.number),
                          InputField("Suburb", _shippingSuburb, isRequired: false),
                          InputField("Country (Two letter code)", _shippingCountryCode, textCapitalization: TextCapitalization.characters, maxLength: 2),
                          InputField("Phone Number", _shippingPhoneNumber, inputType: TextInputType.phone, isRequired: false),
                        ],
                      ),
                    ),

                    Divider(height: 20, color: Colors.transparent),

                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Billing", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                          Divider(height: 20, color: Colors.grey.shade300),

                          InputField("Name", _billingName, textCapitalization: TextCapitalization.words),
                          InputField("Address", _billingLine1, textCapitalization: TextCapitalization.words),
                          InputField("Postcode", _billingPostcode, inputType: TextInputType.number),
                          InputField("Suburb", _billingSuburb, isRequired: false),
                          InputField("Country (Two letter code)", _billingCountryCode, textCapitalization: TextCapitalization.characters, maxLength: 2),
                          InputField("Phone Number", _billingPhoneNumber, inputType: TextInputType.phone, isRequired: false),
                        ],
                      ),
                    ),

                    Divider(height: 20, color: Colors.transparent),
                    
                    ConfirmButton("Place Order", () => _placeOrder())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
