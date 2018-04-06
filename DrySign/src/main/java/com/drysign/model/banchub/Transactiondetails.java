package com.drysign.model.banchub;

public class Transactiondetails {

	private String total_amount;
	private String currency;
	private String client_referid;
	private String purchase_level;
	private String transaction_date;
	private String transaction_description;
	public String getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(String total_amount) {
		this.total_amount = total_amount;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getClient_referid() {
		return client_referid;
	}
	public void setClient_referid(String client_referid) {
		this.client_referid = client_referid;
	}
	public String getPurchase_level() {
		return purchase_level;
	}
	public void setPurchase_level(String purchase_level) {
		this.purchase_level = purchase_level;
	}
	public String getTransaction_date() {
		return transaction_date;
	}
	public void setTransaction_date(String transaction_date) {
		this.transaction_date = transaction_date;
	}
	public String getTransaction_description() {
		return transaction_description;
	}
	public void setTransaction_description(String transaction_description) {
		this.transaction_description = transaction_description;
	}
	@Override
	public String toString() {
		return "Transactiondetails [total_amount=" + total_amount + ", currency=" + currency + ", client_referid="
				+ client_referid + ", purchase_level=" + purchase_level + ", transaction_date=" + transaction_date
				+ ", transaction_description=" + transaction_description + "]";
	}
	
	
}
