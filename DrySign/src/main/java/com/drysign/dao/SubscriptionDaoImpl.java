package com.drysign.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.drysign.model.DocumentField;
import com.drysign.model.Registration;
import com.drysign.model.SB_Category;
import com.drysign.model.SB_Currency;
import com.drysign.model.SB_Duration;
import com.drysign.model.SB_Plan;
import com.drysign.model.SB_Purchase;
import com.drysign.model.SB_SendEmailToSubscribers;
import com.drysign.model.SB_Subscription;
import com.drysign.utility.ApplicationUtils;
import com.drysign.utility.CommonUtils;

@Repository("subscriptionDao")
@Transactional
public class SubscriptionDaoImpl implements SubscriptionDao {

	private static final Logger logger = Logger.getLogger(SubscriptionDaoImpl.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private Properties queryProps;
	
	String className = this.getClass().getSimpleName();

	@Override
	public List<SB_Category> getCategories(String username, String password) 
	{
		String classMethod = className+ ":  getSubscriptionPlans()" ;
		logger.info(String.format("Enter into "+classMethod));
		List<SB_Category> subscritionPlan = null;
		try{
		String sql = queryProps.getProperty("getCategories");
		subscritionPlan = jdbcTemplate.query(sql, new Object[]{username,password},new RowMapper<SB_Category>(){  
		    @Override  
		    public SB_Category mapRow(ResultSet rs, int rownumber) throws SQLException {  
		    	SB_Category category = new SB_Category();  
		    	category.setCategory_id(rs.getInt("category_id"));
		    	category.setName(rs.getString("name"));
		    	category.setDescription(rs.getString("description"));
		        return category;  
		    }  
		    });
			
		}catch(Exception e){
			logger.error("Error while getting getCategories: "+e);
		}
		logger.info("exit from "+classMethod);
		return subscritionPlan;}

	@Override
	public boolean validSubscribingModel(String username, String password) 
	{
		String classMethod = className+ ":  validSubscribingModel" ;
		logger.info(String.format("Enter into "+classMethod+"(username = %s, password = %s)", username,password));
		boolean flag = false;
		String sql = queryProps.getProperty("validSubscribingModel");
		List<Integer> ids = null;
		
		try{
		ids = jdbcTemplate.queryForList(sql, Integer.class, username,password);
		if(ids.get(0) > 0)
		{
			flag = true;
		}
		}catch(Exception e){
			flag = false;
			logger.error("Error while validSubscriptionModel: "+e);
		}
		logger.info("exit from "+classMethod);
		return flag;
	}

	@Override
	public List<SB_Plan> getSubscriptionPlans(String username, String password, String categoryName, String categoryId) 
	{
		String classMethod = className+ ":  getSubscriptionPlans()" ;
		logger.info(String.format("Enter into "+classMethod));
		List<SB_Plan> subscritionPlan = null;
		try{
		String sql = queryProps.getProperty("getSubscriptionPlans");
		subscritionPlan = jdbcTemplate.query(sql,new Object[]{username,password,categoryId,categoryName},new RowMapper<SB_Plan>()
		{  
		    @Override  
		    public SB_Plan mapRow(ResultSet rs, int rownumber) throws SQLException {  
		    	SB_Plan sp = new SB_Plan();  
		        sp.setId(rs.getInt("id"));
		        sp.setName(rs.getString("plan_name"));
		        sp.setToken(rs.getString("plantoken"));
		        sp.setPrice(rs.getString("price"));
		        sp.setNoOfUsers(rs.getString("noofusers"));
		        sp.setNoOfDocuments(rs.getString("noofdocuments"));
		        sp.setFeatures(rs.getString("features"));
		        
		        SB_Category category = new SB_Category();
		        category.setName(rs.getString("category_name"));
		        sp.setCategory(category);
		        
		        SB_Currency currency = new SB_Currency();
		        currency.setName(rs.getString("currency"));
		        sp.setCurrency(currency);
		        
		        SB_Duration duration = new SB_Duration();
		        duration.setName(rs.getString("durationname"));
		        duration.setTime(rs.getString("durationtime"));
		        duration.setUnit(rs.getString("durationunit"));
		        sp.setDuration(duration);

		        return sp;  
		    }  
		    });
		}catch(Exception e){
			logger.error("Error while getting getSubscriptionPlnas: "+e);
		}
		logger.info("exit from "+classMethod);
		return subscritionPlan;
	}

	
	
	/*@Override
	public List<SubscriptionPlan> getSubscriptionPlans() 
	{
		String classMethod = className+ ":  getSubscriptionPlans()" ;
		logger.info(String.format("Enter into "+classMethod));
		
		
		String sql = queryProps.getProperty("getSubscriptionPlans");
		List<SubscriptionPlan> subscritionPlan = jdbcTemplate.query(sql,new RowMapper<SubscriptionPlan>(){  
		    @Override  
		    public SubscriptionPlan mapRow(ResultSet rs, int rownumber) throws SQLException {  
		    	SubscriptionPlan sp = new SubscriptionPlan();  
		        sp.setPlanId(rs.getInt(1));  
		        sp.setCurrency(rs.getString(2));  
		        sp.setAmount(rs.getString(3));
		        sp.setPlanName(rs.getString(4));
		        sp.setNumberOfDays(rs.getString(5));
		        sp.setNumberOfDocuments(rs.getString(6));
		        sp.setStatus(rs.getInt(7));
		        sp.setContent(rs.getString(8));
		        return sp;  
		    }  
		    });
			
		logger.info("exit from "+classMethod);
		return subscritionPlan;
	}*/



	@Override
	public SB_Plan getSubscriptionPlan(String username, String password, String token) 
	{
		String classMethod = className+ ":  getSubscrptionPlan()" ;
		logger.info(String.format("Enter into "+classMethod));
		
		String sql = queryProps.getProperty("getSubscriptionPlan");
		SB_Plan subscriptionPlan = null;
		try{
			subscriptionPlan = jdbcTemplate.query(sql, new Object[] { username,password,token }, new ResultSetExtractor<SB_Plan>()
	    {
			public SB_Plan extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				SB_Plan sp = new SB_Plan();
				if(rs.next()){
					sp.setId(rs.getInt("id"));
			        sp.setName(rs.getString("plan_name"));
			        sp.setToken(rs.getString("plantoken"));
			        sp.setPrice(rs.getString("price"));
			        sp.setNoOfUsers(rs.getString("noofusers"));
			        sp.setNoOfDocuments(rs.getString("noofdocuments"));
			        sp.setFeatures(rs.getString("features"));
			        
			        SB_Currency currency = new SB_Currency();
			        currency.setName(rs.getString("currency"));
			        sp.setCurrency(currency);
			        
			        SB_Category category = new SB_Category();
			        category.setName(rs.getString("category_name"));
			        sp.setCategory(category);
			        
			        SB_Duration duration = new SB_Duration();
			        duration.setName(rs.getString("durationname"));
			        duration.setTime(rs.getString("durationtime"));
			        duration.setUnit(rs.getString("durationunit"));
			        sp.setDuration(duration);
		    		return sp;
		    		}
				return sp;				
			}
		});	
		}catch(Exception e){
			logger.error("Error while getting getSubscriptionPlan: "+e);
		}
		
		logger.info("exit from "+classMethod);
		return subscriptionPlan;
	}

	@Override
	public String createSubscription(final int userId, String transactionID,String paymetnMethod,String gatewayResponse, final SB_Plan plan,final String clientReferId, final Timestamp todayDate, final Timestamp validTill,final String active) 
	{
		String classMethod = className+ ":  createSubscription()" ;
		logger.info(String.format("Enter into "+classMethod));
		String subscriptionId = "";
		String msg = "";
		
		final String subscriptionSql = queryProps.getProperty("createSubscription");
		final String purchaseSql = queryProps.getProperty("createPurchase");
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try{
		jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
            PreparedStatement pst =con.prepareStatement(subscriptionSql, new String[] {"id"});
            int index = 1;
            pst.setInt(index++,userId);
            pst.setInt(index++, plan.getId());
            pst.setInt(index++,Integer.parseInt(plan.getNoOfDocuments()));
            pst.setInt(index++,0);
            pst.setInt(index++, Integer.parseInt(active));
            pst.setTimestamp(index++, todayDate);
            pst.setTimestamp(index++, validTill);
		         return pst;
		    }
		    },
		    keyHolder);
		}catch(Exception e){
			msg = e.getMessage();
			logger.error("Error while saving subscription details: "+e);
		}
		 subscriptionId = keyHolder.getKey().toString();
		if(msg =="" && subscriptionId !="")
		{
			try{
				jdbcTemplate.update(purchaseSql,Integer.parseInt(subscriptionId),plan.getName(),plan.getCategory().getName(),plan.getPrice(),plan.getCurrency().getName(),plan.getDuration().getTime(),plan.getNoOfDocuments(),plan.getNoOfUsers(),plan.getFeatures(),plan.getDuration().getName(),plan.getDuration().getTime(),plan.getDuration().getUnit(),transactionID,paymetnMethod,gatewayResponse,0,CommonUtils.currentDate(),clientReferId);
				msg=subscriptionId;
			}catch(Exception e){
				msg = e.getMessage();
				logger.error("Error while saving purchase details: "+e);
			}
		}
		
		logger.info("exit from "+classMethod);
		return msg;
	}

	@Override
	public SB_Subscription checkValidSubscription(int userId) 
	{
		logger.info(String.format("checkValidSubscription(userId = %s)", userId));	    
		String sql = queryProps.getProperty("checkValidSubscription");
		SB_Subscription sub =null;
		try{
			sub = jdbcTemplate.query(sql, new Object[] { userId }, new ResultSetExtractor<SB_Subscription>()
			{
			public SB_Subscription extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				if(rs.next()){
					SB_Subscription subscription = new SB_Subscription();
					subscription.setId(rs.getInt("id"));
					subscription.setUserId(rs.getInt("user_id"));
					subscription.setPlanId(rs.getInt("plan_id"));
					subscription.setCreditedDocuments(rs.getInt("credited_documents"));
					subscription.setUsedDocuments(rs.getInt("used_documents"));
					subscription.setStatus(rs.getInt("status"));
					subscription.setSubscriptionStartTime(rs.getTimestamp("subscription_start_date"));
					subscription.setSubscriptionEndTime(rs.getTimestamp("subscription_end_date"));
		    		return subscription;
		    		}
				return null;				
			}
		});		
		return (SB_Subscription) sub;
		
		}catch(Exception e ){
			logger.error("Error while getting checkValidSubscription: "+e);
		}
		return sub;
	}

	@Override
	public SB_Purchase getActiveSubscription(int userId) 
	{
		logger.info(String.format("getActiveSubscription(userId = %s)", userId));	    
		String sql = queryProps.getProperty("activePurchase");
		SB_Purchase purchase =null;
		try{
			purchase = jdbcTemplate.query(sql, new Object[] { userId }, new ResultSetExtractor<SB_Purchase>()
			{
			public SB_Purchase extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				if(rs.next()){
					SB_Subscription subscription = new SB_Subscription();
					subscription.setId(rs.getInt("id"));
					subscription.setUserId(rs.getInt("user_id"));
					subscription.setPlanId(rs.getInt("plan_id"));
					subscription.setCreditedDocuments(rs.getInt("credited_documents"));
					subscription.setUsedDocuments(rs.getInt("used_documents"));
					subscription.setStatus(rs.getInt("status"));
					subscription.setSubscriptionStartTime(rs.getTimestamp("subscription_start_date"));
					subscription.setSubscriptionEndTime(rs.getTimestamp("subscription_end_date"));
					
					SB_Purchase purchase = new SB_Purchase();
					purchase.setPlanName(rs.getString("plan_name"));
					purchase.setDurationtime(rs.getString("noofdays"));
					purchase.setSubscription(subscription);
		    		return purchase;
		    		}
				return null;				
			}
		});		
		return (SB_Purchase) purchase;
		
		}catch(Exception e ){
			logger.error("Error while getting checkValidSubscription: "+e);
		}
		return purchase;
	}

	@Override
	public String updateSubscription(int SubscriptionId, String gatewayResponse, String transactionID, String active, String paymetnMethod) 
	{
		
		String classMethod = className+ ":  updateSubscription" ;
		logger.info(String.format("enter into "+classMethod+"(SubscriptionId = %s, gatewayResponse = %s, transactionID = %s, active = %s)", SubscriptionId,gatewayResponse,transactionID,active));
		String returnStatus = "";
		
		try{
		String updateSubscriptionSql = queryProps.getProperty("updateSubscription");
		String updatePurchaseSql = queryProps.getProperty("updatePurchase");
		jdbcTemplate.update(updateSubscriptionSql,active,SubscriptionId);
		jdbcTemplate.update(updatePurchaseSql,transactionID,paymetnMethod,gatewayResponse,active,SubscriptionId);
		returnStatus = "1";
		}catch(Exception e){
			logger.error("Error while updatedSubscription:  "+e);
		}
		logger.info("exit from "+classMethod);
		return returnStatus;
	}

	@Override
	public List<SB_SendEmailToSubscribers> sendEmailToSubscribers(int beforeDays) 
	{
		String classMethod = className+ ":  sendEmailToSubscribers" ;
		logger.info(String.format("enter into "+classMethod+"(beforeDays = %s)", beforeDays));
		String query = queryProps.getProperty("sendEmailToSubscribers");
		List<SB_SendEmailToSubscribers> docList = new ArrayList<SB_SendEmailToSubscribers>();
		List<Map<String, Object>> jsonRows = jdbcTemplate.queryForList(query, new Object[] { beforeDays,beforeDays });
		
		for (Map<String, Object> jsonRow : jsonRows) {
			SB_SendEmailToSubscribers sub = new SB_SendEmailToSubscribers();
			sub.setFirstName(String.valueOf(jsonRow.get("FIRSTNAME")));
			sub.setLastName(String.valueOf(jsonRow.get("LASTNAME")));
			sub.setEmail(String.valueOf(jsonRow.get("EMAIL")));
			sub.setPlanName(String.valueOf(jsonRow.get("PLANNAME")));
			sub.setEndTime(String.valueOf(jsonRow.get("subscription_end_date")));
			sub.setVolumeInPercent(String.valueOf(jsonRow.get("DOCPERC")));
			
			docList.add(sub);
		}
		logger.info("exit from "+classMethod);
		return docList;
		
	
	}

	@Override
	public SB_Plan getTrialPlan(String username, String password, String trialPlanName) 
	{
		String classMethod = className+ ":  getSubscrptionPlan()" ;
		logger.info(String.format("Enter into "+classMethod));
		
		String sql = queryProps.getProperty("getTrialPlan");
		SB_Plan subscriptionPlan = null;
		try{
			subscriptionPlan = jdbcTemplate.query(sql, new Object[] { username,password,trialPlanName }, new ResultSetExtractor<SB_Plan>()
	    {
			public SB_Plan extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				SB_Plan sp = new SB_Plan();
				if(rs.next()){
					sp.setId(rs.getInt("id"));
			        sp.setName(rs.getString("plan_name"));
			        sp.setToken(rs.getString("plantoken"));
			        sp.setPrice(rs.getString("price"));
			        sp.setNoOfUsers(rs.getString("noofusers"));
			        sp.setNoOfDocuments(rs.getString("noofdocuments"));
			        sp.setFeatures(rs.getString("features"));
			        
			        SB_Currency currency = new SB_Currency();
			        currency.setName(rs.getString("currency"));
			        sp.setCurrency(currency);
			        
			        SB_Category category = new SB_Category();
			        category.setName(rs.getString("category_name"));
			        sp.setCategory(category);
			        
			        SB_Duration duration = new SB_Duration();
			        duration.setName(rs.getString("durationname"));
			        duration.setTime(rs.getString("durationtime"));
			        duration.setUnit(rs.getString("durationunit"));
			        sp.setDuration(duration);
		    		return sp;
		    		}
				return sp;				
			}
		});	
		}catch(Exception e){
			logger.error("Error while getting getSubscriptionPlan: "+e);
		}
		
		logger.info("exit from "+classMethod);
		return subscriptionPlan;
	}

}
