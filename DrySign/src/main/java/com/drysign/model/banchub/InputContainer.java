package com.drysign.model.banchub;

public class InputContainer {
	
	private Header header;
	private Carddetails carddetails;
	private Transactiondetails transactiondetails;
	private Billingaddress billingaddress;
	public Header getHeader() {
		return header;
	}
	public void setHeader(Header header) {
		this.header = header;
	}
	public Carddetails getCarddetails() {
		return carddetails;
	}
	public void setCarddetails(Carddetails carddetails) {
		this.carddetails = carddetails;
	}
	public Transactiondetails getTransactiondetails() {
		return transactiondetails;
	}
	public void setTransactiondetails(Transactiondetails transactiondetails) {
		this.transactiondetails = transactiondetails;
	}
	public Billingaddress getBillingaddress() {
		return billingaddress;
	}
	public void setBillingaddress(Billingaddress billingaddress) {
		this.billingaddress = billingaddress;
	}
	@Override
	public String toString() {
		return "InputContainer [header=" + header + ", carddetails=" + carddetails + ", transactiondetails="
				+ transactiondetails + ", billingaddress=" + billingaddress + "]";
	}
	
	

}
