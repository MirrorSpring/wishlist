package com.wishlist.model;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import jakarta.servlet.ServletContext;

public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(WishlistJavaApplication.class);
	}

	@Override
	public void onStartup(ServletContext servletContext) {
		// TODO Auto-generated method stub
		System.out.println("server started");
	}

}
