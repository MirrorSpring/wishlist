package com.wishlist.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wishlist.bean.ItemBean;
import com.wishlist.model.dao.ItemMapper;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	private ItemMapper itemMapper;

	@Override
	public void insertItem(ItemBean itemBean) {
		itemMapper.insertItem(itemBean);
	}

	@Override
	public List<ItemBean> itemList(int shoppingSeq) {
		return itemMapper.itemList(shoppingSeq);
	}

	@Override
	public void changeItemBuyFlag(ItemBean itemBean) {
		itemMapper.changeItemBuyFlag(itemBean);
	}

	@Override
	public void deleteItem(int itemSeq) {
		itemMapper.deleteItem(itemSeq);
	}

}
