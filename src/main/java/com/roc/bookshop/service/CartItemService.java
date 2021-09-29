package com.roc.bookshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roc.bookshop.bean.CartItem;
import com.roc.bookshop.dao.CartItemMapper;
import com.roc.bookshop.utils.CommonUtils;

@Service
public class CartItemService {
	@Autowired
	private CartItemMapper cartItemMapper;
//	@Autowired
//	private BookMapper bookMapper;

	// 我的购物车
	public List<CartItem> myCart(String uId) {
		return cartItemMapper.findByUser(uId);
	}

	// 添加条目
	public void add(CartItem cartItem) {
		CartItem _cartItem = cartItemMapper.findByUidAndBid(cartItem.getUser().getUId(), cartItem.getBook().getbId());
		if (_cartItem == null) {
			cartItem.setCartitemId(CommonUtils.uuid());
			cartItemMapper.addCartItem(cartItem);
		} else {
			int quantity = cartItem.getQuantity() + _cartItem.getQuantity();
			cartItemMapper.updateQuantity(_cartItem.getCartitemId(), quantity);
		}
		// 添加后除去相应的图书库存数
//		Book book = cartItem.getBook();
//		book.setInventory(book.getInventory() - cartItem.getQuantity());
//		bookMapper.updateInventory(book);
	}

	// 批量删除
	public void batchDelete(String cartItemIds) {
		String[] cartItemArrays = cartItemIds.split(",");
		cartItemMapper.batchDelete(cartItemArrays);
	}

	// 修改指定条目的数量
	public CartItem updateQuantity(String cartitemId, int quantity) {
		cartItemMapper.updateQuantity(cartitemId, quantity);
		return cartItemMapper.findByCartItemId(cartitemId);
	}

	// 加载多个CartItem
	public List<CartItem> loadCartItems(String cartItemIds) {
		String[] cartItemArrays = cartItemIds.split(",");
		return cartItemMapper.loadCartItems(cartItemArrays);
	}
}