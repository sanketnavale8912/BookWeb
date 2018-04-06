package com.drysign.utility;

import java.awt.image.BufferedImage;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletResponse;
import sun.misc.*;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageTree;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.drysign.model.Pixel;

public class ApplicationUtils {
	private static String CERTIFICATE_FILE_PATH;
	private static String CERTIFICATE_PWD_FILE_PATH;

	public ApplicationUtils() {
	
		// TODO Auto-generated constructor stub
		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			
			CERTIFICATE_FILE_PATH=globalfunctions.getCertificatePath();
			CERTIFICATE_PWD_FILE_PATH=globalfunctions.getCertificatePassword();
		} catch (UtilityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public static final String PREFIX = "stream2file";
    public static final String SUFFIX = ".tmp";

    public static File stream2file (InputStream in) throws IOException {
        final File tempFile = File.createTempFile(PREFIX, SUFFIX);
        tempFile.deleteOnExit();
        try (FileOutputStream out = new FileOutputStream(tempFile)) {
            IOUtils.copy(in, out);
        }
        return tempFile;
    }
    
    
//digital signature process
	
	 private static  String KEY_PATH;
	 private static  String KEY_PASSWORD;
	 private static final Logger logger = Logger.getLogger(ApplicationUtils.class);
	 private static BouncyCastleProvider provider = new BouncyCastleProvider();
	/****
	 * 
	 * This API is used for create image of text
	 * 
	 */
	 
	/* public ApplicationUtils() {
		try {
			//KEY_PATH=new GlobalFunctions().getCertificatePath();
			//KEY_PASSWORD=new GlobalFunctions().getCertificatePassword();
		} catch (UtilityException e) {
			logger.error(e.getMessage());
		}
	}*/



   
  
  @SuppressWarnings("null")
public  void createDigitalSignature(File file,File digitaltemp, String envelopeId)
   {
   	
	    File ksFile = new File(CERTIFICATE_FILE_PATH);
	    KeyStore keystore = null ;
	   	   try {
	   		   keystore=KeyStore.getInstance("PKCS12",provider);
			
				char[] pin = CERTIFICATE_PWD_FILE_PATH.toCharArray();
	   	    
				keystore.load(new FileInputStream(ksFile), pin);
				//String digiFilePath=DIGITAL_PATH+digitaltemp;
				DigitalSiganture signing = new DigitalSiganture(keystore, pin.clone());
	   	  
				signing.signPDF(file,digitaltemp,envelopeId);
			} catch (KeyStoreException  | IOException  | NoSuchAlgorithmException | CertificateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
   	    
   }
   
   

  public OutputStream getOutputStream(File f, OutputStream outputStream, InputStream inputStream){
	  int read = 0;
		byte[] bytes = new byte[1024];

		try {
			while ((read = inputStream.read(bytes)) != -1) {

					outputStream.write(bytes, 0, read);
			}
		} catch (IOException e) {
			logger.error("Error while getting outputStream: "+ e);
			e.printStackTrace();
		}
		return outputStream;
  }

    
    
  public static final Pattern VALID_EMAIL_ADDRESS_REGEX = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);

		public static boolean validate(String emailStr) {
			 boolean result = true;
			   try {
			      InternetAddress emailAddr = new InternetAddress(emailStr);
			      emailAddr.validate();
			   } catch (AddressException ex) {
			      result = false;
			   }
			   return result;
		}  
    
    
    public static void writeImageToBrowser(HttpServletResponse response, File f, String fpage)
    {
    	
		try {
			
			PDDocument document = PDDocument.load(f);
			PDFRenderer pdfRenderer = new PDFRenderer(document);
			int pageCounter = Integer.parseInt(fpage)-1;
			
		    // note that the page number parameter is zero based
		    BufferedImage bim = pdfRenderer.renderImageWithDPI(pageCounter, 80, org.apache.pdfbox.rendering.ImageType.RGB);

		    response.setContentType("image/gif");
			OutputStream out = response.getOutputStream();
		    // suffix in filename will be used as the file format
		    //ImageIOUtil.writeImage(bim, "png", out,80);
		    ImageIOUtil.writeImage(bim, "gif", out,50);
			
			document.close();
			response.flushBuffer();
			bim.flush();
			out.flush();
			out.close();
			

		} catch (IOException e) {
			logger.error("Error while reading pdf and converting to image: "+e);
			e.printStackTrace();
		}finally{
			//f.deleteOnExit();
		}
    }

    public static String writeImageToBrowser1(HttpServletResponse response, File f, String fpage) throws IOException
    {
    	PDDocument document=null;
    	String convertImagetoBase64=null;
    	//OutputStream out=null;
		try {
			
			document = PDDocument.load(f);
			PDFRenderer pdfRenderer = new PDFRenderer(document);
			int pageCounter = Integer.parseInt(fpage)-1;
			
		    // note that the page number parameter is zero based
		    BufferedImage bim = pdfRenderer.renderImageWithDPI(pageCounter, 80, org.apache.pdfbox.rendering.ImageType.RGB);
		    
		    convertImagetoBase64=encodeToString(bim,"png");
		    logger.error("success page"+fpage);
		    return convertImagetoBase64;
	
		} catch (Exception e) {
			logger.error("Error while reading pdf and converting to image: "+e);
			e.printStackTrace();
			return "base64error";
		}finally{
			document.close();
			//out.close();
			//f.deleteOnExit();
		}
    }
    

   	public static String encodeToString(BufferedImage image, String type) {
           String imageString = null;
           org.apache.commons.io.output.ByteArrayOutputStream bos = new ByteArrayOutputStream();
    
           try {
               ImageIO.write(image, type, bos);
               byte[] imageBytes = bos.toByteArray();
    
               imageString = new String(Base64.encodeBase64(imageBytes));
    
               bos.close();
           } catch (IOException e) {
               e.printStackTrace();
           }
           return imageString;
       }



	public static Pixel getPageCount(File f) 
	{
		PDDocument document = null;
		int count = 0;
		Pixel p=new Pixel();
		try {
			document = PDDocument.load(f);
			count = document.getNumberOfPages();
			PDPageTree allPages = document.getPages();
			PDPage page = (PDPage) allPages.get(count-1);
			PDRectangle cropBox = page.getCropBox();
			System.out.println("CropBox width"+cropBox.getWidth() + "height"+cropBox.getHeight());
			System.out.println("Width "+page.getMediaBox().getWidth());
			System.out.println("Height "+page.getMediaBox().getHeight());
			p.setPageCount(count);
			p.setHeight(page.getMediaBox().getHeight()/0.75f);
			p.setWidth(page.getMediaBox().getWidth()/0.75f);
			document.close();
		} catch (IOException e) {
			logger.error("Error while getting page numbers: "+e);
			e.printStackTrace();
		}finally{
			//f.deleteOnExit();
			//f.delete();
		}


		return p;
	}
    
    public static String encryptPassword(String password)
    {
    	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    	String hashedPassword = passwordEncoder.encode(password);
		return hashedPassword;
    }
    

    
}
