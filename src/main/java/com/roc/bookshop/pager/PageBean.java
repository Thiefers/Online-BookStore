package com.roc.bookshop.pager;

import java.util.List;

/**
 * 分页Bean，它会在各层之间传递！
 *
 * @param <T>
 */
public class PageBean<T> {
	private int pageCode;// 当前页码
	private int totalRecord;// 总记录数
	private int pageSize;// 每页记录数
	private String url;// 请求路径和参数，例如：/BookServlet?method=findXXX&cid=1&bname=2
	private List<T> beanList;

	// 计算总页数
	public int getTotalPage() {
		int totalPage = totalRecord / pageSize;
		return totalRecord % pageSize == 0 ? totalPage : totalPage + 1;
	}

	public int getPageCode() {
		return pageCode;
	}

	public void setPageCode(int pageCode) {
		this.pageCode = pageCode;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<T> getBeanList() {
		return beanList;
	}

	public void setBeanList(List<T> beanList) {
		this.beanList = beanList;
	}
}
