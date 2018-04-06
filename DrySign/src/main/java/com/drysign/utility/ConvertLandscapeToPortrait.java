package com.drysign.utility;

import java.io.FileOutputStream;
import java.io.IOException;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;

public class ConvertLandscapeToPortrait {
	public static void main(String[] args) throws IOException, DocumentException {
		
		PdfReader reader = new PdfReader("D:/SQ12168.pdf");
		Rectangle pagesize = new Rectangle(
			        PageSize.A4.getWidth() * 4,
			        PageSize.A4.getHeight() * 2);
	    Document document = new Document(pagesize);
	    // step 2
	    PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("D:/target.pdf"));
	    document.open();
		document.close();
		reader.close();
	}
}
