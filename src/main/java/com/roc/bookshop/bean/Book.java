package com.roc.bookshop.bean;

public class Book {
	private String bId;// 主键

	private String bName;// 图书名

	private String author;// 作者

	private double price;// 定价

	private double currPrice;// 现价

	private double discount;// 折扣

	private String press;// 出版社

	private String publishTime;// 出版时间

	private Integer edition;// 版次

	private Integer pageNum;// 页数

	private Integer wordNum;// 字数

	private String printTime;// 印刷时间

	private Integer bookSize;// 开本

	private String paper;// 纸质

	private String cId;// 所属分类
	private Category category;// 所属分类

	private String imageW;// 大图路径

	private String imageB;// 小图路径

	private Boolean onSale;// 上架true，下架false

	private Integer inventory;// 库存

	// private Integer orderBy;

	public String getbId() {
		return bId;
	}

	public void setbId(String bId) {
		this.bId = bId == null ? null : bId.trim();
	}

	public String getbName() {
		return bName;
	}

	public void setbName(String bName) {
		this.bName = bName == null ? null : bName.trim();
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author == null ? null : author.trim();
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getCurrPrice() {
		return currPrice;
	}

	public void setCurrPrice(double currPrice) {
		this.currPrice = currPrice;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public String getPress() {
		return press;
	}

	public void setPress(String press) {
		this.press = press == null ? null : press.trim();
	}

	public String getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime == null ? null : publishTime.trim();
	}

	public Integer getEdition() {
		return edition;
	}

	public void setEdition(Integer edition) {
		this.edition = edition;
	}

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getWordNum() {
		return wordNum;
	}

	public void setWordNum(Integer wordNum) {
		this.wordNum = wordNum;
	}

	public String getPrintTime() {
		return printTime;
	}

	public void setPrintTime(String printTime) {
		this.printTime = printTime == null ? null : printTime.trim();
	}

	public Integer getBookSize() {
		return bookSize;
	}

	public void setBookSize(Integer bookSize) {
		this.bookSize = bookSize;
	}

	public String getPaper() {
		return paper;
	}

	public void setPaper(String paper) {
		this.paper = paper == null ? null : paper.trim();
	}

	public String getcId() {
		return cId;
	}

	public void setcId(String cId) {
		this.cId = cId == null ? null : cId.trim();
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getImageW() {
		return imageW;
	}

	public void setImageW(String imageW) {
		this.imageW = imageW == null ? null : imageW.trim();
	}

	public String getImageB() {
		return imageB;
	}

	public void setImageB(String imageB) {
		this.imageB = imageB == null ? null : imageB.trim();
	}

	public Boolean getOnSale() {
		return onSale;
	}

	public void setOnSale(Boolean onSale) {
		this.onSale = onSale;
	}

	public Integer getInventory() {
		return inventory;
	}

	public void setInventory(Integer inventory) {
		this.inventory = inventory;
	}

	@Override
	public String toString() {
		return "Book [bId=" + bId + ", bName=" + bName + ", author=" + author + ", price=" + price + ", currPrice="
				+ currPrice + ", discount=" + discount + ", press=" + press + ", publishTime=" + publishTime
				+ ", edition=" + edition + ", pageNum=" + pageNum + ", wordNum=" + wordNum + ", printTime=" + printTime
				+ ", bookSize=" + bookSize + ", paper=" + paper + ", cId=" + cId + ", category=" + category
				+ ", imageW=" + imageW + ", imageB=" + imageB + ", onSale=" + onSale + ", inventory=" + inventory + "]";
	}

	// public Integer getOrderBy() {
	// return orderBy;
	// }
	// public void setOrderBy(Integer orderBy) {
	// this.orderBy = orderBy;
	// }
}