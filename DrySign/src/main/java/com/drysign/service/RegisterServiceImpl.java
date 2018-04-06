package com.drysign.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drysign.dao.DaoException;
import com.drysign.dao.RegistrationDao;
import com.drysign.model.Registration;
import com.drysign.model.ResetPassword;

@Service("registerService")
public class RegisterServiceImpl implements RegisterService {

	@Autowired
	private RegistrationDao registrationDao;
	
	public int addRegistration(Registration registration) throws DaoException {
		
		return registrationDao.addRegistrationDao(registration);
	}

	public int verifyRegistration(String token, String email) throws DaoException {
		
		return registrationDao.verifyRegistrationDao(token,email);
	}


	public boolean checkValidFile(String fname, String token, String email) throws DaoException {
	
		return registrationDao.checkValidFileDao(fname,token,email);
	}

	@Override
	public Registration getUser(String userName) throws DaoException {
		
		return registrationDao.getUser(userName);
	}

	@Override
	public Registration loginCall(String email) throws DaoException {
		// TODO Auto-generated method stub
		return registrationDao.loginCall(email);
	}
	
	@Override
	public String forgotPassword(String email, String token) {
		
		return registrationDao.forgotPassword(email, token);
	}

	@Override
	public String checkValidResetPassword(ResetPassword resetPassword) {
		// TODO Auto-generated method stub
		return registrationDao.checkValidResetPassword(resetPassword);
	}

	@Override
	public int updateResetPassword(ResetPassword resetPassword) {
		// TODO Auto-generated method stub
		return registrationDao.updateResetPassword(resetPassword);
	}

	@Override
	public int updateRegistration(Registration registration) throws DaoException {
		// TODO Auto-generated method stub
		return registrationDao.updateRegistration(registration);
	}

	@Override
	public int updatePassword(Registration registration) {
		// TODO Auto-generated method stub
		return registrationDao.updatePassword(registration);
	}

	@Override
	public Registration getSettingDetails(String userName) throws DaoException {
		// TODO Auto-generated method stub
		return registrationDao.getSettingDetails(userName);
	}

}
