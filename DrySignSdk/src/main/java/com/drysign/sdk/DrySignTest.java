package com.drysign.sdk;

import java.util.ArrayList;
import java.util.List;

import com.drysign.sdk.model.Document;
import com.drysign.sdk.model.DocumentField;

public class DrySignTest {

	static String docFilePath = "D:/aman/agreement.pdf";
	
	public void uploadDocument() 
	{
		DrySignClient client = new DrySignClient();
		
		//Field for name
		DocumentField documentField = new DocumentField();
		documentField.setFieldType("text");
		documentField.setFieldName("name");
		documentField.setxPosition(100);
		documentField.setyPosition(100);
		documentField.setFieldHeight(20);
		documentField.setFieldWidth(200);
		documentField.setPageNumber(1);
		
		
		//Field for date
		DocumentField date = new DocumentField();
		date.setFieldType("text");
		date.setFieldName("date");
		date.setxPosition(200);
		date.setyPosition(200);
		date.setFieldHeight(20);
		date.setFieldWidth(200);
		date.setPageNumber(1);
		
		//Field for sign
		DocumentField sign = new DocumentField();
		sign.setFieldType("image");
		sign.setFieldName("sign");
		sign.setxPosition(300);
		sign.setyPosition(300);
		sign.setFieldHeight(40);
		sign.setFieldWidth(200);
		sign.setPageNumber(1);
		
		List<DocumentField> fieldList = new ArrayList<DocumentField>();
		fieldList.add(documentField);
		fieldList.add(date);
		fieldList.add(sign);
		
		Document document = new Document();
		document.setDocumentFields(fieldList);
		document.setFilePath(docFilePath);
		document.setOriginatorEmail("matadeen.sikarawar@banctec.in");
		document.setSignerEmail("anirudh.mahajan@banctec.in");
		document = client.uploadDocument(document);
		
		System.out.println(document);
	}
	
	
	public void createAndUpdateDocument()
	{
		DrySignClient client = new DrySignClient();
		Document document = new Document();
		document.setFilePath(docFilePath);
		
		//create document
		document = client.createDocument(document);
		document.setSignerEmail("anirudh.mahajan@banctec.in");

		System.out.println("EnvelopeID : "+document.getEnvelopeId());
		
		
		//Field for name
		DocumentField documentField = new DocumentField();
		documentField.setFieldType("text");
		documentField.setFieldName("name");
		documentField.setxPosition(100);
		documentField.setyPosition(100);
		documentField.setFieldHeight(20);
		documentField.setFieldWidth(200);
		documentField.setPageNumber(1);
		
		
		//Field for date
		DocumentField date = new DocumentField();
		date.setFieldType("text");
		date.setFieldName("date");
		date.setxPosition(200);
		date.setyPosition(200);
		date.setFieldHeight(20);
		date.setFieldWidth(200);
		date.setPageNumber(1);
		
		//Field for sign
		DocumentField sign = new DocumentField();
		sign.setFieldType("image");
		sign.setFieldName("sign");
		sign.setxPosition(300);
		sign.setyPosition(300);
		sign.setFieldHeight(40);
		sign.setFieldWidth(200);
		sign.setPageNumber(1);
		
		List<DocumentField> fieldList = new ArrayList<DocumentField>();
		fieldList.add(documentField);
		fieldList.add(date);
		fieldList.add(sign);
		document.setDocumentFields(fieldList);
		
		//update Document
		document = client.updateDocument(document);
		System.out.println(document);
		
	}
	
	
	public void downloadDocument(String documentId){
		DrySignClient client = new DrySignClient();
		boolean flag = client.downloadDocument(documentId);
		System.out.println("Download: "+ flag);
	}
	
	
	public void create(){
		DrySignClient client = new DrySignClient();
		Document document = new Document();
		document.setFilePath(docFilePath);
		
		//create document
		document = client.createDocument(document);
		
		System.out.println("EnvelopeID : "+document.getEnvelopeId());
	}
	
	public void update()
	{
		DrySignClient client = new DrySignClient();
		Document document = new Document();
		document.setSignerEmail("anirudh.mahajan@banctec.in");
		document.setFilePath(docFilePath);
		document.setEnvelopeId("eca81efe-b72d-4122-961b-0edc8908c71e");
		//Field for name
		DocumentField documentField = new DocumentField();
		documentField.setFieldType("text");
		documentField.setFieldName("name");
		documentField.setxPosition(100);
		documentField.setyPosition(100);
		documentField.setFieldHeight(20);
		documentField.setFieldWidth(200);
		documentField.setPageNumber(1);
		
		
		//Field for date
		DocumentField date = new DocumentField();
		date.setFieldType("text");
		date.setFieldName("date");
		date.setxPosition(200);
		date.setyPosition(200);
		date.setFieldHeight(20);
		date.setFieldWidth(200);
		date.setPageNumber(1);
		
		//Field for sign
		DocumentField sign = new DocumentField();
		sign.setFieldType("image");
		sign.setFieldName("sign");
		sign.setxPosition(300);
		sign.setyPosition(300);
		sign.setFieldHeight(40);
		sign.setFieldWidth(200);
		sign.setPageNumber(1);
		
		List<DocumentField> fieldList = new ArrayList<DocumentField>();
		fieldList.add(documentField);
		fieldList.add(date);
		fieldList.add(sign);
		document.setDocumentFields(fieldList);
		
		//update Document
		document = client.updateDocument(document);
		System.out.println(document.getStatus());
	}
	
	public void getUsersTest(){
		DrySignClient client = new DrySignClient();
		client.getUsers();
	}
	
	public static void main(String[] args) {
		//new DrySignTest().createAndUpdateDocument(); 
		//new DrySignTest().create();
		//new DrySignTest().uploadDocument();
		//new DrySignTest().getUsersTest();
		new DrySignTest().downloadDocument("bf000632-43c2-4e1b-9c04-423e8c896187");
		
	}
}
