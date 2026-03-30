package com.wishlist.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.wishlist.bean.ItemBean;
import com.wishlist.model.service.ItemService;

@RestController
public class ItemController {
	
	@Autowired
	ItemService itemService;
	
	@PostMapping("/insertItem")
	public String insertItem(@RequestBody ItemBean itemBean) {
		
		try {
			itemService.insertItem(itemBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
		
		return "SUCCESS";
	}
	
	@GetMapping("/itemList")
	public List<ItemBean> itemList(int shoppingSeq){
		return itemService.itemList(shoppingSeq);
	}
	
	@PostMapping("/changeItemBuyFlag")
	public String changeItemBuyFlag(@RequestBody ItemBean itemBean) {
		try {
			itemService.changeItemBuyFlag(itemBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
		
		return "SUCCESS";
	}
}
