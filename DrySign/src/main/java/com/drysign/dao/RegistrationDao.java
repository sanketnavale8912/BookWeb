package com.drysign.dao;

import com.drysign.model.Registration;
import com.drysign.model.ResetPassword;



public interface RegistrationDao {

	public int addRegistrationDao(Registration registration) throws DaoException;
	
	public int verifyRegistrationDao(String token, String email) throws DaoException;
	
	public Registration loginCall(String email) throws DaoException;
	
	public boolean checkValidFileDao(String fname, String token, String email) throws DaoException;

	public Registration getUser(String userName) throws DaoException;
	
	public Registration getSettingDetails(String userName) throws DaoException;
	
	public String forgotPassword(String email, String token);
	
	public String checkValidResetPassword(ResetPassword resetPassword);
	
	public int updateResetPassword(ResetPassword resetPassword);
	
	public int updateRegistration(Registration registration) throws DaoException ;
	
	public int updatePassword(Registration registration);
}
