package com.drysign.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.drysign.model.Registration;
import com.drysign.utility.DateManipulation;

@Repository("registrationDao")
@Transactional
public class RegistrationDaoImpl implements RegistrationDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private Properties queryProps;
	
	
	private final static Logger logger = Logger.getLogger(RegistrationDaoImpl.class);
	
	public int addRegistrationDao(Registration reg) throws DaoException
	{
		logger.info(String.format("addRegistrationDao(reg = %s)", reg));
		try{
		int status = 3;
		String sql=null;
		if(reg.getRole().equalsIgnoreCase("ROLE_USER")){
			sql = queryProps.getProperty("addRegistrationUser");
		}else{
			sql = queryProps.getProperty("addRegistrationOther");
		}
		Integer cnt = jdbcTemplate.queryForObject(queryProps.getProperty("addRegistrationCount"), Integer.class, reg.getEmail());
		if(cnt>0){
			status = 2;
		}else {
			if(reg.getRole().equalsIgnoreCase("ROLE_USER")){
			  status = jdbcTemplate.update(sql, new Object[]{ reg.getFirstName(), reg.getLastname(),reg.getEmail(),reg.getPassword(),reg.getEmail_verification_token(),reg.getUser_type(),reg.getStatus(),reg.getRole(),reg.getDate() });
			}else{
				status = jdbcTemplate.update(sql, new Object[]{ reg.getFirstName(), reg.getLastname(),reg.getEmail(),reg.getPhone().replace("\"", ""),reg.getCountry(),reg.getState(),Integer.parseInt(reg.getPincode()),reg.getCompanyName(),reg.getClientSecret(),reg.getPassword(),reg.getEmail_verification_token(),reg.getUser_type(),reg.getStatus(),reg.getRole(),reg.getDate(),reg.getProject() });	
			}
		}
		
		return status;
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}


	public int verifyRegistrationDao(String token, String email) throws DaoException 
	{
		logger.info(String.format("verifyRegistrationDao(token = %s, email = %s)", token, email));
		
		String sql = queryProps.getProperty("getVerifyRegistration");
		Integer id;
		
			try{
		    List<Integer> ids = jdbcTemplate.queryForList(sql, Integer.class, email,token); 
		    if (ids.isEmpty()) {
		        id = 2;
		    } else {
		    	if(jdbcTemplate.update(queryProps.getProperty("updateVerifyStatusRegistration"), ids.get(0)) !=0){
		    		jdbcTemplate.update(queryProps.getProperty("updateVerifyRegistrationToken"),ids.get(0),token,1,new DateManipulation().getMyDate(),new DateManipulation().getMyDate(30));
		    	}
		        id =  1;
		    }
		
		    
		
		return id;
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
	}


	public Registration loginCall(String email) throws DaoException
	{
		logger.info(String.format("loginCall(email = %s)", email));	    
		String sql = queryProps.getProperty("loginCall");
	    
		try{
	    Registration listContact = jdbcTemplate.query(sql, new Object[] { email }, new ResultSetExtractor<Registration>()
	    {
			public Registration extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				if(rs.next()){
		    		Registration r = new Registration();
		    		r.setId(rs.getInt("id"));
		    		r.setFirstName(rs.getString("firstname"));
		    		r.setLastname(rs.getString("lastname"));
		    		r.setPhoto(rs.getString("photo"));
		    		r.setEmail(rs.getString("email"));
		    		r.setPhone(rs.getString("phone"));
		    		r.setCountry(rs.getString("country"));
		    		r.setState(rs.getString("state"));
		    		r.setPincode(rs.getString("pincode"));
		    		r.setPassword(rs.getString("password"));
		    		r.setCompanyName(rs.getString("company_name"));
		    		r.setJobTitle(rs.getString("job_title"));
		    		r.setClientId(rs.getString("client_id"));
		    		r.setClientSecret(rs.getString("client_secret"));
		    		r.setEmail_verification_token(rs.getString("email_verification_token"));
		    		r.setUser_type(rs.getInt("user_type"));
		    		
		    		r.setStatus(rs.getInt("status"));
		    		r.setRole(rs.getString("role"));
		    		r.setIsCompany(rs.getString("is_company"));
		    		r.setDate(rs.getDate("created_on"));
		    		r.setUpdatedOn(rs.getDate("updated_on"));
		    		return r;
		    		}
				return null;				
			}
		});		
		return (Registration) listContact;
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}


	public boolean checkValidFileDao(String fname, String token, String email) throws DaoException
	{
		logger.info(String.format("checkValidFileDao(fname = %s, token = %s, email = %s)", fname, token, email));
		boolean flag = false;
		List<Integer> ids = null;
		String sql = queryProps.getProperty("checkValidFile");
		try{
		     ids = jdbcTemplate.queryForList(sql, Integer.class, fname,0);
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		    if (!ids.isEmpty()) {
		    	flag = true;
		    }
		return flag;
	}


	@Override
	public Registration getUser(String userName) throws DaoException {
		logger.info(String.format("getUser(userName = %s)", userName));	    
		String sql = queryProps.getProperty("getUserAll_Details");
	    
		try{
	    Registration user = jdbcTemplate.query(sql, new Object[] { userName }, new ResultSetExtractor<Registration>()
	    {
			public Registration extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				Registration r = new Registration();
				if(rs.next()){
		    		r.setId(rs.getInt("id"));
		    		r.setFirstName(rs.getString("firstname"));
		    		r.setLastname(rs.getString("lastname"));
		    		r.setPhoto(rs.getString("photo"));
		    		r.setEmail(rs.getString("email"));
		    		r.setPhone(rs.getString("phone"));
		    		r.setCountry(rs.getString("country"));
		    		r.setState(rs.getString("state"));
		    		r.setPincode(rs.getString("pincode"));
		    		r.setPassword(rs.getString("password"));
		    		r.setCompanyName(rs.getString("company_name"));
		    		r.setJobTitle(rs.getString("job_title"));
		    		r.setClientId(rs.getString("client_id"));
		    		r.setClientSecret(rs.getString("client_secret"));
		    		r.setEmail_verification_token(rs.getString("email_verification_token"));
		    		r.setUser_type(rs.getInt("user_type"));
		    		
		    		r.setStatus(rs.getInt("status"));
		    		r.setRole(rs.getString("role"));
		    		r.setIsCompany(rs.getString("is_company"));
		    		r.setDate(rs.getDate("created_on"));
		    		r.setUpdatedOn(rs.getDate("updated_on"));
		    		return r;
		    		}
				return r;				
			}
		});		
		return (Registration) user;
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}


	
}
