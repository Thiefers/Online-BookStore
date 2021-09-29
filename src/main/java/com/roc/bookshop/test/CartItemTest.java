package com.roc.bookshop.test;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.roc.bookshop.bean.Book;
import com.roc.bookshop.bean.CartItem;
import com.roc.bookshop.service.BookService;
import com.roc.bookshop.service.CartItemService;

public class CartItemTest {
	private ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	@Test
	public void testMyCart() {
		CartItemService bean = context.getBean(CartItemService.class);
		List<CartItem> myCart = bean.myCart("BCFE766A8E7E4F059AD5B554AD4ECE8E");
		for (CartItem cartItem : myCart) {
			System.out.println(cartItem);
		}
	}
	@Test
	public void testBookById() {
		BookService bean = context.getBean(BookService.class);
		Book book = bean.selectBookByBid("CE01F15D435A4C51B0AD8202A318DCA7");
		System.out.println(book);
	}
}