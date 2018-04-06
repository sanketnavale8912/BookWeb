package com.drysign.utility;

import java.io.FileOutputStream;
import java.io.IOException;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class PageRotation{

	public static final String DEST = "D:/target.pdf";
	public static final String SRC = "D:/SourceHOV Code of Conduct Acknowledgement.pdf";

	public static void main(String args[]) throws IOException, DocumentException {
		
		Document document = new Document();
		PdfWriter.getInstance(document, new FileOutputStream(DEST));
		document.setPageSize(PageSize.A4);
		 document.open();
		document.add(new Paragraph("Hi in portrait"));
		document.setPageSize(PageSize.A4.rotate());
		document.newPage();
		document.add(new Paragraph("Hi in landscape"));
		document.close();
	}

}
