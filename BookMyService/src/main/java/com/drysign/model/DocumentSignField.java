package com.drysign.model;

public class DocumentSignField 
{
	String priority;
	String signerName;
	String signerEmail;
	String left;
	String top;
	String fieldValue;
	String fieldName;
	String fieldtype;
	String pageNumber;
	String height;
	String width;
	
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getSignerName() {
		return signerName;
	}
	public void setSignerName(String signerName) {
		this.signerName = signerName;
	}
	public String getSignerEmail() {
		return signerEmail;
	}
	public void setSignerEmail(String signerEmail) {
		this.signerEmail = signerEmail;
	}
	public String getLeft() {
		return left;
	}
	public void setLeft(String left) {
		this.left = left;
	}
	public String getTop() {
		return top;
	}
	public void setTop(String top) {
		this.top = top;
	}
	public String getFieldValue() {
		return fieldValue;
	}
	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldtype() {
		return fieldtype;
	}
	public void setFieldtype(String fieldtype) {
		this.fieldtype = fieldtype;
	}
	public String getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(String pageNumber) {
		this.pageNumber = pageNumber;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	@Override
	public String toString() {
		return "DocumentSignField [priority=" + priority + ", signerName="
				+ signerName + ", signerEmail=" + signerEmail + ", left="
				+ left + ", top=" + top + ", fieldValue=" + fieldValue
				+ ", fieldName=" + fieldName + ", fieldtype=" + fieldtype
				+ ", pageNumber=" + pageNumber + ", height=" + height
				+ ", width=" + width + "]";
	}

	
}
