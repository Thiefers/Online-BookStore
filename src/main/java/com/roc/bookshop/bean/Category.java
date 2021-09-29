package com.roc.bookshop.bean;

import java.util.List;

public class Category {
	private String cId;// 主键

	private String cName;// 分类名称

	private String pId;// 父分类
	// private Category parent;// 父分类

	private String desc;// 分类描述
	private Integer orderBy;// 排序
	// 追加
	private List<Category> children;// 子分类

	public String getcId() {
		return cId;
	}

	public void setcId(String cId) {
		this.cId = cId == null ? null : cId.trim();
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName == null ? null : cName.trim();
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId == null ? null : pId.trim();
	}

	// public Category getParent() {
	// return parent;
	// }
	// public void setParent(Category parent) {
	// this.parent = parent;
	// }

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc == null ? null : desc.trim();
	}

	public List<Category> getChildren() {
		return children;
	}

	public void setChildren(List<Category> children) {
		this.children = children;
	}

	public Integer getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(Integer orderBy) {
		this.orderBy = orderBy;
	}

	@Override
	public String toString() {
		return "Category [cId=" + cId + ", cName=" + cName + ", pId=" + pId + ", desc=" + desc + ", children="
				+ children + ", orderBy=" + orderBy + "]";
	}
}