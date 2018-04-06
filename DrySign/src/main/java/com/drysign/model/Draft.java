package com.drysign.model;

public class Draft {

	private int draftId;
	private int docId;
	private String url;
	private int stepNumber;
	private int increment;
	
	public int getDraftId() {
		return draftId;
	}
	public void setDraftId(int draftId) {
		this.draftId = draftId;
	}
	public int getDocId() {
		return docId;
	}
	public void setDocId(int docId) {
		this.docId = docId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getStepNumber() {
		return stepNumber;
	}
	public void setStepNumber(int stepNumber) {
		this.stepNumber = stepNumber;
	}
	public int getIncrement() {
		return increment;
	}
	public void setIncrement(int increment) {
		this.increment = increment;
	}
	
	
}
