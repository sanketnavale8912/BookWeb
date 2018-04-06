package com.drysign.sdk.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Oauth2Token {
	@JsonProperty("value")
	private String accessToken;

	@JsonProperty("tokenType")
	private String tokenType;

	@JsonProperty("refresh_token")
	private String refreshToken;

	@JsonProperty("scope")
	private List scope;

	@JsonProperty("expiresIn")
	private int expiresIn;

	public Oauth2Token() {
	}

	public Oauth2Token(String accessToken, String tokenType, String refreshToken, List scope, int expiresIn) {
		this.accessToken = accessToken;
		this.tokenType = tokenType;
		this.refreshToken = refreshToken;
		this.scope = scope;
		this.expiresIn = expiresIn;
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public String getTokenType() {
		return tokenType;
	}

	public void setTokenType(String tokenType) {
		this.tokenType = tokenType;
	}

	public String getRefreshToken() {
		return refreshToken;
	}

	public void setRefreshToken(String refreshToken) {
		this.refreshToken = refreshToken;
	}


	public List getScope() {
		return scope;
	}

	public void setScope(List scope) {
		this.scope = scope;
	}

	public int getExpiresIn() {
		return expiresIn;
	}

	public void setExpiresIn(int expiresIn) {
		this.expiresIn = expiresIn;
	}
}
