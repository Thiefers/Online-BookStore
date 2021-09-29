package com.roc.bookshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.roc.bookshop.bean.CartItem;

@Repository
public interface CartItemMapper {
	// 通过用户查询购物车条目
	public List<CartItem> findByUser(String uId);
	// 查询某个用户的某本图书的购物车条目是否存在
	public CartItem findByUidAndBid(@Param("uId")String uId, @Param("bId")String bId);
	// 修改指定条目的数量
	public void updateQuantity(@Param("cartItemId")String cartItemId,@Param("quantity")Integer quantity);
	// 添加条目
	public void addCartItem(CartItem cartItem);
	// 批量删除
	public void batchDelete(String[] cartItemArrays);
	// 按ID查询
	public CartItem findByCartItemId(String cartitemId);
	// 加载多个CartItem
	public List<CartItem> loadCartItems(String[] cartItemArrays);
}