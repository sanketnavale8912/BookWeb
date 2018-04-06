package com.drysign.service;

import org.springframework.stereotype.Component;

import com.drysign.dao.DaoException;
import com.drysign.model.Registration;
import com.drysign.model.ResetPassword;

@Component
public interface RegisterService {

	public int addRegistration(Registration registration) throws DaoException ;

	public int verifyRegistration(String token, String email) throws DaoException;

	public boolean checkValidFile(String fname, String token, String email) throws DaoException;

	public Registration getUser(String userName) throws DaoException;
	
	public Registration getSettingDetails(String userName) throws DaoException;
	
	public Registration loginCall(String email) throws DaoException;
	
	public String forgotPassword(String email, String token);
	
	public String checkValidResetPassword(ResetPassword resetPassword);
	
	public int updateResetPassword(ResetPassword resetPassword);
	
	public int updateRegistration(Registration registration) throws DaoException ;
	
	public int updatePassword(Registration registration);
}
