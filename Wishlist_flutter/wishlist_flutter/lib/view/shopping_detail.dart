import 'package:flutter/material.dart';
import 'package:wishlist_flutter/action/shopping_action.dart';
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
  
  @override
  void initState() {
    super.initState();
    shoppingAction = ShoppingAction();
    shoppingDetail = shoppingAction.shoppingDetail(widget.shoppingSeq);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("쇼핑 계획 상세"),
      ),
      body: Center(
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
            )
          ]
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
}