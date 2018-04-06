package com.drysign.utility;

public class UtilityException extends Exception{


	private static final long serialVersionUID = -4200840723512234117L;

	public UtilityException() {
	}

	public UtilityException(String message) {
		super(message);
	}

	public UtilityException(Throwable cause) {
		super(cause);
	}

	public UtilityException(String message, Throwable cause) {
		super(message, cause);
	}

	public UtilityException(String message, Throwable cause,
			boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	
}
