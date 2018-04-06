package com.drysign.utility;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;

import javax.imageio.ImageIO;

/*import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfArray;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;*/
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.PDPageTree;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.web.multipart.MultipartFile;

import com.drysign.model.DocumentField;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfArray;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

import sun.misc.BASE64Decoder;

public class DocUtils {
	private static final Logger logger = Logger.getLogger(DocUtils.class);
	String className = this.getClass().getSimpleName();
	public static final float width = 816f;
	public static final float height = 1056f;
	private static BouncyCastleProvider provider = new BouncyCastleProvider();
	private static String SIGNATURE_PATH ;
	private static String TEMP_FILE_PATH;
	private static String CERTIFICATE_FILE_PATH;
	private static String CERTIFICATE_PWD_FILE_PATH;

	
	public DocUtils() {
		// TODO Auto-generated constructor stub
		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			SIGNATURE_PATH = globalfunctions.getSignaturePath();
			TEMP_FILE_PATH = globalfunctions.getTempAppElectronicSignPdfPath();
			CERTIFICATE_FILE_PATH=globalfunctions.getCertificatePath();
			CERTIFICATE_PWD_FILE_PATH=globalfunctions.getCertificatePassword();
		} catch (UtilityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	public static String encodeFileToBase64Binary(String fileName) throws IOException {
	    File file = new File(fileName);
	    byte[] encoded = Base64.encodeBase64(FileUtils.readFileToByteArray(file));
	    return new String(encoded, StandardCharsets.US_ASCII);
	}

	/***
	 * Resize PDF 
	 * Check File Size 690 * 792
	 * @return
	 * @throws IOException
	 */
	public  Path resizePDF(MultipartFile multipartFile) throws IOException {
		String classMethod = "resizePDF";
		//logger.info(String.format("Enter into " + classMethod + "()"));
		float width = 8.5f * 72;
		float height = 11f * 72;
		float defaultWidth= 612.0f;
		float defaultHeight= 792.0f;
		float tolerance = 1f;
		int pHeight=0;
		int pWidth=0;
		PdfStamper stamper = null;
		
		//write PDF
		Path path1=null;
		
		//PATH : use for write pdf
		Path path=writePDF(multipartFile);
		Path absolutePath = path.toAbsolutePath();
		logger.info("Write Orignal File location "+absolutePath);
		
		/**PdfReader reader = new PdfReader(absolutePath.toString());
		for (int i = 1; i <= reader.getNumberOfPages(); i++) {
			Rectangle cropBox = reader.getCropBox(i);
			//logger.info("Width :"+cropBox.getWidth()+" & Height :"+cropBox.getHeight());
			
			float pdfWidth=cropBox.getWidth();
			float pdfHeight=cropBox.getHeight();
			pHeight=Float.compare(defaultHeight, pdfHeight);
			pWidth=Float.compare(defaultWidth, pdfWidth);
			if(pHeight != 0 && pWidth !=0){
				float widthToAdd = width - cropBox.getWidth();
				float heightToAdd = height - cropBox.getHeight();
				if (Math.abs(widthToAdd) > tolerance || Math.abs(heightToAdd) > tolerance) {
					float[] newBoxValues = new float[] { cropBox.getLeft() - widthToAdd / 2,
							cropBox.getBottom() - heightToAdd / 2, cropBox.getRight() + widthToAdd / 2,
							cropBox.getTop() + heightToAdd / 2 };
					PdfArray newBox = new PdfArray(newBoxValues);
					PdfDictionary pageDict = reader.getPageN(i);
					pageDict.put(PdfName.CROPBOX, newBox);
					pageDict.put(PdfName.MEDIABOX, newBox);
				}
			}
		}
		try {
			//create TEMP File with random
			if(pHeight != 0 && pWidth !=0){
				String uniqueNumber = new GlobalFunctions().uniqueToken();
				
				//PATH1: use for resize PDF
				path1= Paths.get(TEMP_FILE_PATH+uniqueNumber+".pdf");
			    Path absolutePath1 = path1.toAbsolutePath();
				//write PDF 8.5* 11
				stamper = new PdfStamper(reader, new FileOutputStream(absolutePath1.toString()));
				stamper.close();
				
				logger.info("Write 8.5*11 File "+path1.toAbsolutePath());
				
				//Delete Path
				deletePDF(path);
				
				//get BYTE
				return path1;
			}
			
		} catch (DocumentException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		logger.info(String.format("Exit into " + classMethod + "()"));
		return path;

	}
	

	/***
	 * Write PDF using NIO
	 * @param buff
	 * @param multipartFile
	 * @return
	 */
	public static Path writePDF(MultipartFile multipartFile) {
		String classMethod = "writePDF";
		logger.info(String.format("Enter into " + classMethod + "()"));
		Path path = null;
		try {
			path = Files.createTempFile(multipartFile.getName(), ".pdf");
			Files.write(path, multipartFile.getBytes());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.info("Temp file : " + path);
		logger.info(String.format("Exit into " + classMethod + "()"));
		return path;
	}

	
	/***
	 * Delete PDF using NIO
	 * @param path
	 */
	public static void deletePDF(Path path) {
		String classMethod = "deletePDF";
		logger.info(String.format("Enter into " + classMethod + "()"));
		try {
			//Files.deleteIfExists(path);
			
			Files.delete(path);    
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.info(String.format("Exit into " + classMethod + "()"));
	}
	
	/***
	 * @author Sanket.Navale
	 * Get Page Number from Pixels
	 * @param position
	 * @return
	 */
	public int getPageNumber(float position,String height){
		float f = Float.parseFloat(height);
		int total= (int) (position / f) ;
		/*String string_temp = new Float(total).toString();
		String string_form = string_temp.substring(0,string_temp.indexOf('.'));
		int pageNo = Integer.valueOf(string_form);
		return pageNo;*/
		return total;
		
	}
	
	/**
	 * Modified Top Position based on Page Number 
	 * @author Sanket.Navale
	 * @param pageNo
	 * @param YPosition
	 * @return
	 */
	public float getTopPosition(int pageNo,float YPosition,String height){
		float fYPosition=YPosition-(pageNo*Float.parseFloat(height));
		return fYPosition;
		
	}
	
	/**
	 * Modify Signature Base64  
	 * @author Sanket.Navale
	 * @param mySignature
	 * @return
	 */
	public  String modifySignatureData(String mySignature) {
		String removeString = null, modifyString = null, LastString = null;
		removeString = mySignature.substring(22); 
		modifyString = removeString.substring(0, removeString.length() - 1);
		LastString = modifyString.replace(' ', '+'); 
		return LastString;
	}
	
	/***
	 * create signature image using base64 to PNG
	 * 
	 * @author Sanket.Navale
	 * @param mySignature
	 * @throws IOException
	 */
	/*public String createSignature(String mySignature) throws IOException {
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
	}*/
	public String createSignature(String mySignature,int width,int height) throws IOException {
		String filePath = SIGNATURE_PATH +"signature_" + new Date().getTime() + ".png";
		byte[] imageByteArray = decodeImage1(mySignature);
		FileOutputStream imageOutFile = new FileOutputStream(filePath);
		imageOutFile.write(imageByteArray);
		imageOutFile.close();
        try {
        BufferedImage image = ImageIO.read(new File(
                            filePath));
               ImageIO.write(ImageResizer.resizeTrick(image, width, height), "png",
                            new File(filePath));
        } catch (IOException e) {
               e.printStackTrace();
        }

		return filePath;
	}
	
	 /**
     * Decodes the base64 string into byte array
     *
     * @param imageDataString - a {@link java.lang.String}
     * @return byte array
     */
    public static byte[] decodeImage1(String imageDataString) {
		return Base64.decodeBase64(imageDataString);
	}
    
    public String writeDocumentFields(List<DocumentField> documentField,File file, File outputFile) throws IOException  
	{
		logger.info("[Start] SelfSign selfSignManipulatePdf >>>>");
		
		/*PDDocument doc = PDDocument.load(file);
		PDFont font = PDType1Font.HELVETICA;
		
		PDPageContentStream contentStream=null;
		for(DocumentField df:documentField){
			 
			PDPageTree allPages = doc.getPages();
			PDPage page = (PDPage) allPages.get(df.getPageNumber());
			//df.setyPosition(page.getMediaBox().getHeight()/(height / Float.parseFloat(((DocumentField) df).getTop())));
    		//df.setxPosition(page.getMediaBox().getWidth()/(width / Float.parseFloat(((DocumentField) df).getLeft())));
			
    		
			if(df.getFieldType().equals("image")){
				String image = df.getFieldValue();
				@SuppressWarnings("unused")
				BufferedImage awtImage;
				PDImageXObject ximage = null;
				ximage = PDImageXObject.createFromFile(image,doc);
				float scale = 1.2f;
                PDPageContentStream contentStream1 = new PDPageContentStream(doc, page, true, false);
                df.setyPosition((Float.parseFloat(((DocumentField) df).getTop())+52f)*.75f);
        		df.setxPosition(Float.parseFloat(((DocumentField) df).getLeft())*.75f);
                float y=page.getMediaBox().getHeight() - df.getyPosition();
               
                contentStream1.drawXObject(ximage, df.getxPosition(),y , 87*scale, 25*scale);
				contentStream1.close();
			}else if(df.getFieldType().equals("checkbox")){
				String image = df.getFieldValue();
				@SuppressWarnings("unused")
				BufferedImage awtImage;
				PDImageXObject ximage = null;
				ximage = PDImageXObject.createFromFile(image,doc);
				float scale = 1.2f;
                PDPageContentStream contentStream1 = new PDPageContentStream(doc, page, true, false);
                df.setyPosition((Float.parseFloat(((DocumentField) df).getTop())+65f)*.75f);
        		df.setxPosition(Float.parseFloat(((DocumentField) df).getLeft())*.75f);
                //float y=(792f - 32.5f) - df.getyPosition();
                //float y=792f - df.getyPosition();
                float y=page.getMediaBox().getHeight() - df.getyPosition();
                contentStream1.drawXObject(ximage, df.getxPosition(),y , 12*scale, 15*scale);
				contentStream1.close();
			}else{
				contentStream = new PDPageContentStream(doc, page, true, false);
				contentStream.setNonStrokingColor(0,0,0);
				contentStream.beginText();
				contentStream.setFont(font, 10);
				//float y=(792f - 36f) - df.getyPosition();
				df.setyPosition((Float.parseFloat(((DocumentField) df).getTop())+36.5f)*.75f);
	    		df.setxPosition(Float.parseFloat(((DocumentField) df).getLeft())*.75f);
				float y=page.getMediaBox().getHeight() - df.getyPosition();
				contentStream.moveTextPositionByAmount(df.getxPosition(), y);
				contentStream.drawString(df.getFieldValue());
				contentStream.endText();
				contentStream.close();
			}
		}
		doc.save(file);
		doc.close();*/
		
		try {
		PdfReader pdfReader = new PdfReader(file.getAbsolutePath());
        PdfStamper pdfStamper = new PdfStamper(pdfReader,new FileOutputStream(outputFile));
	
		for(DocumentField df:documentField){
		  int pageNumber = df.getPageNumber()+1;
		  PdfContentByte content = pdfStamper.getOverContent(pageNumber);
		  Rectangle mediabox = pdfReader.getPageSize(pageNumber); 
		  
			if(df.getFieldType().equals("image")){
				df.setyPosition((Float.parseFloat(((DocumentField) df).getTop())+52f)*.75f);
        		df.setxPosition(Float.parseFloat(((DocumentField) df).getLeft())*.75f);
        		
        		float y=mediabox.getHeight() - df.getyPosition();
				float scale = 1.2f;
				Image image = Image.getInstance(df.getFieldValue());
				image.scaleToFit(87*scale, 25*scale);
	            image.setAbsolutePosition(df.getxPosition(), y);
	            content.addImage(image);

			}else if(df.getFieldType().equals("checkbox")){
				
				df.setyPosition((Float.parseFloat(((DocumentField) df).getTop())+65f)*.75f);
        		df.setxPosition(Float.parseFloat(((DocumentField) df).getLeft())*.75f);
        		
        		float y=mediabox.getHeight() - df.getyPosition();
				float scale = 1.2f;
				Image image = Image.getInstance(df.getFieldValue());
				image.scaleToFit(12*scale, 15*scale);
	            image.setAbsolutePosition(df.getxPosition(),y);
	            content.addImage(image);
        		
			}else{
				df.setyPosition((Float.parseFloat(((DocumentField) df).getTop())+36.5f)*.75f);
	    		df.setxPosition(Float.parseFloat(((DocumentField) df).getLeft())*.75f);
	    		float y=mediabox.getHeight() - df.getyPosition();
	    		
	    		BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED);
                content.beginText();
                content.setFontAndSize(bf, 12);
                content.moveText(df.getxPosition(), y);
                content.showText(df.getFieldValue());
                content.endText();
			}
		}	     
		pdfStamper.close();

        } catch (IOException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
		String result = outputFile.getAbsolutePath();
		return result;	
	}	
    
    public  void createDigitalSignature() throws KeyStoreException, NoSuchAlgorithmException, CertificateException, FileNotFoundException, IOException{

        File ksFile = new File(CERTIFICATE_FILE_PATH);
        KeyStore keystore = KeyStore.getInstance("PKCS12", provider);
        //char[] pin = "Drysign2016".toCharArray();
        char[] pin = CERTIFICATE_PWD_FILE_PATH.toCharArray();
        keystore.load(new FileInputStream(ksFile), pin);
    }
    
    public List<Signer> removeDuplicateSignerData(List<DocumentField> doc){
    	List<Signer> signerList=new ArrayList<Signer>();
    	
	    	for(DocumentField d:doc){
	    		Signer s=new Signer();
	    		s.setPriority(d.getPriority());
	    		s.setSignerName(d.getSignerName());
	    		s.setSignerEmail(d.getSignerEmail());
	    		signerList.add(s);
	    	}
	    	
	    	
    	   Set<Signer> s = new TreeSet<Signer>(new Comparator<Signer>() {

    	        @Override
    	        public int compare(Signer o1, Signer o2) {
    	        	return o1.getPriority() -o2.getPriority();
    	        }
    	    });
    	    s.addAll(signerList);
    	    List<Signer> fsignerList=new ArrayList<Signer>(s);
    	   return fsignerList;
    	
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
    
/*    public static InputStream StrToStream(String base64String,String fileName) throws IOException
	{
		
		InputStream is = null;
		File file = null;
		try{
		file = new DocUtils().StrStreamToFile(base64String,fileName);
		is = new BufferedInputStream(new FileInputStream(file));
		}catch(Exception e){
			logger.error("logger while converting file: "+fileName+" to inputStream: "+e);
		}finally{
			if(file != null){file.deleteOnExit();};
		}
		return is;
	}*/

	public String StrStreamToFile(String base64String,String fileName){
		
		logger.info(String.format("StrToStream(base64String = %s, fileName = %s)",base64String,fileName));
		String filePath =TEMP_FILE_PATH+new GlobalFunctions().uniqueToken()+fileName; 		
		
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
		return file.getAbsolutePath();
	}
	
}
