package com.drysign.model.banchub;

public class Carddetails {

	private String card_number;
	private String card_present;
	private String card_type;
	private String cardholder_name;
	private String cvv2;
	private String expire_month;
	private String expire_year;
	private String payment_cardtype;
	private String payment_intent;
	public String getCard_number() {
		return card_number;
	}
	public void setCard_number(String card_number) {
		this.card_number = card_number;
	}
	public String getCard_present() {
		return card_present;
	}
	public void setCard_present(String card_present) {
		this.card_present = card_present;
	}
	public String getCard_type() {
		return card_type;
	}
	public void setCard_type(String card_type) {
		this.card_type = card_type;
	}
	public String getCardholder_name() {
		return cardholder_name;
	}
	public void setCardholder_name(String cardholder_name) {
		this.cardholder_name = cardholder_name;
	}
	public String getCvv2() {
		return cvv2;
	}
	public void setCvv2(String cvv2) {
		this.cvv2 = cvv2;
	}
	public String getExpire_month() {
		return expire_month;
	}
	public void setExpire_month(String expire_month) {
		this.expire_month = expire_month;
	}
	public String getExpire_year() {
		return expire_year;
	}
	public void setExpire_year(String expire_year) {
		this.expire_year = expire_year;
	}
	public String getPayment_cardtype() {
		return payment_cardtype;
	}
	public void setPayment_cardtype(String payment_cardtype) {
		this.payment_cardtype = payment_cardtype;
	}
	public String getPayment_intent() {
		return payment_intent;
	}
	public void setPayment_intent(String payment_intent) {
		this.payment_intent = payment_intent;
	}
	@Override
	public String toString() {
		return "Carddetails [card_number=" + card_number + ", card_present=" + card_present + ", card_type=" + card_type
				+ ", cardholder_name=" + cardholder_name + ", cvv2=" + cvv2 + ", expire_month=" + expire_month
				+ ", expire_year=" + expire_year + ", payment_cardtype=" + payment_cardtype + ", payment_intent="
				+ payment_intent + "]";
	}
	
		
}
