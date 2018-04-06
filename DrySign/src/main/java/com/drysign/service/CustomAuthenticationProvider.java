package com.drysign.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.drysign.dao.DaoException;
import com.drysign.dao.RegistrationDao;
import com.drysign.model.Registration;
import com.drysign.utility.ApplicationUtils;

@Repository
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	private RegistrationDao registerDao;

	private static final Logger logger = Logger.getLogger(CustomAuthenticationProvider.class);

	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		BCryptPasswordEncoder enc = new BCryptPasswordEncoder();

		UsernamePasswordAuthenticationToken auth = (UsernamePasswordAuthenticationToken) authentication;
		String username = String.valueOf(auth.getPrincipal());
		String password = String.valueOf(auth.getCredentials());
		// password = ApplicationUtils.encryptPassword(password);
		logger.info(String.format("authenticate(username=%s)", username));

		if (username == null || username.isEmpty()) {
			throw new BadCredentialsException(username + ",Please enter a valid email ID/password.");
		} else if (!ApplicationUtils.validate(username)) {
			throw new BadCredentialsException(username + ",Please enter a valid email ID.");
		} else if (password == null || password.isEmpty()) {
			throw new BadCredentialsException(username + ",Please enter a valid password.");
		}

		Registration registration = null;
		try {
			registration = registerDao.loginCall(username);
		} catch (DaoException e) {
			logger.error(e.getMessage());
			throw new BadCredentialsException(username + "," + e.getMessage());

		}

		if (registration == null || registration.equals(null)) {
			throw new BadCredentialsException(username + ",Invalid credentials.");
		} else if (registration.getStatus() == 0) {
			throw new BadCredentialsException(username + ",Your Account is Inactive Please verify from email.");
		} else if (!enc.matches(password, registration.getPassword())) {
			throw new BadCredentialsException(username + ",Incorrect password.");
		} else if (registration.getStatus() == 1) {
			List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
			/*
			 * grantedAuths.add(new
			 * SimpleGrantedAuthority(registration.getRole()));
			 */
			if (registration.getRole().equals("ROLE_USER")) {
				grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));
			} else if (registration.getRole().equals("ROLE_APP")) {
				grantedAuths.add(new SimpleGrantedAuthority("ROLE_APP"));
				grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));
			} else if (registration.getRole().equals("ROLE_ADMIN")) {
				grantedAuths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
			}

			Authentication authenticate = new UsernamePasswordAuthenticationToken(registration,
					registration.getPassword(), grantedAuths);
			return authenticate;

		} else {
			throw new BadCredentialsException(username + ",Bad Credentials");
		}
	}

	public boolean supports(Class<?> authentication) {

		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
