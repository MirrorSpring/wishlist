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

  late TextEditingController shoppingPlaceCont;

  @override
  void initState() {
    super.initState();
    shoppingPlaceCont = TextEditingController(text: widget.shopping.shoppingPlace);
    shoppingDate = widget.shopping.shoppingDate;
    _shoppingType =
        _shoppingType.getShopingTypeFromLabel(widget.shopping.shoppingType);
  }

  @override
  void dispose() {
    shoppingPlaceCont.dispose();
    super.dispose();
  }

  Future<int> updateShopping(Shopping shopping) async {
    final shoppingAction = ShoppingAction(shopping: shopping);
    return await shoppingAction.updateShopping();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 900;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("쇼핑 정보 수정"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "쇼핑 정보 수정",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildSectionTitle("쇼핑 유형"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: ShoppingTypeList.values.map((type) {
                          return SizedBox(
                            width: 170,
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

                      const SizedBox(height: 24),

                      _buildSectionTitle("쇼핑 장소"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: shoppingPlaceCont,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "쇼핑 장소를 입력하세요",
                        ),
                      ),

                      const SizedBox(height: 24),

                      _buildSectionTitle("쇼핑 날짜"),
                      const SizedBox(height: 8),
                      isWide
                          ? Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 56,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      shoppingDate.isEmpty
                                          ? "선택된 날짜가 없습니다"
                                          : shoppingDate,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: _pickDate,
                                  child: const Text("날짜 선택"),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 56,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    shoppingDate.isEmpty
                                        ? "선택된 날짜가 없습니다"
                                        : shoppingDate,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: _pickDate,
                                  child: const Text("날짜 선택"),
                                ),
                              ],
                            ),

                      const SizedBox(height: 32),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final shopping = Shopping(
                              shoppingPlace: shoppingPlaceCont.text,
                              shoppingType: _shoppingType.label,
                              shoppingDate: shoppingDate,
                              shoppingSeq: widget.shopping.shoppingSeq,
                            );

                            await updateShopping(shopping);

                            if (!mounted) return;
                            if (context.mounted) Navigator.pop(context, true);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("수정"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: shoppingDate.isNotEmpty
          ? DateTime.parse(shoppingDate)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );

    if (dateTime != null) {
      setState(() {
        shoppingDate = DateFormat("yyyy-MM-dd").format(dateTime);
      });
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}