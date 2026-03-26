package com.wishlist.model.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wishlist.bean.ShoppingBean;

@Repository
public interface ShoppingMapper {
	List<ShoppingBean> shoppingList();
	void insertShopping(ShoppingBean shoppingBean);
	ShoppingBean shoppingDetail(int shoppingSeq);
	void deleteShopping(int shoppingSeq);
}
