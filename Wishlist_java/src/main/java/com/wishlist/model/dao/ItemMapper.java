package com.wishlist.model.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wishlist.bean.ItemBean;

@Repository
public interface ItemMapper {

	void insertItem(ItemBean itemBean);
	List<ItemBean> itemList(int shoppingSeq);
	void changeItemBuyFlag(ItemBean itemBean);
}
