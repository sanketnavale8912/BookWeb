package com.drysign.utility;

import java.io.File; 
import java.io.IOException;
  
import org.apache.pdfbox.pdmodel.PDDocument; 
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageTree;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
public class AddingContent {
   public static void main (String args[])throws IOException  {

      //Loading an existing document
	 //  modifyPDF();
	   checkRotation();
   }
   
   public static  void modifyPDF()throws IOException {
	      File file = new File("D:/admission_form.pdf");
	      PDDocument document = PDDocument.load(file);
	      //Retrieving the pages of the document 
	      //PDPage page = document.getPage(0);
	  	  PDPageTree allPages = document.getPages();
	  	  PDPage page = (PDPage) allPages.get(0);

	     // PDPage page = new PDPage(PDRectangle.A4);
	      page.setRotation(90);
	      document.addPage(page);
	     // PDPageContentStream contentStream = new PDPageContentStream(document, page);
	      
	     

	      //Saving the document
	      document.save(new File("D:/target.pdf"));

	      //Closing the document
	      document.close();
	      System.out.println("DONE!");
	   
   }

	public static void checkRotation() throws IOException {
		File file = new File("D:/PDF_IMP/SQ12168.pdf");
		PDDocument document = PDDocument.load(file);

		// Retrieving the pages of the document
		// PDPage page = document.getPage(0);
		PDPageTree allPages = document.getPages();
		PDPage page = (PDPage) allPages.get(0);

		PDRectangle mediaBox = page.getMediaBox();
		boolean isLandscape = mediaBox.getWidth() > mediaBox.getHeight();
		int rotation = page.getRotation();
		System.out.println(rotation);
		if (rotation == 90 || rotation == 270) {
			isLandscape = !isLandscape;
			System.out.println("Landsacpe: " + isLandscape);

		} else {
			System.out.println("Portrait: " + isLandscape);

		}
		// Saving the document
		// document.save(new File("D:/target.pdf"));

		// Closing the document
		document.close();
		System.out.println("DONE!");

	}
}