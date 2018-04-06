package com.drysign.sdk.model;

public class DocumentField {

	private int id;
	private int docId;
	private int pageNumber;
	private String fieldType;
	private String fieldName;
	private String fieldValue;
	private float xPosition;
	private float yPosition;
	private float fieldHeight;
	private float fieldWidth;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDocId() {
		return docId;
	}
		
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	
	public void setDocId(int docId) {
		this.docId = docId;
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
	public float getxPosition() {
		return xPosition;
	}
	public void setxPosition(float xPosition) {
		this.xPosition = xPosition;
	}
	public float getyPosition() {
		return yPosition;
	}
	public void setyPosition(float yPosition) {
		this.yPosition = yPosition;
	}
	public float getFieldHeight() {
		return fieldHeight;
	}
	public void setFieldHeight(float fieldHeight) {
		this.fieldHeight = fieldHeight;
	}
	public float getFieldWidth() {
		return fieldWidth;
	}
	public void setFieldWidth(float fieldWidth) {
		this.fieldWidth = fieldWidth;
	}
	@Override
	public String toString() {
		return "DocumentField [id=" + id + ", docId=" + docId + ", pageNumber="
				+ pageNumber + ", fieldType=" + fieldType + ", fieldName="
				+ fieldName + ", fieldValue=" + fieldValue + ", xPosition="
				+ xPosition + ", yPosition=" + yPosition + ", fieldHeight="
				+ fieldHeight + ", fieldWidth=" + fieldWidth + "]";
	}
	
	
	
	
}
