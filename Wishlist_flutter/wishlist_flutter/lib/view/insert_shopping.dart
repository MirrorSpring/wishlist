import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wishlist_flutter/action/shopping_action.dart';
import 'package:wishlist_flutter/model/shopping.dart';

class InsertShopping extends StatefulWidget {
  const InsertShopping({super.key});

  @override
  State<InsertShopping> createState() => _InsertShoppingState();
}

enum ShoppingTypeList {
  st01("생필품"),
  st02("굿즈"),
  st03("전자제품"),
  st04("먹을거"),
  st99("기타");

  const ShoppingTypeList(this.label);
  final String label;
}

class _InsertShoppingState extends State<InsertShopping> {
  ShoppingTypeList _shoppingType = ShoppingTypeList.st01;
  String shoppingDate = "";
  String selectedShoppingTYpe = "";

  late TextEditingController shoppingPlaceCont;
  late double width = MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    shoppingPlaceCont = TextEditingController();
  }

  @override
  void dispose() {
    shoppingPlaceCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("쇼핑 계획 입력"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: const Text(
                        "쇼핑 유형"
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ShoppingTypeList.values.map((type) {
                        return SizedBox(
                          width: 160,
                          child: RadioListTile<ShoppingTypeList>(
                            title: Text(type.label),
                            value: type,
                            groupValue: _shoppingType,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _shoppingType = value;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: const Text(
                        "쇼핑 장소"
                      ),
                    ),
                    SizedBox(
                      width: width * 0.66,
                      child: TextField(
                        controller: shoppingPlaceCont,
                      )
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: const Text(
                        "쇼핑 날짜"
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(shoppingDate),
                    ),
                    ElevatedButton(onPressed: () async {
                      final DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000)
                      );
                      if (dateTime != null){
                        setState(() {
                          shoppingDate = DateFormat("yyyy-MM-dd").format(dateTime);
                        });
                      }
                    },
                    child: Text("날짜 선택")
                    ),
                  ],
                ),
                ElevatedButton(onPressed: () async{
                    Shopping shopping = Shopping(shoppingPlace: shoppingPlaceCont.text, shoppingType: _shoppingType.label, shoppingDate: shoppingDate);
                    await insertShopping(shopping);
                    if (!mounted){
                      return;
                    }
                    if(context.mounted){
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text("입력")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> insertShopping(Shopping shopping) async{
    ShoppingAction shoppingAction = ShoppingAction(shopping: shopping);
    int res = await shoppingAction.insertShopping();
    return res;
  }
}