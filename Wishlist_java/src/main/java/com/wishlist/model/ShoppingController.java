package com.wishlist.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.wishlist.bean.ShoppingBean;
import com.wishlist.model.service.ShoppingService;

@RestController
public class ShoppingController {
	
	@Autowired
	private ShoppingService shoppingService;
	
	@GetMapping("/shoppingList")
	public List<ShoppingBean> shoppingList(){
		return shoppingService.shoppingList();
	}
	
	@PostMapping("/insertShopping")
	public String insertShopping(@RequestBody ShoppingBean shoppingBean) {
		try {
			shoppingService.insertShopping(shoppingBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "FAIL";
		}
		
		return "SUCCESS";
	}

	@GetMapping("/shoppingDetail")
	public ShoppingBean shoppingDetail(int shoppingSeq) {
		return shoppingService.shoppingDetail(shoppingSeq);
	}
	
	@PostMapping("/deleteShopping")
	public String deleteShopping(@RequestBody ShoppingBean shoppingBean) {
		try {
			shoppingService.deleteShopping(shoppingBean.getShoppingSeq());
		} catch(Exception e) {
			return "FAIL";
		}
		
		return "SUCCESS";
	}
	
	@PostMapping("/updateShopping")
	public String updateShopping(@RequestBody ShoppingBean shoppingBean) {
		try {
			shoppingService.updateShopping(shoppingBean);
		} catch(Exception e) {
			return "FAIL";
		}
		return "SUCCESS";
	}
}
