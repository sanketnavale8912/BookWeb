package com.drysign.sdk.manager;

import com.drysign.sdk.Config;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

public abstract class ConfigureManager {
	private ObjectMapper objectMapper;

	public ConfigureManager() {
		Config.init();
	}

	public ObjectMapper getObjectMapper() {
		this.objectMapper = new ObjectMapper();
		this.objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		return objectMapper;
	}
}
