package com.wishlist.bean;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ShoppingBean {
	
	private int shoppingSeq;
	private String shoppingType;
	private String shoppingPlace;
	private String shoppingDate;
	private String delFlag;
}
