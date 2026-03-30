package com.wishlist.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.wishlist.bean.ItemBean;

@Service
public interface ItemService {
	void insertItem(ItemBean itemBean);
	List<ItemBean> itemList(int shoppingSeq);
	void changeItemBuyFlag(ItemBean itemBean);
}
