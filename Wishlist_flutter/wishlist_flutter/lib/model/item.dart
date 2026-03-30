
class Item{
  final int? itemSeq;
  final int? shoppingSeq;
  final String itemName;
  final String? itemBuyFlag;
  final int itemUnitPrice;
  final int itemBuyQuant;
  final String? delFlag;

  Item({
    this.itemSeq,
    this.shoppingSeq,
    required this.itemName,
    this.itemBuyFlag,
    required this.itemBuyQuant,
    required this.itemUnitPrice,
    this.delFlag
  });

  Item.fromMap(Map<String, dynamic> res)
  : itemSeq = res['itemSeq'],
  shoppingSeq = res['shoppingSeq'],
  itemName = res['itemName'],
  itemBuyFlag = res['itemBuyFlag'],
  itemUnitPrice = res['itemUnitPrice'],
  itemBuyQuant = res['itemBuyQuant'],
  delFlag = res['delFlag'];

  factory Item.fromJson(Map<String, dynamic> jsonData){
    return Item(
      itemSeq: jsonData['itemSeq'],
      shoppingSeq: jsonData['shoppingSeq'],
      itemName: jsonData['itemName'],
      itemBuyFlag: jsonData['itemBuyFlag'],
      itemUnitPrice: jsonData['itemUnitPrice'],
      itemBuyQuant: jsonData['itemBuyQuant'],
      delFlag: jsonData['delFlag']
    );
  }
}