package com.wishlist.model;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.wishlist.model.dao")
public class WishlistJavaApplication {

	public static void main(String[] args) {
		SpringApplication.run(WishlistJavaApplication.class, args);
	}

}
