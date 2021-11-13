import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {

  // var myUrl = Uri.parse("https://fakestoreapi.com/products?limit=9");
  //var myUrl = Uri.parse("https://fakestoreapi.com/products");
  //var myUrl = Uri.parse("https://fakestoreapi.com/products/1");

 static getAllProducts() async {
   List _products=[];
   var myUrl = Uri.parse("https://fakestoreapi.com/products");
   var response = await http.Client().get(myUrl);
   if (response.statusCode == 200) {
     _products = json.decode(response.body) as List;

   } else {
     print("not Good");
   }
    return _products.length;
  }

 static getProductDetails(int id) async {
   var details;
    var myUrl = Uri.parse("https://fakestoreapi.com/products/$id");
    var response = await http.Client().get(myUrl);
    if (response.statusCode == 200) {
      details = json.decode(response.body);

    } else {
      print("not Found");
    }
    return details;
  }
 static getProductByLimit(int limit) async {
   List _products=[];
    var myUrl = Uri.parse("https://fakestoreapi.com/products?limit=$limit");
    var response = await http.Client().get(myUrl);
    if (response.statusCode == 200) {
      _products = json.decode(response.body) as List;

    } else {
      print("not Found");
    }
    return _products;
  }

}
