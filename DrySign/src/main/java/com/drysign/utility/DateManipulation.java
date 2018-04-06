package com.drysign.utility;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class DateManipulation {

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
	
	public float daysCalculation(Timestamp endSubscriptionTime)
	{
		
		
		float days = 0;
		 Date date2 = null;
		 try {
			SimpleDateFormat myFormat = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss");
			java.sql.Timestamp date1 = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
			date2 = myFormat.parse(new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(endSubscriptionTime));			
		    long diff = date2.getTime() - date1.getTime();
		    days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) > 0 ? TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) : 0;
		    //days = days >0 ? days+1 : days + 1;
		} catch (ParseException e) {

				e.printStackTrace();
		}
		return days;
	}
	

}
