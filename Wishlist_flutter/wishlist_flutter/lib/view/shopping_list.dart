import 'package:flutter/material.dart';
import 'package:wishlist_flutter/view/insert_shopping.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
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
                    //acclist = handler.accList();
                  });
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        )
      )
    );
  }
}