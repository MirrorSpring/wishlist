import 'package:wishlist_flutter/model/shopping.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShoppingAction {
  late Shopping? shopping;

  ShoppingAction({
    this.shopping
  });

  Future<int> insertShopping() async{
    String json = jsonEncode(<String, String?>{
        'shoppingType': shopping?.shoppingType,
        'shoppingPlace': shopping?.shoppingPlace,
        'shoppingDate': shopping?.shoppingDate
      });
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/insertShopping'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json
    );

    if (response.statusCode != 201 || response.statusCode != 200){
      throw Exception("쇼핑 계획 입력 실패");
    }

    return 201;
  }

  Future<List<Shopping>> shoppingList() async{
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8080/shoppingList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if (response.statusCode != 201 && response.statusCode != 200){
      throw Exception("리스트 받아오기 실패");
    }

    List<Shopping> shoppingList = (jsonDecode(response.body) as List)
    .map((e) => Shopping.fromJson(e))
    .toList();

    return shoppingList;
  }

  Future<Shopping> shoppingDetail(int? shoppingSeq) async{
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8080/shoppingDetail?shoppingSeq=$shoppingSeq'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if (response.statusCode != 201 && response.statusCode != 200){
      throw Exception("쇼핑 상세정보 받아오기 실패");
    }

    return Shopping.fromJson(jsonDecode(response.body));
  }
}