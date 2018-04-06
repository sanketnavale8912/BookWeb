package com.drysign.sdk;

import java.util.List;

import com.drysign.sdk.manager.UserManager;
import com.drysign.sdk.model.Oauth2Token;
import com.drysign.sdk.model.User;

public class DrySignTokenTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		User u=new User();
		u.setEmail("anirudh");
		
		UserManager userManager=new UserManager();
		Oauth2Token o=userManager.getToken();
		
		List<User> s=userManager.getMyUserList(o.getAccessToken());
		System.out.println(s.get(0).getEmail());
	
		System.out.println("access_token:"+o.getAccessToken());
		System.out.println("token_type:"+o.getTokenType());
		System.out.println("refresh_token"+o.getRefreshToken());
		System.out.println("expires_in"+o.getExpiresIn());
	}

}
