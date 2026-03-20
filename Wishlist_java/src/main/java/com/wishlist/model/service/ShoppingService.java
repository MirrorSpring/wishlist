package com.wishlist.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.wishlist.bean.ShoppingBean;

@Service
public interface ShoppingService {
	List<ShoppingBean> shoppingList();
	void insertShopping(ShoppingBean shoppingBean);
}
