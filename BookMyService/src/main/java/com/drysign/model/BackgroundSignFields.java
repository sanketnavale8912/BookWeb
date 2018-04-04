package com.drysign.model;

public class BackgroundSignFields {

	private int id;
	private String signerEmail;
	private String signerName;
	private int pageNumber;
	private String fieldType;
	private String fieldName;
	private String fieldValue;
	private Float xPosition;
	private Float yPosition;
	private String fieldHeight;
	private String fieldWidth;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSignerEmail() {
		return signerEmail;
	}
	public void setSignerEmail(String signerEmail) {
		this.signerEmail = signerEmail;
	}
	public String getSignerName() {
		return signerName;
	}
	public void setSignerName(String signerName) {
		this.signerName = signerName;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public String getFieldType() {
		return fieldType;
	}
	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldValue() {
		return fieldValue;
	}
	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}
	public Float getxPosition() {
		return xPosition;
	}
	public void setxPosition(Float xPosition) {
		this.xPosition = xPosition;
	}
	public Float getyPosition() {
		return yPosition;
	}
	public void setyPosition(Float yPosition) {
		this.yPosition = yPosition;
	}
	public String getFieldHeight() {
		return fieldHeight;
	}
	public void setFieldHeight(String fieldHeight) {
		this.fieldHeight = fieldHeight;
	}
	public String getFieldWidth() {
		return fieldWidth;
	}
	public void setFieldWidth(String fieldWidth) {
		this.fieldWidth = fieldWidth;
	}
	@Override
	public String toString() {
		return "BackgroundSignFields [id=" + id + ", signerEmail=" + signerEmail + ", signerName=" + signerName
				+ ", pageNumber=" + pageNumber + ", fieldType=" + fieldType + ", fieldName=" + fieldName
				+ ", fieldValue=" + fieldValue + ", xPosition=" + xPosition + ", yPosition=" + yPosition
				+ ", fieldHeight=" + fieldHeight + ", fieldWidth=" + fieldWidth + "]";
	}
	
	
	
}
