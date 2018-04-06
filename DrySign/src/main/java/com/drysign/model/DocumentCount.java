package com.drysign.model;

public class DocumentCount {

	private int total;
	private int completed;
	private int outForSignature;
	private int deleted;
	private int draft;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getCompleted() {
		return completed;
	}
	public void setCompleted(int completed) {
		this.completed = completed;
	}
	public int getOutForSignature() {
		return outForSignature;
	}
	public void setOutForSignature(int outForSignature) {
		this.outForSignature = outForSignature;
	}
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
	public int getDraft() {
		return draft;
	}
	public void setDraft(int draft) {
		this.draft = draft;
	}
	
	
}
