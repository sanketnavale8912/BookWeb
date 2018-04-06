package com.drysign.model;

import java.sql.Timestamp;

public class SB_Duration {
	
	private int duration_id;
	
	private String name;
	
	private String time;
	
	private String unit;
	private int status;
	private Timestamp createdDate;
	private Timestamp updatedDate;

	public int getDuration_id() {
		return duration_id;
	}

	public void setDuration_id(int duration_id) {
		this.duration_id = duration_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}

	@Override
	public String toString() {
		return "Duration [duration_id=" + duration_id + ", name=" + name + ", time=" + time + ", unit=" + unit
				+ ", status=" + status + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + "]";
	}

	
		

}
