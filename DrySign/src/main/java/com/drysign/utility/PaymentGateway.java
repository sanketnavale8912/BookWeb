package com.drysign.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Properties;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.drysign.model.banchub.InputContainer;
import com.drysign.model.banchub.Billingaddress;
import com.drysign.model.banchub.Carddetails;
import com.drysign.model.banchub.Header;
import com.drysign.model.banchub.Transactiondetails;

public class PaymentGateway {

	Properties prop = new Properties();
	InputStream input = this.getClass().getClassLoader().getResourceAsStream("commonsutils.properties");
	
	public String accessToken() throws SAXException, ParserConfigurationException 
	{

	   String accessToken = null;
	   
	   try {
		prop.load(input);
		String apikey = prop.getProperty("payment.gateway.apikey");
		String username = prop.getProperty("payment.gateway.username");
		URL url = new URL(prop.getProperty("payment.gateway.url.authorize"));
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setDoOutput(true);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json");
		
		String input = "{\"userdetails\":{\"apikey\":\""+apikey+"\",\"username\": \""+username+"\"}}";

		OutputStream os = conn.getOutputStream();
		os.write(input.getBytes());
		os.flush();
		
		BufferedReader br;
		if (200 <= conn.getResponseCode() && conn.getResponseCode() <= 299) {
		    br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
		} else {
		    br = new BufferedReader(new InputStreamReader((conn.getErrorStream())));
		}		

		String output;
		while ((output = br.readLine()) != null) 
		{
			
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			InputSource src = new InputSource();
			src.setCharacterStream(new StringReader(output));

			Document doc = builder.parse(src);
			accessToken = doc.getElementsByTagName("AuthorizeResponse").item(0).getTextContent();	
		}

		conn.disconnect();

	  } catch (MalformedURLException e) {

		e.printStackTrace();

	  } catch (IOException e) {

		e.printStackTrace();

	 }
	return accessToken;
	}
	
	public String modelPrepare() throws JsonGenerationException, JsonMappingException, IOException, SAXException, ParserConfigurationException
	{
		String accessToken = accessToken();
		prop.load(input);
		Header header = new Header();
		header.setSession_token(accessToken);
		header.setUsername(prop.getProperty("payment.gateway.username"));
		
		Carddetails card = new Carddetails();
		card.setCard_number("4380973488397399");
		card.setCard_present("1");
		card.setCard_type("VISA");
		card.setCardholder_name("aman");
		card.setCvv2("123");
		card.setExpire_month("09");
		card.setExpire_year("19");
		card.setPayment_cardtype("1");
		card.setPayment_intent("0");
		
		Transactiondetails transaction = new Transactiondetails();
		transaction.setTotal_amount("100");
		transaction.setCurrency("USD");
		transaction.setClient_referid("1212121212");
		transaction.setPurchase_level("1");
		transaction.setTransaction_date("2016-11-22 12:22:20.233");
		transaction.setTransaction_description("bill payment");
		
		Billingaddress billing = new Billingaddress();
		billing.setBilling_username("testuser");
		billing.setUser_zip("12345");
		billing.setUser_city("usercity1");
		billing.setUser_state("ST");
		billing.setUser_address1("add1");
		billing.setUser_address2("add2");
		
		InputContainer container = new InputContainer();
		container.setHeader(header);
		container.setCarddetails(card);
		container.setTransactiondetails(transaction);
		container.setBillingaddress(billing);
		
		ObjectMapper mapper = new ObjectMapper();
		
		String jsonString = mapper.writeValueAsString(container);
		System.out.println("Generated JSON jsonString: "+jsonString);
		return jsonString;
		
	}
	
	public void payment()throws SAXException, ParserConfigurationException, JsonGenerationException, JsonMappingException, IOException 
	{

		String modelprepare = modelPrepare();

		try {
			prop.load(input);
			URL url = new URL(prop.getProperty("payment.gateway.url.cardpayment"));
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");			

			OutputStream os = conn.getOutputStream();
			os.write(modelprepare.getBytes());
			os.flush();
			
			BufferedReader br;
			if (200 <= conn.getResponseCode() && conn.getResponseCode() <= 299) {
			    br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			} else {
			    br = new BufferedReader(new InputStreamReader((conn.getErrorStream())));
			}

			

			String output;
			while ((output = br.readLine()) != null) 
			{
				System.out.println("result: "+output);
				
				DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
				InputSource src = new InputSource();
				src.setCharacterStream(new StringReader(output));

				Document doc = builder.parse(src);
				String status = doc.getElementsByTagName("a:status").item(0).getTextContent();
				String transaction_id = doc.getElementsByTagName("a:transaction_id").item(0).getTextContent();
				String error_desc = doc.getElementsByTagName("a:error_desc").item(0).getTextContent();
				System.out.println(status+"\n"+transaction_id+"\n"+error_desc);
			}
			
			conn.disconnect();
		  } catch (MalformedURLException e) 
		{e.printStackTrace();}
		catch (IOException e) 
		{e.printStackTrace();}
		
	
	}
	
	public static void main(String[] args) 
	{
		try {
			new PaymentGateway().payment();
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			
			e.printStackTrace();
		} catch (SAXException e) {
			
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}

}