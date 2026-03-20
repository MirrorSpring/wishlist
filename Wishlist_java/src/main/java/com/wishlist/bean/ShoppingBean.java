package com.wishlist.bean;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class ShoppingBean {
	
	private int shopping_seq;
	private String shopping_type;
	private String shopping_place;
	private String shopping_date;
	private String del_flag;
}
