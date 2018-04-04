package com.drysign.utility;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateManipulation {
	
	public static Timestamp currentDate()
	{
		java.util.Date date= new java.util.Date();
		java.sql.Timestamp ts = new Timestamp(date.getTime());
		Calendar cal = Calendar.getInstance();
		cal.setTime(ts);
		ts.setTime(cal.getTime().getTime());
		return ts;
	}
	public Timestamp getMyDate()
	{
		java.util.Date date= new java.util.Date();
		java.sql.Timestamp ts = new Timestamp(date.getTime());
		Calendar cal = Calendar.getInstance();
		cal.setTime(ts);
		ts.setTime(cal.getTime().getTime());
		return ts;
	}
	
	public Timestamp getMyDate(int days)
	{
		java.util.Date date= new java.util.Date();
		java.sql.Timestamp ts = new Timestamp(date.getTime());
		Calendar cal = Calendar.getInstance();
		cal.setTime(ts);
		cal.add(Calendar.DATE, days);
		ts.setTime(cal.getTime().getTime());
		return ts;
	}
	
	public  static String currentDateOnly(){
		
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date date = new Date();
		return dateFormat.format(date);
	}
	
	
}
