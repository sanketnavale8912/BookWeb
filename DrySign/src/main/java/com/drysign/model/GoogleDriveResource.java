package com.drysign.model;

public class GoogleDriveResource {
	
	private String fileId;
	private String fileMimeType;
	private String fileName;
    private String accessToken;
    
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getFileMimeType() {
		return fileMimeType;
	}
	public void setFileMimeType(String fileMimeType) {
		this.fileMimeType = fileMimeType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getAccessToken() {
		return accessToken;
	}
	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}


	
}
