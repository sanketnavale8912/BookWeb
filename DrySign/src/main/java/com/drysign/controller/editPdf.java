package com.drysign.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.io.*;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.PDPageTree;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import com.drysign.model.DocumentField;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.*;

public class editPdf {

public static void main(String[] args) throws IOException,
        DocumentException {

    /*PdfReader reader = new PdfReader("D:/aman/a/Accusoft-0001023313.pdf");
    PdfStamper stamper = new PdfStamper(reader, new FileOutputStream("D:/aman/a/Accusoft-0001023313_signed.pdf"));
    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252,
            BaseFont.NOT_EMBEDDED);

        PdfContentByte over = stamper.getOverContent(1);

        over.beginText();
        over.setFontAndSize(bf, 10);
        over.setTextMatrix(107, 107);
        over.showText("page updated");
        over.endText();

    stamper.close();*/
    
    
    PDDocument doc = PDDocument.load(new File("D:/aman/a/Accusoft-0001023313.pdf"));
    PDFont font = PDType1Font.TIMES_BOLD;
    PDPageTree allPages = doc.getPages();
    PDPage page = (PDPage) allPages.get(0);
    PDPageContentStream contentStream=null;
    
    contentStream = new PDPageContentStream(doc, page, true, false);
	contentStream.setNonStrokingColor(0,0,0);
	contentStream.beginText();
	contentStream.setFont(font, 10);
	//float y=(792f - 36f) - df.getyPosition();
	
	contentStream.moveTextPositionByAmount(107, 107);
	contentStream.drawString("aman sikarawr");
	contentStream.endText();
	contentStream.close();
    
    
    
	doc.save(new File("D:/aman/a/Accusoft(1).pdf"));
	doc.close();
    
    
}

public void drawString(Graphics g, int x, int y){
    g.setFont(new Font("Courier New", Font.PLAIN, 16));
    g.setColor(Color.BLACK);
    g.drawString("Test test test test test", x, y);
}


}