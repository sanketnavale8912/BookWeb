package com.drysign.model;

import java.sql.Timestamp;

public class DocumentField {

	private int id;
	private int docId;
	private int draftId;
	private int pageNumber;
	private int stepNumber;
	private String fieldHtml;
	private String type;
	private String fieldType;
	private String fieldName;
	private String pageHeight;
	private String fieldValue;
	private String fieldValue1;
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
	private String to;
	private String cc;
	private String subject;
	private String message;
	private int increment;
	private String signerName;
	private String signerEmail;
    private String signType;
    private String flag;
    private String docStatus;
    private String isActivePriority;
    private int  numpages;
	public DocumentField() {
		// TODO Auto-generated constructor stub
	}

	public DocumentField(int pageNumber, String fileName) {
		this.pageNumber = pageNumber;
		this.fileName = fileName;
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

	public String getFieldValue1() {
		return fieldValue1;
	}

	public void setFieldValue1(String fieldValue1) {
		this.fieldValue1 = fieldValue1;
	}

	public int getDraftId() {
		return draftId;
	}

	public void setDraftId(int draftId) {
		this.draftId = draftId;
	}

	public int getStepNumber() {
		return stepNumber;
	}

	public void setStepNumber(int stepNumber) {
		this.stepNumber = stepNumber;
	}

	public String getFieldHtml() {
		return fieldHtml;
	}

	public void setFieldHtml(String fieldHtml) {
		this.fieldHtml = fieldHtml;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getCc() {
		return cc;
	}

	public void setCc(String cc) {
		this.cc = cc;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getIncrement() {
		return increment;
	}

	public void setIncrement(int increment) {
		this.increment = increment;
	}

	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getDocStatus() {
		return docStatus;
	}

	public void setDocStatus(String docStatus) {
		this.docStatus = docStatus;
	}

	public String getIsActivePriority() {
		return isActivePriority;
	}

	public void setIsActivePriority(String isActivePriority) {
		this.isActivePriority = isActivePriority;
	}

	public String getPageHeight() {
		return pageHeight;
	}

	public void setPageHeight(String pageHeight) {
		this.pageHeight = pageHeight;
	}

	public int getNumpages() {
		return numpages;
	}

	public void setNumpages(int numpages) {
		this.numpages = numpages;
	}
	
	
	
}
