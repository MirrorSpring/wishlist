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
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 왼쪽: 쇼핑 정보
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: shoppingDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("쇼핑 유형: ${snapshot.data!.shoppingType}"),
                              Text("쇼핑 장소: ${snapshot.data!.shoppingPlace}"),
                              Text("쇼핑 일자: ${snapshot.data!.shoppingDate}"),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: _showInsertItem,
                                    child: const Text("품목 추가"),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
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
                                    child: const Text("수정"),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showDeleteConfirm(snapshot.data!.shoppingSeq);
                                    },
                                    child: const Text("삭제"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(width: 16),
              // 오른쪽: 품목 리스트
              Expanded(
                flex: 2,
                child: FutureBuilder(
                  future: itemList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text("데이터 없음");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return GestureDetector(
                          onLongPress: () => _showItemDeleteConfirm(snapshot.data![index].itemSeq),
                          child: Card(
                            child: ListTile(
                              title: Text(item.itemName),
                              subtitle: Text(
                                "수량: ${item.itemBuyQuant} / 단가: ${item.itemUnitPrice}",
                              ),
                              trailing: Checkbox(
                                value: item.itemBuyFlag == 'Y',
                                onChanged: (value) async {
                                  await itemAction.changeItemBuyFlag(
                                      item.itemSeq, value! ? 'Y' : 'N');
                                  setState(() {
                                    itemList = itemAction.itemList(widget.shoppingSeq);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
                  setState(() {
                    itemList = itemAction.itemList(widget.shoppingSeq);
                  });
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

  _showItemDeleteConfirm(int? itemSeq){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '품목 삭제',
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
                await itemAction.deleteItem(itemSeq);
                if (!mounted){
                  return;
                }
                if(context.mounted){
                  Navigator.of(context).pop();
                  setState(() {
                    itemList = itemAction.itemList(widget.shoppingSeq);
                  });
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
}