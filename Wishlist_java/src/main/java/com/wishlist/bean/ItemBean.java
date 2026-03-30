package com.wishlist.bean;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ItemBean {

	private int itemSeq;
	private int shoppingSeq;
	private String itemName;
	private String itemBuyFlag;
	private int itemUnitPrice;
	private int itemBuyQuant;
	private String delFlag;
}
