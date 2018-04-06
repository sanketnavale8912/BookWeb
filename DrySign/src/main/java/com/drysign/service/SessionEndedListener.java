package com.drysign.service;

import java.util.List;
import org.springframework.context.ApplicationListener;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.stereotype.Component;

import com.drysign.model.Registration;

@Component
public class SessionEndedListener implements ApplicationListener<SessionDestroyedEvent> {

    @Override
    public void onApplicationEvent(SessionDestroyedEvent event)
    {
    	List<SecurityContext> lstSecurityContext = event.getSecurityContexts();
        Registration register;
        for (SecurityContext securityContext : lstSecurityContext)
        {
        	register = (Registration) securityContext.getAuthentication().getPrincipal();
        	System.out.println("Session timeout "+register.getEmail());
        }
    }

}