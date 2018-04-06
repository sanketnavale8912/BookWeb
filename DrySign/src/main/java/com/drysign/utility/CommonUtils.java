package com.drysign.utility;

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

import org.apache.commons.codec.binary.Base64;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
public class CommonUtils 
{	
	 static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	 static SecureRandom rnd = new SecureRandom();
	 
	public static Timestamp currentDate() {
		java.util.Date utilDate = new java.util.Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(utilDate);
		cal.set(Calendar.MILLISECOND, 0);
		return new java.sql.Timestamp(utilDate.getTime());
	}

	 public static String randomString( int len ){
		   StringBuilder sb = new StringBuilder( len );
		   for( int i = 0; i < len; i++ ) 
		      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
		   return sb.toString();
		} 
	 public static Timestamp addDays(int days) 
		{
			java.sql.Timestamp ts = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
			Calendar cal = Calendar.getInstance();
			cal.setTime(ts);
			cal.add(Calendar.DAY_OF_WEEK, days);
			ts.setTime(cal.getTime().getTime()); // or
			ts = new Timestamp(cal.getTime().getTime());
			return ts;
		}
	 
	 public static boolean equalLists(List<String> one, List<String> two){     
		    if (one == null && two == null){
		        return true;
		    }

		    if((one == null && two != null) 
		      || one != null && two == null
		      || one.size() != two.size()){
		        return false;
		    }

		    //to avoid messing the order of the lists we will use a copy
		    //as noted in comments by A. R. S.
		    one = new ArrayList<String>(one); 
		    two = new ArrayList<String>(two);   

		    Collections.sort(one);
		    Collections.sort(two);      
		    return one.equals(two);
		}
	 

	  /**
    * Encodes the byte array into base64 string
    *
    * @param imageByteArray - byte array
    * @return String a {@link java.lang.String}
    */
   public static String encodeImage(byte[] imageByteArray) {
       return Base64.encodeBase64URLSafeString(imageByteArray);
   }

   /**
    * Decodes the base64 string into byte array
    *
    * @param imageDataString - a {@link java.lang.String}
    * @return byte array
    */
   public static byte[] decodeImage(StringBuilder imageDataString) {
   	
       return Base64.decodeBase64(imageDataString.toString());
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
   
   
   public BufferedImage convertTextToGraphic(String text, Font font) 
	{
		//logger.info(String.format("convertTextToGraphic(String text = %s, Font font = %s)", text,font));
		
		/*GraphicsEnvironment ge = null;
	    try{
	      ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
	      ge.registerFont(Font.createFont(Font.TRUETYPE_FONT, new File("https://fonts.googleapis.com/css?family=Dancing+Script")));
	    } catch(FontFormatException e){} catch (IOException e){}*/
		
       BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
       Graphics2D g2d = img.createGraphics();

       g2d.setFont(font);
       FontMetrics fm = g2d.getFontMetrics();
       int width = fm.stringWidth(text);
       int height = fm.getHeight();
       g2d.dispose();

       img = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);

       g2d = img.createGraphics();
       g2d.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION, RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
       g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
       g2d.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING, RenderingHints.VALUE_COLOR_RENDER_QUALITY);
       g2d.setRenderingHint(RenderingHints.KEY_DITHERING, RenderingHints.VALUE_DITHER_ENABLE);
       g2d.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
       g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
       g2d.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
       g2d.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_PURE);
       g2d.setFont(font);
       fm = g2d.getFontMetrics();
       g2d.setColor(Color.BLACK);
       g2d.drawString(text, 0, fm.getAscent());
       g2d.dispose();
       return img;
   }
   
   /***
	 * @author Sanket.Navale
	 * Load font properties file and get font name
	 * @return
	 * @throws IOException
	 */
	public List<ImageType> getPropValues() throws IOException 
   {
          InputStream inputStream = null;
          List<ImageType> result = new ArrayList<ImageType>();
          try {
                 Properties prop = new Properties();
                 String propFileName = "fonts.properties";

                 inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

                 if (inputStream != null) {
                       prop.load(inputStream);
                 } else {
                       throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
                 }

                 String fonts=prop.getProperty("fonts");
                 if(fonts !=null){
                       
                       String [] fontlist = fonts.split(",");
                       for(int i=0;i<fontlist.length; i++)
                       {
                              result.add(new ImageType(fontlist[i]));
                       }
                       
                       
                 }
                 /*for (int i = 1; i <=6; i++) {
                       result.add(new ImageType(prop.getProperty("fonts" + i)));
                 }*/
                 return result;

          } catch (Exception e) {
                 System.out.println("Exception: " + e);
          } finally {
                 inputStream.close();
          }
          return result;
   }
	
 }
