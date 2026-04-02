import 'package:flutter/material.dart';
import 'package:wishlist_flutter/action/shopping_action.dart';
import 'package:wishlist_flutter/model/shopping.dart';
import 'package:wishlist_flutter/view/insert_shopping.dart';
import 'package:wishlist_flutter/view/shopping_detail.dart';

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

  void _reloadShoppingList() {
    setState(() {
      shoppingList = shoppingAction.shoppingList();
    });
  }

  Future<void> _goToInsertPage() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const InsertShopping(),
      ),
    );

    if (result == true) {
      _reloadShoppingList();
    }
  }

  Future<void> _goToDetailPage(int? shoppingSeq) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingDetail(shoppingSeq: shoppingSeq),
      ),
    );

    if (result == true) {
      _reloadShoppingList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("나의 쇼핑"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _goToInsertPage,
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Shopping>>(
          future: shoppingList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('에러가 발생했습니다: ${snapshot.error}'),
              );
            }

            final items = snapshot.data ?? [];

            if (items.isEmpty) {
              return const Center(
                child: Text("등록된 쇼핑 정보가 없습니다"),
              );
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final shopping = items[index];

                    return Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () => _goToDetailPage(shopping.shoppingSeq),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isWide = constraints.maxWidth >= 700;

                              if (isWide) {
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        shopping.shoppingPlace,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text("유형: ${shopping.shoppingType}"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text("일자: ${shopping.shoppingDate}"),
                                    ),
                                    const Icon(Icons.chevron_right),
                                  ],
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shopping.shoppingPlace,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text("유형: ${shopping.shoppingType}"),
                                  Text("일자: ${shopping.shoppingDate}"),
                                  const SizedBox(height: 8),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.chevron_right),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}