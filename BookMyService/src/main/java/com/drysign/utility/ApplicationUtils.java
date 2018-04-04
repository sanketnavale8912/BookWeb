package com.drysign.utility;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.cert.CertificateException;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class ApplicationUtils {


	
	
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
	 private static  String DIGITAL_PATH;
	 private static final Logger logger = Logger.getLogger(CommonUtils.class);
	 private static BouncyCastleProvider provider = new BouncyCastleProvider();
	/****
	 * 
	 * This API is used for create image of text
	 * 
	 */
	 
	 public ApplicationUtils() {
		try {
			KEY_PATH=new GlobalFunctions().getCertificatePath();
			DIGITAL_PATH=new GlobalFunctions().getDigitalSignatureFilePath();
		} catch (UtilityException e) {
			logger.error(e.getMessage());
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
    
    
    





	public static int getPageCount(File f) 
	{
		PDDocument document = null;
		int count = 0;
		try {
			document = PDDocument.load(f);
			count = document.getNumberOfPages();
		} catch (IOException e) {
			logger.error("Error while getting page numbers: "+e);
			e.printStackTrace();
		}finally{
			f.deleteOnExit();
		}


		return count;
	}
    
    public static String encryptPassword(String password)
    {
    	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    	String hashedPassword = passwordEncoder.encode(password);
		return hashedPassword;
    }
    

    
}
