package com.drysign.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drysign.dao.SubscriptionDao;
import com.drysign.model.SB_Category;
import com.drysign.model.SB_Plan;
import com.drysign.model.SB_Purchase;
import com.drysign.model.SB_SendEmailToSubscribers;
import com.drysign.model.SB_Subscription;

@Service("subscriptionService")
public class SubscriptionServiceImpl implements SubscriptionService{

	@Autowired
	private SubscriptionDao subscriptionDao;

	@Override
	public List<SB_Category> getCategories(String username, String password) {
		
		return subscriptionDao.getCategories(username, password);
	}

	@Override
	public boolean validSubscribingModel(String username, String password) 
	{
		return subscriptionDao.validSubscribingModel(username,password);
	}

	@Override
	public List<SB_Plan> getSubscriptionPlans(String username, String password, String categoryName,String categoryId) 
	{
		return subscriptionDao.getSubscriptionPlans(username, password, categoryName,categoryId);
	}

	@Override
	public SB_Plan getSubscriptionPlan(String username, String password, String token) 
	{
		
		return subscriptionDao.getSubscriptionPlan(username, password, token);
	}

	@Override
	public String createSubscripton(int userId, String transactionID,String paymetnMethod,String gatewayResponse, SB_Plan plan,String clientReferId, Timestamp todayDate, Timestamp validTill,String active) {
		return subscriptionDao.createSubscription(userId,transactionID,paymetnMethod,gatewayResponse,plan,clientReferId,  todayDate,  validTill, active);
	}

	@Override
	public SB_Subscription checkValidSubscription(int userId) 
	{
		return subscriptionDao.checkValidSubscription(userId) ;
	}

	@Override
	public SB_Purchase getActiveSubscription(int userId) 
	{
		return subscriptionDao.getActiveSubscription(userId);
	}

	@Override
	public String updateSubscription(int SubscriptionId, String gatewayResponse, String transactionID, String active, String paymetnMethod) 
	{
		return subscriptionDao.updateSubscription(SubscriptionId,gatewayResponse,transactionID,active,paymetnMethod);
	}

	@Override
	public List<SB_SendEmailToSubscribers> sendEmailToSubscribers(int beforeDays) 
	{
		return subscriptionDao.sendEmailToSubscribers(beforeDays);
	}

	@Override
	public SB_Plan getTrialPlan(String username, String password, String trialPlanName) 
	{
		return subscriptionDao.getTrialPlan(username,password,trialPlanName);
	}
}
