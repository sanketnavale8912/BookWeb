<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="com.drysign.model.Registration, org.springframework.security.core.context.SecurityContextHolder, org.springframework.security.core.Authentication" %>
<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <title>DrySign -Verify</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="_csrf" content="${_csrf.token}"/>
	  <meta name="_csrf_header" content="${_csrf.headerName}"/>
      <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
      <link rel="stylesheet" href="<%=appUrl%>/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
      <script src="<%=appUrl%>/js/bootstrap.min.js"></script>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
      <link rel="stylesheet" href="<%=appUrl %>/css/login.css">
      <link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
    </head>
    <body class="bg">
     <section>
	    <div class="login">
            <div class="wrapper-lg">
               <div class="text-center"><img src="<%=appUrl %>/images/logo.png" alt="Logo" class="iMg" title="Logo"/></div>
               <div class="login-info">
				   <div class="message text-center">
					   <p><img src="<%=appUrl %>/images/message-bg.png"/></p>
					   <h4>Account Verification!</h4>
					   
					    <c:choose>
						    <c:when test="${ message == '1'}">
						         <p>Your account has been activated successfully.</p>
						    </c:when>
						    <c:otherwise>
						       <p style="color:red;">${message}</p>
						    </c:otherwise>
						</c:choose>
					   <a href="login" class="btn-link">CONTINUE TO DRYSIGN</a>                  
                      </div>					   
				   </div>
               
            </div>
			 <div class="wrapper-footer">
			 <div class="wrapper-footer_content">
			 <hr/>
				  <p>© Copyright<script>document.write(new Date().getFullYear())</script> Exela Technologies Inc., All Rights Reserved. </p>
			 </div>
			 </div>
         </div>
     </section>
     <!-- script --> 
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script> 
 	<script src="<%=appUrl %>/js/bootstrap.min.js"></script>
	</body>
</html>

