package com.drysign.utility;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.nio.file.Files;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.cert.CertificateException;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.imageio.ImageIO;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentCatalog;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.PDPageTree;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;
import org.bouncycastle.jce.provider.BouncyCastleProvider;

import com.drysign.controller.JerseyFileUpload;
import com.drysign.model.BackgroundSignDocument;
import com.drysign.model.BackgroundSignFields;
import com.drysign.model.DocumentField;
import com.drysign.model.RestDocument;
import com.drysign.model.RestDocumentField;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

import sun.misc.BASE64Decoder;

public class FileUtils {

	
	private static String TEMP_FILE_PATH;
	private static String CERTIFICATE_FILE_PATH;
	private static String CERTIFICATE_PWD_FILE_PATH;
	private static String SIGNATURE_PATH ;
	private final static Logger logger = Logger.getLogger(FileUtils.class);
	private static BouncyCastleProvider provider = new BouncyCastleProvider();
	public FileUtils() {
		try {
			CERTIFICATE_FILE_PATH=new GlobalFunctions().getCertificatePath();
			CERTIFICATE_PWD_FILE_PATH=new GlobalFunctions().getCertificatePassword();
			TEMP_FILE_PATH = new GlobalFunctions().getTemporaryFilePath();
			SIGNATURE_PATH = new GlobalFunctions().getSignaturePath();
		} catch (UtilityException e) {
			logger.error("Error while getting upload path: "+e.getMessage());
		}
	}
	//**************************************************************************Util methods***************************************************/	

	
	

	
	public String validateDocument(RestDocument document) 
	{
		String message = "success";
		
		if(document != null && document.getDocumentFields() != null)
		{
			if(document.getOriginatorEmail() ==null )
			{
				message = "Originator email cannot be empty.";
			}else if(document.getSignerName() == null)
			{
				message ="Signer name cannot be empty.";
			}
			else if(!ApplicationUtils.validate(document.getOriginatorEmail()))
			{
				message = "Originator email not valid.";
			}else if(document.getSignerEmail() == null)
			{
				message = "Signer email cannot be empty.";
			}else if(!ApplicationUtils.validate(document.getSignerEmail()))
			{
				message = "Signer email not valid.";
			}else if(document.getDocumentFields() !=null)
			{
				for(RestDocumentField df : document.getDocumentFields())
		   		 {		 
					if(df.getFieldType() == null && df.getFieldType().isEmpty()){
						message = "Document type can't be null.";
						break;
					}else if(!(df.getPageNumber() > 0 )){
						message = "Document page number must be greater than 0";
						break;
					}else if(df.getxPosition() <= 0){
						message = "Document field x position must be greater than 0";
						break;
					}/*else if(df.getyPosition() <= 0){
						message = "Document field y position must be greater than 0";
						break;
					}*/else if(df.getFieldHeight() < 0){
						message = "Document field height position must be greater than 0";
						break;
					}else if(df.getFieldWidth() < 0 ){
						message = "Document field width position must be greater than 0";
						break;
					}else if(df.getFieldName() == null && df.getFieldName().isEmpty()){
						message = "Field name can't be empty.";
						break;
					}
		   		 }
			}
		}else{
			message = "Document cant be empty.";
		}
		
		return message;
	}
	
	
	public boolean checkValidPdf(String fileName)
	{
		boolean flag = false;
		String extension = "";
		int i = fileName.lastIndexOf('.');
		if (i >= 0) 
		{
			extension = fileName.substring(i + 1);
			if (extension.equals("pdf")) {
				flag = true;
			}
		}

		
		return flag;
	}
	
	public InputStream WriteFile(InputStream fileInputStream,String fileName)
	{
		InputStream inputStream = null; 
		int read = 0;
		byte[] bytes = new byte[1024];
		String filePath =TEMP_FILE_PATH+fileName; 
		
		try{
			File file = new File(filePath);
			OutputStream out = new FileOutputStream(file);
			while ((read = fileInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			out.flush();
			out.close();
			
			if((inputStream = makeFlattenFile(file,fileName)) == null)
			{
				inputStream = new FileInputStream(file);
			}
			
			
			file.deleteOnExit();
		}catch(Exception e){
			logger.error("Error while writing pdf to physical directory: "+e);
		}
		return inputStream;
	}
	
	public String WriteFile1(InputStream fileInputStream,String fileName)
	{
		InputStream inputStream = null; 
		int read = 0;
		byte[] bytes = new byte[1024];
		String filePath =TEMP_FILE_PATH+fileName; 
		File file=null;
		try{
			file = new File(filePath);
			OutputStream out = new FileOutputStream(file);
			while ((read = fileInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			out.flush();
			out.close();
			
			/*if((inputStream = makeFlattenFile(file,fileName)) == null)
			{
				inputStream = new FileInputStream(file);
			}*/
			
			
			file.deleteOnExit();
		}catch(Exception e){
			logger.error("Error while writing pdf to physical directory: "+e);
		}
		return file.getAbsolutePath();
	}
	
  /*  public InputStream writeEnvelopeId(File file, String envelopeId ) throws IOException,  KeyStoreException, NoSuchAlgorithmException, CertificateException, SignatureException
	{

		PDDocument doc = PDDocument.load(file);
		PDFont font = PDType1Font.HELVETICA;
		
		PDPageContentStream contentStream=null;
		
		
		PDPageTree allPages = doc.getPages();
		PDPage page = (PDPage) allPages.get(1-1);
		contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.setNonStrokingColor(0,0,0);
		contentStream.beginText();
		contentStream.setFont(font, 10);

		//contentStream.moveTextPositionByAmount(20, 780);
		contentStream.moveTextPositionByAmount(20, page.getMediaBox().getHeight()-20);
		contentStream.drawString("EnvelopeID:"+envelopeId);
		contentStream.endText();
		contentStream.close();
	
		
		doc.save(file);
		doc.close();
		InputStream is = new FileInputStream(file);
		
		return is;		
	}*/
    
    public String writeEnvelopeId1(File file, File outputFile, String envelopeId ) throws IOException,  KeyStoreException, NoSuchAlgorithmException, CertificateException, SignatureException
   	{

   		/*PDDocument doc = PDDocument.load(file);
   		PDFont font = PDType1Font.HELVETICA;
   		
   		PDPageContentStream contentStream=null;
   		
   		
   		PDPageTree allPages = doc.getPages();
   		PDPage page = (PDPage) allPages.get(1-1);
   		contentStream = new PDPageContentStream(doc, page, true, false);
   		contentStream.setNonStrokingColor(0,0,0);
   		contentStream.beginText();
   		contentStream.setFont(font, 10);

   		//contentStream.moveTextPositionByAmount(20, 780);
   		contentStream.moveTextPositionByAmount(20, page.getMediaBox().getHeight()-20);
   		contentStream.drawString("EnvelopeID:"+envelopeId);
   		contentStream.endText();
   		contentStream.close();
   	
   		
   		doc.save(file);
   		doc.close();*/
   		//InputStream is = new FileInputStream(file);
   		
   		try{
   		PdfReader pdfReader = new PdfReader(file.getAbsolutePath());
        PdfStamper pdfStamper = new PdfStamper(pdfReader,new FileOutputStream(outputFile));
        PdfContentByte content = pdfStamper.getOverContent(1);
		Rectangle mediabox = pdfReader.getPageSize(1); 
		
		BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED);
        content.beginText();
        content.setFontAndSize(bf, 10);
        content.moveText(20, mediabox.getHeight()-20);
        content.showText("EnvelopeID:"+envelopeId);
        content.endText();
        pdfStamper.close();
   		}catch(Exception e){
   			logger.error(""+e);
   		}
   		
   		
   		return outputFile.getAbsolutePath();		
   	}
	
    @SuppressWarnings("unchecked")
	public InputStream makeFlattenFile(File file,String fileName)
    {
    	
    	InputStream newStream = null;
    	
    	try{
	    	PDDocument document = PDDocument.load(file);
			PDPageTree allPages = document.getPages();
			
			PDDocumentCatalog pdCatalog = document.getDocumentCatalog();
			PDAcroForm acroForm = pdCatalog.getAcroForm();
			if(acroForm != null)
			{
				List<PDField> fields = acroForm.getFields();
				
			    for (PDField field : fields) 
			    {
			        field.setReadOnly(true);	       
			    }
			    
			    //start create new document
			    File newFile  = new File(TEMP_FILE_PATH+fileName);
			    PDDocument doc = new PDDocument();
				if(allPages.getCount()>0)
				{
					for(int i=0; i<allPages.getCount(); i++)
					{
						PDPage page = (PDPage) allPages.get(i);	//PDPage page = new PDPage();
						doc.addPage(page);
					}
					doc.save(newFile);
					newStream = new FileInputStream(newFile);
				}
				newFile.deleteOnExit();
				//end create new document
			}else{
				newStream = new FileInputStream(file);
			}
    	}catch(Exception e){
    		logger.error(e);
    	}
    	return newStream;
    }

   

	public static InputStream StrToStream(String base64String,String fileName) throws IOException
	{
		/*logger.info(String.format("StrToStream(base64String = %s, fileName = %s)",base64String,fileName));
		String filePath =TEMP_FILE_PATH+JerseyFileUpload.randomString(25)+fileName; 		
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] decodedBytes= decoder.decodeBuffer(base64String);
		InputStream is = null;
		File file = null ;
		try{
			file = new File(filePath);
			FileOutputStream fop = new FileOutputStream(file);
			fop.write(decodedBytes);
			fop.flush();
			fop.close();
			is = new BufferedInputStream(new FileInputStream(new File(filePath)));
		}catch(Exception e){
			logger.error("Error while writing file filename: "+fileName+" error "+e);
		}finally{
			if(file!=null){file.deleteOnExit();};
		}*/
		InputStream is = null;
		File file = null;
		try{
		file = new FileUtils().StrStreamToFile(base64String,fileName);
		is = new BufferedInputStream(new FileInputStream(file));
		}catch(Exception e){
			logger.error("logger while converting file: "+fileName+" to inputStream: "+e);
		}finally{
			if(file != null){file.deleteOnExit();};
		}
		return is;
	}
	@SuppressWarnings("restriction")
	public File StrStreamToFile(String base64String,String fileName){
		
		logger.info(String.format("StrToStream(base64String = %s, fileName = %s)",base64String,fileName));
		String filePath =TEMP_FILE_PATH+JerseyFileUpload.randomString(25)+fileName; 		
		
		File file = null ;
		try{			
			BASE64Decoder decoder = new BASE64Decoder();
			
			byte[] decodedBytes = decoder.decodeBuffer(base64String);
			
			file = new File(filePath);
			FileOutputStream fop = new FileOutputStream(file);
			fop.write(decodedBytes);
			fop.flush();
			fop.close();
		}catch(Exception e){
			logger.error("Error while writing file filename: "+fileName+" error "+e);
		}finally{
			if(file!=null){file.deleteOnExit();};
		}
		return file;
	}

	public static String signersListValidate(RestDocument document) 
	{
		String signersEmail = document.getSignerEmail();
		String signersName  = document.getSignerName();
		
		String msg = "1";
		if(signersEmail ==null || signersEmail.isEmpty())
		{
			msg = "Kindly provide signers email list with comma seperated.";
		}else if(signersName ==null || signersName.isEmpty())
		{
			msg = "Kindly provide signers email list with comma seperated.";
		}else
		{
			List<String> signersEmailList = Arrays.asList(signersEmail.split(","));
			List<String> signersNameList = Arrays.asList(signersName.split(","));
			signersEmailList.removeAll(Collections.singleton(null));
			signersNameList.removeAll(Collections.singleton(null));
			
			if(signersEmailList == null || signersEmailList.isEmpty())
			{
				msg = "Kindly provide signers email list with comma seperated.";
			}
			else if(signersNameList == null || signersNameList.isEmpty())
			{
				msg = "Kindly provide signers name list with comma seperated.";
			}else if(signersEmailList.size() != signersNameList.size()){
				msg = "Kindly provide signers email and name in the same count.";
			}else
			{
				for(String email: signersEmailList)
				{
					if(!ApplicationUtils.validate(email))
					{
						msg = "Not a valid signer email: "+email;
						break;
					}
				}
				
			}
		}
		return msg;
	}
    
    public File tempFile() throws IOException
    {
    	Properties prop = new Properties();
		InputStream input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
		prop.load(input);
		String tempFileName = new GlobalFunctions().uniqueToken()+".pdf";
		File outputFile = new File(prop.getProperty("temp.files")+tempFileName);
		return outputFile;
    }





	public static String validateBackgroundDoc(BackgroundSignDocument document)
	{
		String documentName = document.getDocumentName();
		String fileBase64String  = document.getFileBase64String();
		
		String msg = "1";
		if(documentName ==null || documentName.isEmpty())
		{
			msg = "Kindly provide document name.";
		}else if(fileBase64String ==null || fileBase64String.isEmpty())
		{
			msg = "Kindly provide document base64 string.";
		}else
		{
			List<BackgroundSignFields> signFields = document.getDocumentFields();
			
			
			if(signFields == null || signFields.isEmpty())
			{
				msg = "Kindly provide signers email list with comma seperated.";
			}
			else
			{	boolean flag = true;
				for(BackgroundSignFields signField: signFields)
				{
					
					if(!ApplicationUtils.validate(signField.getSignerEmail()))
					{
						msg = "Not a valid signer email: "+signField.getSignerEmail();
						flag = false;
						break;
					}
					if(signField.getSignerName() ==null || signField.getSignerName().isEmpty()){
						msg = "Not a valid signer name of signer : "+signField.getSignerEmail();
						flag = false;
						break;
					}
					/*if(signField.getPageNumber() ==0){
						msg = "Not a valid page number of signer : "+signField.getSignerEmail();
						break;
					}
					if(signField.getxPosition() <= 0){
						msg = "Kindly provide positive value of x position of signer : "+signField.getSignerEmail();
						break;
					}
					if(signField.getyPosition() <= 0){
						msg = "Kindly provide positive value of y position of signer : "+signField.getSignerEmail();
						break;
					}*/
					
					
					
				}
				if(flag){
					try {
						msg = new FileUtils().dynamicDocumentValidation(document);
					} catch (IOException e) {
						msg = "Error while validation of dynamic document "+e;
						logger.error(msg);
					}
				}
				
			}
		}
		return msg;
	}
	
	/*validate dynamic page number and page size*/	
	public String dynamicDocumentValidation(BackgroundSignDocument document) throws IOException
	{

		String msg = null;
		File file = new FileUtils().StrStreamToFile(document.getFileBase64String(),document.getDocumentName());
		PdfReader pdfReader = new PdfReader(file.getAbsolutePath());
		int pageCount = pdfReader.getNumberOfPages();
		
		for(BackgroundSignFields signField: document.getDocumentFields())
		{
			int pageNumber = signField.getPageNumber();
			if(pageNumber < 1 || pageNumber > pageCount)
			{ 
				msg = "You have provided page number "+pageNumber+" that is not available in your document, Kindly provide page number between 1 and "+ pageCount + " of signer " +signField.getSignerEmail();
				break;
			}
			
			Rectangle mediabox = pdfReader.getPageSize(pageNumber);
			float y = 0;
			float x = 0;
			float mediaX = mediabox.getWidth()/0.75f;
			float mediaY = mediabox.getHeight()/0.75f - 20;
			
			if(signField.getFieldType().equals("image"))
			{
				//signField.setyPosition((signField.getyPosition()+52f)*.75f);
				//signField.setxPosition(signField.getxPosition()*.75f);
	    		y = signField.getyPosition();//mediabox.getHeight() - signField.getyPosition();
	    		x = signField.getxPosition();
			
			}else if(signField.getFieldType().equals("text"))
			{
				//signField.setyPosition((signField.getyPosition()+36.5f)*.75f);
				//signField.setxPosition(signField.getxPosition()*.75f);
	    		y = signField.getyPosition();//mediabox.getHeight() - signField.getyPosition();
	    		x = signField.getxPosition();
			}
			
			if(x < 1 || x > mediaX ){
				msg = "You have provided x position "+x+" that is beyond the page resolution, Kindly provide x position between 1 and "+ mediaX + " of signer " +signField.getSignerEmail();
				break;
			}else if(y < 1 || y > mediaY ){
				msg = "You have provided y position "+y+" that is beyond the page resolution, Kindly provide y position between 1 and "+ mediaY + " of signer " +signField.getSignerEmail();
				break;
			}else{
				msg="1";
			}
				
			
			
		}
		file.deleteOnExit();
		return msg;
	}
	
	
	public  String modifySignatureData(String mySignature) {
		String removeString = null, modifyString = null, LastString = null;
		removeString = mySignature.substring(22); 
		modifyString = removeString.substring(0, removeString.length() - 1);
		LastString = modifyString.replace(' ', '+'); 
		return LastString;
	}
    
	public String createSignature(String mySignature) throws IOException {
		String filePath = SIGNATURE_PATH +"signature_" + new Date().getTime() + ".png";
		byte[] imageByteArray = decodeImage1(mySignature);
		FileOutputStream imageOutFile = new FileOutputStream(filePath);
		imageOutFile.write(imageByteArray);
		imageOutFile.close();
        try {
        BufferedImage image = ImageIO.read(new File(
                            filePath));
               ImageIO.write(ImageResizer.resizeTrick(image, 209, 40), "png",
                            new File(filePath));
        } catch (IOException e) {
               e.printStackTrace();
        }

		return filePath;
	}
	
	   public static byte[] decodeImage1(String imageDataString) {
			return Base64.decodeBase64(imageDataString);
		}
	
    public String writeDocumentFields(List<BackgroundSignFields> documentField,File file, File outputFile) throws IOException  
	{
		logger.info("[Start] writeDocumentFields  >>>>");
		
		try {
		PdfReader pdfReader = new PdfReader(file.getAbsolutePath());
        PdfStamper pdfStamper = new PdfStamper(pdfReader,new FileOutputStream(outputFile));
	
		for(BackgroundSignFields df:documentField){
		  try{
		  int pageNumber = df.getPageNumber();
		  PdfContentByte content = pdfStamper.getOverContent(pageNumber);
		  Rectangle mediabox = pdfReader.getPageSize(pageNumber); 
		  
		  
		  if (df.getFieldType().equalsIgnoreCase("image") || df.getFieldType().equalsIgnoreCase("checkbox")) {
				try {
					String signatureString = modifySignatureData(df.getFieldValue());
					df.setFieldValue(createSignature(signatureString));

				} catch (IOException e) {
					logger.error("Error while converting string to sign: "+e);
				}
			}
		  
		  
			if(df.getFieldType().equals("image")){
				df.setyPosition((df.getyPosition()+20f)*.75f);
        		df.setxPosition(df.getxPosition()*.75f);
        		
        		float y=mediabox.getHeight() - df.getyPosition();
				float scale = 1.2f;
				Image image = Image.getInstance(df.getFieldValue());
				image.scaleToFit(87*scale, 25*scale);
	            image.setAbsolutePosition(df.getxPosition(), y);
	            content.addImage(image);

			}else if(df.getFieldType().equals("checkbox")){
				
				df.setyPosition((df.getyPosition()+20f)*.75f);
        		df.setxPosition(df.getxPosition()*.75f);
        		
        		float y=mediabox.getHeight() - df.getyPosition();
				float scale = 1.2f;
				Image image = Image.getInstance(df.getFieldValue());
				image.scaleToFit(12*scale, 15*scale);
	            image.setAbsolutePosition(df.getxPosition(),y);
	            content.addImage(image);
        		
			}else{
				if("date".equalsIgnoreCase(df.getFieldName()))
				{
					df.setFieldValue(DateManipulation.currentDateOnly());
				}
				df.setyPosition((df.getyPosition()+20f)*.75f);
	    		df.setxPosition(df.getxPosition()*.75f);
	    		float y=mediabox.getHeight() - df.getyPosition();
	    		
	    		BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED);
                content.beginText();
                content.setFontAndSize(bf, 12);
                content.moveText(df.getxPosition(), y);
                content.showText(df.getFieldValue());
                content.endText();
			}
		  }catch(Exception e){
			  logger.error("Error while writing fields into document: "+e +". Document Details: "+df);
		  }
			
		}	     
		pdfStamper.close();

        } catch (Exception e) {
        	logger.error("Error while writing fields into document: "+e +". Document Details: "+documentField);
        } 
		String result = outputFile.getAbsolutePath();
		return result;	
	}	
	

    public  void createDigitalSignature(File file,File digitaltemp, String envelopeId) throws NoSuchAlgorithmException, CertificateException, FileNotFoundException, IOException, KeyStoreException
       {
       		
    	    File ksFile = new File(CERTIFICATE_FILE_PATH);
    	   
    	   	
    	    KeyStore  keystore=KeyStore.getInstance("PKCS12",provider);
    			
			char[] pin = CERTIFICATE_PWD_FILE_PATH.toCharArray();
   	    
			keystore.load(new FileInputStream(ksFile), pin);
			DigitalSiganture signing = new DigitalSiganture(keystore, pin.clone());
   	  
			signing.signPDF(file,digitaltemp,envelopeId);
    			
       	    
       }
    
}
