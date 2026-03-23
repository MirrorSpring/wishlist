import 'package:flutter/material.dart';
import 'package:wishlist_flutter/action/shopping_action.dart';
import 'package:wishlist_flutter/model/shopping.dart';
import 'package:wishlist_flutter/view/insert_shopping.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  late Future<List<Shopping>> shoppingList;
  late ShoppingAction shoppingAction;
  
  @override
  void initState() {
    super.initState();
    shoppingAction = ShoppingAction();
    shoppingList = shoppingAction.shoppingList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => {
        FocusScope.of(context).unfocus()
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("나의 쇼핑"),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const InsertShopping();
                },
              )).then(
                (value) {
                  setState(() {
                    shoppingList = shoppingAction.shoppingList();
                  });
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        body: FutureBuilder(
          future: shoppingList,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Text("쇼핑 장소: ${snapshot.data![index].shoppingPlace}"),
                        Text("쇼핑 유형: ${snapshot.data![index].shoppingType}"),
                        Text("쇼핑 일자: ${snapshot.data![index].shoppingDate}"),
                      ],
                    )
                  );
                },
              );
            } else{
              return const Text("검색 결과가 없습니다");
            }
          },
        )
      )
    );
  }
}