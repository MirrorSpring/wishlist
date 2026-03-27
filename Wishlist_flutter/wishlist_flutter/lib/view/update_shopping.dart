import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wishlist_flutter/action/shopping_action.dart';
import 'package:wishlist_flutter/model/shopping.dart';
import 'package:wishlist_flutter/model/shopping_type_list.dart';

class UpdateShopping extends StatefulWidget {
  final Shopping shopping;
  const UpdateShopping({super.key, required this.shopping});

  @override
  State<UpdateShopping> createState() => _UpdateShoppingState();
}

class _UpdateShoppingState extends State<UpdateShopping> {
  ShoppingTypeList _shoppingType = ShoppingTypeList.st01;
  String shoppingDate = "";
  String selectedShoppingTYpe = "";

  late TextEditingController shoppingPlaceCont;
  late double width = MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    shoppingPlaceCont = TextEditingController();
    shoppingPlaceCont.text = widget.shopping.shoppingPlace;
    shoppingDate = widget.shopping.shoppingDate;
    _shoppingType = _shoppingType.getShopingTypeFromLabel(widget.shopping.shoppingType);
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
          title: const Text("쇼핑 정보 수정"),
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
                    Shopping shopping = Shopping(shoppingPlace: shoppingPlaceCont.text, shoppingType: _shoppingType.label, shoppingDate: shoppingDate, shoppingSeq: widget.shopping.shoppingSeq);
                    await updateShopping(shopping);
                    if (!mounted){
                      return;
                    }
                    if(context.mounted){
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text("수정")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateShopping(Shopping shopping) async{
    ShoppingAction shoppingAction = ShoppingAction(shopping: shopping);
    int res = await shoppingAction.updateShopping();
    return res;
  }
}