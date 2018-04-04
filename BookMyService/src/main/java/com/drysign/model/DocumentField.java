package com.drysign.model;

import java.sql.Timestamp;

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
	
	private String left;
	private String top;
	private String fileName;
	private String documentName;
	private String docData;
	private int userId;
	private int priority;
	private Timestamp createdOn;
	private int fileId;
	
	public DocumentField() {
		// TODO Auto-generated constructor stub
	}
	
	public DocumentField(int pageNumber,String fileName){
		this.pageNumber=pageNumber;
		this.fileName=fileName;
	}
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getDocumentName() {
		return documentName;
	}
	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}

	public String getDocData() {
		return docData;
	}

	public void setDocData(String docData) {
		this.docData = docData;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	
	
	
	
}
