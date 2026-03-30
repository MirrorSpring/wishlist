import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wishlist_flutter/model/item.dart';

class ItemAction {
  late Item? item;

  ItemAction({
    this.item
  });

  Future<int> insertItem() async{
    String json = jsonEncode(<String, String?>{
      'shoppingSeq': '${item?.shoppingSeq}',
      'itemName': item?.itemName,
      'itemBuyQuant': '${item?.itemBuyQuant}',
      'itemUnitPrice': '${item?.itemUnitPrice}'
    });

    final response = await http.post(
      Uri.parse("http://127.0.0.1:8080/insertItem"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: json
    );

    if (response.statusCode != 201 && response.statusCode != 200){
      throw Exception("품목 입력 실패");
    }

    return 201;
  }

  Future<List<Item>> itemList(int? shoppingSeq) async{
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8080/itemList?shoppingSeq=$shoppingSeq'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if (response.statusCode != 201 && response.statusCode != 200){
      throw Exception("리스트 받아오기 실패");
    }

    List<Item> itemList = (jsonDecode(response.body) as List)
    .map((e) => Item.fromJson(e))
    .toList();

    return itemList;
  }

  Future<int> changeItemBuyFlag(int? itemSeq, String? itemBuyFlag) async{
    String json = jsonEncode(<String, String?>{
      'itemSeq': '$itemSeq',
      'itemBuyFlag': itemBuyFlag
    });

    final response = await http.post(
      Uri.parse("http://127.0.0.1:8080/changeItemBuyFlag"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: json
    );

    if (response.statusCode != 201 && response.statusCode != 200){
      throw Exception("구매여부 업데이트 실패");
    }

    return 201;
  }
}