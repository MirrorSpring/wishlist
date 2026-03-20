import 'package:wishlist_flutter/model/shopping.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShoppingAction {
  late Shopping shopping;

  ShoppingAction({
    required this.shopping
  });

  Future<int> insertShopping() async{
    String json = jsonEncode(<String, String>{
        'shoppingType': shopping.shoppingType,
        'shoppingPlace': shopping.shoppingPlace,
        'shoppingDate': shopping.shoppingDate
      });
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/insertShopping'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json
    );

    print(json);

    if (response.statusCode != 201){
      throw Exception("쇼핑 계획 입력 실패: " + response.statusCode.toString());
    }

    return 201;
  }
}