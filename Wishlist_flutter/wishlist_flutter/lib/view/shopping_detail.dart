import 'package:flutter/material.dart';
import 'package:wishlist_flutter/action/shopping_action.dart';
import 'package:wishlist_flutter/model/shopping.dart';

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
}