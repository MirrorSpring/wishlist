class Shopping{
  final int? shoppingSeq;
  final String shoppingPlace;
  final String shoppingType;
  final String shoppingDate;
  final String? delFlag;

  Shopping({
    this.shoppingSeq,
    required this.shoppingPlace,
    required this.shoppingType,
    required this.shoppingDate,
    this.delFlag
  });

  Shopping.fromMap(Map<String, dynamic> res)
  : shoppingSeq = res['shoppingSeq'],
  shoppingPlace = res['shoppingPlace'],
  shoppingType = res['shoppingType'],
  shoppingDate = res['shoppingDate'],
  delFlag = res['delFlag'];

  factory Shopping.fromJson(Map<String, dynamic> jsonData){
    return Shopping(
      shoppingSeq: jsonData['shoppingSeq'],
      shoppingPlace: jsonData['shoppingPlace'],
      shoppingType: jsonData['shoppingType'],
      shoppingDate: jsonData['shoppingDate'],
      delFlag: jsonData['delFlag']
    );
  }
}