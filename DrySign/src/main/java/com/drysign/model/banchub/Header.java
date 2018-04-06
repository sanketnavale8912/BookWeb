package com.drysign.model.banchub;

public class Header 
{
	private String username;
	private String session_token;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getSession_token() {
		return session_token;
	}
	public void setSession_token(String session_token) {
		this.session_token = session_token;
	}
	@Override
	public String toString() {
		return "Header [username=" + username + ", session_token=" + session_token + "]";
	}
	
	
}
