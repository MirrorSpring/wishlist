import 'package:flutter/material.dart';
import 'package:wishlist_flutter/action/item_action.dart';
import 'package:wishlist_flutter/action/shopping_action.dart';
import 'package:wishlist_flutter/model/item.dart';
import 'package:wishlist_flutter/model/shopping.dart';
import 'package:wishlist_flutter/view/update_shopping.dart';

class ShoppingDetail extends StatefulWidget {
  final int? shoppingSeq;
  const ShoppingDetail({super.key, this.shoppingSeq});

  @override
  State<ShoppingDetail> createState() => _ShoppingDetailState();
}

class _ShoppingDetailState extends State<ShoppingDetail> {
  late ShoppingAction shoppingAction;
  late Future<Shopping> shoppingDetail;
  late TextEditingController itemNameCont;
  late TextEditingController itemBuyQuantCont;
  late TextEditingController itemUnitPriceCont;
  late Future<List<Item>> itemList;
  late ItemAction itemAction;
  
  @override
  void initState() {
    super.initState();
    shoppingAction = ShoppingAction();
    itemAction = ItemAction();
    shoppingDetail = shoppingAction.shoppingDetail(widget.shoppingSeq);
    itemList = itemAction.itemList(widget.shoppingSeq);
    itemNameCont = TextEditingController();
    itemBuyQuantCont = TextEditingController();
    itemUnitPriceCont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("쇼핑 계획 상세"),
      ),
      body: Center(
        child: SizedBox(
          child: SizedBox(
            width: 1500,
            child: Column(
              children: [
                FutureBuilder(
                  future: shoppingDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                      return Card(
                        child: Column(
                          children: [
                            Text("쇼핑 유형: ${snapshot.data?.shoppingType}"),
                            Text("쇼핑 장소: ${snapshot.data?.shoppingPlace}"),
                            Text("쇼핑 일자: ${snapshot.data?.shoppingDate}"),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _showInsertItem();
                                  },
                                  child: const Text("품목 추가")
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UpdateShopping(
                                            shopping: Shopping(
                                              shoppingDate: snapshot.data!.shoppingDate,
                                              shoppingPlace: snapshot.data!.shoppingPlace,
                                              shoppingType: snapshot.data!.shoppingType,
                                              shoppingSeq: widget.shoppingSeq
                                            )
                                          );
                                        },
                                      )
                                    ).then(
                                      (value) {
                                        setState(() {
                                          shoppingDetail = shoppingAction.shoppingDetail(widget.shoppingSeq);
                                        });
                                      },
                                    );
                                  },
                                  child: const Text("수정")
                                ),
                                TextButton(
                                  onPressed: () {
                                    _showDeleteConfirm(snapshot.data?.shoppingSeq);
                                  },
                                  child: const Text("삭제")
                                ),
                              ],
                            )
                          ],
                        )
                      );
                    } else{
                      return Card(
                        child: Text("쇼핑 정보를 불러오고 있습니다")
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: itemList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: Card(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '품목명: ${snapshot.data![index].itemName}'
                                        '구매량: ${snapshot.data![index].itemBuyQuant}'
                                        '단가: ${snapshot.data![index].itemUnitPrice}'
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Checkbox(
                                        value: snapshot.data![index].itemBuyFlag == 'Y',
                                        onChanged: (value) async{
                                          String itemBuyFlag = value!?'Y':'N';
                                          await itemAction.changeItemBuyFlag(snapshot.data![index].itemSeq, itemBuyFlag);
                                          setState(() {
                                            itemList = itemAction.itemList(widget.shoppingSeq);
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              )
                            ),
                          );
                        },
                      );
                    } else{
                      return Text("입력된 품목이 없습니다");
                    }
                  },
                )
              ]
            ),
          ),
        )
      )
    );
  }

  ///삭제 확인 다이얼로그 표시
  _showDeleteConfirm(int? shoppingSeq) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '쇼핑 정보 삭제',
          ),
          content: const Text(
            '정말로 삭제하시겠습니까?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '아니오',
              ),
            ),
            TextButton(
              onPressed: () async {
                await shoppingAction.deleteShopping(shoppingSeq);
                if (!mounted){
                  return;
                }
                if(context.mounted){
                  Navigator.of(context).pop();
                  Navigator.pop(context, true);
                }
              },
              child: const Text(
                '예',
              ),
            ),
          ],
        );
      },
    );
  }

  //품목 입력 다이얼로그 표시
  _showInsertItem(){
    showDialog(
      context: context,
      builder:(context) {
        return AlertDialog(
          title: const Text(
            '품목 입력'
          ),
          content: Column(
            children: [
              Row(
                children: [
                  const Text(
                    '품목명: '
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: itemNameCont
                    ),
                  )
                ]
              ),
              Row(
                children: [
                  const Text(
                    '구매량: '
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: itemBuyQuantCont
                    ),
                  )
                ]
              ),
              Row(
                children: [
                  const Text(
                    '단가: '
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: itemUnitPriceCont
                    ),
                  )
                ]
              ),
            ]
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '취소'
              )
            ),
            TextButton(
              onPressed: () async{
                ItemAction itemAction = ItemAction(
                  item: Item(
                    shoppingSeq: widget.shoppingSeq,
                    itemBuyQuant: int.parse(itemBuyQuantCont.text),
                    itemName: itemNameCont.text,
                    itemUnitPrice: int.parse(itemUnitPriceCont.text)
                  )
                );
                await itemAction.insertItem();
                if (!mounted){
                  return;
                }
                if(context.mounted){
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                '입력'
              )
            )
          ],
        );
      },
    );
  }
}