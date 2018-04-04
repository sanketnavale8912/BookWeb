package com.drysign.dao;

import com.drysign.model.Registration;



public interface RegistrationDao {

	public int addRegistrationDao(Registration registration) throws DaoException;
	
	public int verifyRegistrationDao(String token, String email) throws DaoException;
	
	public Registration loginCall(String email) throws DaoException;
	
	public boolean checkValidFileDao(String fname, String token, String email) throws DaoException;

	public Registration getUser(String userName) throws DaoException;
	
}
