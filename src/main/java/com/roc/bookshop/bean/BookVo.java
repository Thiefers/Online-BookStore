package com.roc.bookshop.bean;

/**
 * 存放图书查询条件
 * 
 * @author 14036
 *
 */
public class BookVo {
	private int from;
	private int to;
	private Book book;

	public int getFrom() {
		return from;
	}

	public void setFrom(int from) {
		this.from = from;
	}

	public int getTo() {
		return to;
	}

	public void setTo(int to) {
		this.to = to;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

}