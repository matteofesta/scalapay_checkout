import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:scalapay_checkout/model/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class APIManager{

  static createNewOrder(String uri, String endPoint, Map<String, dynamic> orderData) async{

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${Constants.bearerToken}"
    };

    String jsonData = json.encode(orderData);

    http.Response response = await http.post(Uri.parse(uri + endPoint), headers: header, body: jsonData);

    Map result = jsonDecode(response.body);

    switch(response.statusCode){
      case 400:
        Fluttertoast.showToast(msg: result["message"]["statusText"], toastLength: Toast.LENGTH_SHORT);
        break;

      case 200:
        Fluttertoast.showToast(msg: "Order created successfully", toastLength: Toast.LENGTH_SHORT);
        launchUrlString(result["checkoutUrl"]);
        break;
    }
  }
}
