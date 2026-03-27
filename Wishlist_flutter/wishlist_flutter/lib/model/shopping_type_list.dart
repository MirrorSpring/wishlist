
enum ShoppingTypeList {
  st01("생필품"),
  st02("굿즈"),
  st03("전자제품"),
  st04("먹을거"),
  st99("기타");

  const ShoppingTypeList(this.label);
  final String label;

  ShoppingTypeList getShopingTypeFromLabel(String shoppingType){
    ShoppingTypeList res = ShoppingTypeList.st99;
    switch (shoppingType){
      case "생필품":
        res = ShoppingTypeList.st01;
        break;
      case "굿즈":
        res = ShoppingTypeList.st02;
        break;
      case "전자제품":
        res = ShoppingTypeList.st03;
        break;
      case "먹을거":
        res = ShoppingTypeList.st04;
        break;
    }

    return res;
  }
}