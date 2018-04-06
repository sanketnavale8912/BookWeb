package com.drysign.sdk.service;

import java.io.IOException;
import java.util.List;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Form;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import com.fasterxml.jackson.core.type.TypeReference;
import org.glassfish.jersey.client.ClientConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.drysign.sdk.Config;
import com.drysign.sdk.model.Oauth2Token;
import com.drysign.sdk.model.User;
import com.drysign.sdk.service.IAuthenticationService;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class OAuth2TokenService implements IAuthenticationService {

	final static Logger logger = LoggerFactory.getLogger(OAuth2TokenService.class);
	private ObjectMapper objectMapper;

	public Oauth2Token requestToken(User user) {
		Oauth2Token requestedToken = null;
		String requestBody;
		try {
			requestBody = objectMapper.writeValueAsString(user);
			logger.debug("POSTING to /oauth2/token \n" + requestBody);
			ClientConfig config = new ClientConfig();
			Client client = ClientBuilder.newClient(config);
			WebTarget target = client.target(Config.getApiBase() + "oauth/token");
			Invocation.Builder builder = target.request();
			Form form = new Form();
			form.param("grant_type", "password");
			form.param("username", user.getEmail());
			form.param("password", user.getPassword());
			form.param("client_id", Config.getClientId());
			form.param("client_secret", Config.getClientSecret());
			Response response = builder.accept(MediaType.APPLICATION_JSON)
					.post(Entity.entity(form, MediaType.APPLICATION_FORM_URLENCODED));

			logger.debug("Response body is " + response);
			
			
			requestedToken = objectMapper.readValue(response.readEntity(String.class), Oauth2Token.class);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return requestedToken;
	}
	
	public List<User> getUserList(String requestToken) {
		// TODO Auto-generated method stub
		List<User> user=null;
		
		ClientConfig config = new ClientConfig();
		Client client = ClientBuilder.newClient(config);
		WebTarget target = client.target(Config.getApiBase() + "api/users/");
		Invocation.Builder builder = target.request();
		builder.header("Content-type", MediaType.APPLICATION_JSON);
		builder.header("Authorization", "Bearer " +requestToken);
		/*builder.accept(MediaType.APPLICATION_JSON_TYPE);
		*/
		Response response = builder.get();
				//.post(Entity.entity(form, MediaType.APPLICATION_FORM_URLENCODED));
		System.out.println(response);
		logger.debug("Response body is " + response);
		try {
			TypeReference<List<User>> mapType = new TypeReference<List<User>>() {};
			user = objectMapper.readValue(response.readEntity(String.class), mapType);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return user;
		
		
	}
	
	public ObjectMapper getObjectMapper() {
		return objectMapper;
	}

	public void setObjectMapper(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}



	

}
