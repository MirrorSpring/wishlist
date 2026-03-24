package com.wishlist.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wishlist.bean.ShoppingBean;
import com.wishlist.model.dao.ShoppingMapper;

@Service
public class ShoppingServiceImpl implements ShoppingService{

	@Autowired
	private ShoppingMapper shoppingMapper;
	
	@Override
	public List<ShoppingBean> shoppingList() {
		return shoppingMapper.shoppingList();
	}

	@Override
	public void insertShopping(ShoppingBean shoppingBean) {
		shoppingMapper.insertShopping(shoppingBean);
	}

	@Override
	public ShoppingBean shoppingDetail(int shoppingSeq) {
		return shoppingMapper.shoppingDetail(shoppingSeq);
	}

}
