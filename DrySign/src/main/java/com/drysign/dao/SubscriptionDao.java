package com.drysign.dao;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Component;

import com.drysign.model.SB_Category;
import com.drysign.model.SB_Plan;
import com.drysign.model.SB_Purchase;
import com.drysign.model.SB_SendEmailToSubscribers;
import com.drysign.model.SB_Subscription;

@Component
public interface SubscriptionDao {

	List<SB_Category> getCategories(String username, String password);

	boolean validSubscribingModel(String username, String password);

	List<SB_Plan> getSubscriptionPlans(String username, String password, String categoryName, String categoryId);

	SB_Plan getSubscriptionPlan(String username, String password, String token);

	String createSubscription(int userId, String transactionID, String paymetnMethod, String gatewayResponse, SB_Plan plan, String clientReferId, Timestamp todayDate, Timestamp validTill, String active);

	SB_Subscription checkValidSubscription(int userId);

	SB_Purchase getActiveSubscription(int userId);

	String updateSubscription(int subscriptionId, String gatewayResponse, String transactionID, String active, String paymetnMethod);

	List<SB_SendEmailToSubscribers> sendEmailToSubscribers(int beforeDays);

	SB_Plan getTrialPlan(String username, String password, String trialPlanName);

}
