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
      <title>Login</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="_csrf" content="${_csrf.token}"/>
	  <meta name="_csrf_header" content="${_csrf.headerName}"/>
      <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
      <link rel="stylesheet" href="<%=appUrl %>/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
      <script src="<%=appUrl %>/js/bootstrap.min.js"></script>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
      <link rel="stylesheet" href="<%=appUrl %>/css/login.css">
      <link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
	  <style>
		.body, html {
			  height: 100%;
		  }
		  form .error {
	 		color: #ff0000;
	 	  }
	 	  .error1 {
			padding: 15px;
			margin-bottom: 20px;
			border: 1px solid transparent;
			border-radius: 4px;
			color: #a94442;
			background-color: #f2dede;
			border-color: #ebccd1;
		  }
		  .msg {
			padding: 15px;
			margin-bottom: 20px;
			border: 1px solid transparent;
			border-radius: 4px;
			color: #31708f;
			background-color: #d9edf7;
			border-color: #bce8f1;
		  }
		  .greenButton{
		  	font-weight: 400;
		  	color: #fff;border-radius: 0;
		  	font-size: 14px;
		  	font-family: roboto;
		  	text-transform: uppercase;
		  	padding: 3px 12px;
		  	background: #00bc9c;
		  	border-radius: 4px;"
		  }
		    .field-icon {
			float: right;
			margin-left: -25px;
			margin-top: -25px;
			position: relative;
			z-index: 2;
		  }
	 	  <style>
  </style>
	</head>
   <body class="bg">
   <input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
      <section>
		 <!-- Register -->
       	  <div class="login">
            <div class="wrapper-lg">
               <div class="text-center" id="passwordreset-icon" ><img src="<%=appUrl %>/images/logo.png" alt="Logo" class="iMg" title="Logo"/></div>
               <div class="login-info ">
                	<div class="message text-center" id="passwordreset-success" style="display:none">
					   <p><img src="<%=appUrl %>/images/message-bg.png"/></p>
					   <h4>YOUR PASSWORD HAS BEEN RESET!</h4>
					  	<p>Congratulations! Your new password has been successfully created.</p>
					      <a href="login" class="btn btn-link ">CONTINUE TO DRYSIGN</a>                   
				   </div>
				   <div class="message text-center" id="passwordreset-error" style="display:none">
					   <p><img src="<%=appUrl %>/images/fail.png"/></p>
					   <h4 style="color:#ff6559">INVALID LINK!</h4>
					  	<!-- <p>Congratulations! Your new password has been successfully created.</p> -->
					      <a href="login" class="btn btn-link ">CONTINUE TO DRYSIGN</a>                   
				   </div>
				   
				 	<div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="passwordModelalert">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="passwordmessage"></div>
					</div> 
                  <form id="passwordreset-form">
				     <div class="form-group has-feedback paddTB15 ">
                       <!--  <div class="input-group"> -->
                           <label>Password</label>
                           <!-- <i class="fa fa-eye pull-right" aria-hidden="true"></i> -->
                           <input type="password" id="password-field1" name="password" placeholder="" class="form-control">
                           <span toggle="#password-field1" class="fa fa-fw fa-eye field-icon toggle-password1">
                        <!-- </div> -->
                     </div>
                     <div class="form-group has-feedback paddTB15">
                   
                           <label>Confirm Password</label>
                          <!--  <i class="fa fa-eye pull-right" aria-hidden="true"></i> -->
                            <input type="password" id="password-field2"  name="confirmpassword" placeholder="" class="form-control">
                            <span toggle="#password-field2" class="fa fa-fw fa-eye field-icon toggle-password2">
                           
                           	<input type="hidden" id="email" name="email"   value="${email}"/>
                           	<input type="hidden" id="userid" name="userid"   value="${userid}"/>
                           	<input type="hidden" id="token" name="token"   value="${token}"/>
                   
                     </div>
                     <div class="row">
						 <div class="col-md-12 text-right"> <button id="resetbtn" onclick="resetPassword()();"  class="btn has-spinner greenButton">Reset Password</button> </div>                        
                     </div>
                   </form>
               </div>
                <div class="wrapper-footer">
			 	<div class="wrapper-footer_content">
				 <p> &copy; Copyright  <script>document.write(new Date().getFullYear())</script> Exela Technologies Inc., All Rights Reserved. </p>
			 	</div>
			 </div>
            </div>
			
         </div>
 </section>
 <!-- script --> 
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script> 
 <script src="<%=appUrl %>/js/bootstrap.min.js"></script>
 
 <!-- Validation -->
 <script src="<%=appUrl %>/js/jquery.validate.js"></script>
 <!-- Loader -->
 <script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
 <script>
$(document).ready(function() {
	
	var flag='${flag}';
	if(flag == 0){
		$("#passwordreset-form").hide();
		$("#passwordreset-error").show();
	}
	
});
 var passwordForm=$("#passwordreset-form").validate({
		//specify the validation rules
		rules: {
			password: {
				required: true,
				minlength: 8
			},
			confirmpassword : {
				required: true,
				minlength : 8,
				equalTo : "#password-field1"
			}
		},
		//specify validation error messages
		messages: {
			password: {
				required: "Password field cannot be blank",
				minlength: "Your password must be at least 8 characters long"
			},
			confirmpassword:{
				required: "Confirm Password field cannot be blank",
				minlength: "Your password must be at least 8 characters long",
				equalTo:"Please enter the same Password as above",
				
			}
		}
});
  function resetPassword(){
	  var token = $("meta[name='_csrf']").attr("content");
	  var header = $("meta[name='_csrf_header']").attr("content");
	  var contextPath=$("#contextPath").val();
	  var valid = $("#passwordreset-form").valid();
	  if(valid == true){
			var data = {
					  "email" :$("#email").val(),
					  "userid" :$("#userid").val(),
					  "token" :$("#token").val(),
		    	      "password" :$("#password-field1").val(),
		    	      "confirmpassword" :$("#password-field2").val()	    	     
		    }
			$.ajax({
				contentType : 'application/json; charset=utf-8',
				type : "POST",
				url : "updateResetPassword",
				dataType : 'json',
				crossDomain: true,
				data : JSON.stringify(data),
				beforeSend : function(xhr) {
					$('#resetbtn').buttonLoader('start');
					xhr.setRequestHeader(header, token);
				},
				complete : function() {
					$("#resetbtn").buttonLoader('stop');
				},
				success : function(response) {
					if(response.msg == 1 || response.msg == "1"){
						//alert('Success');
						$("#passwordmessage").val('');
						$("#passwordModelalert").hide();
						$("#passwordreset-form").hide();
						$("#passwordreset-success").show();
					}else{
						//alert('Error');
						$("#passwordModelalert").show();
						$("#passwordmessage").html(response.msg);
					}
				},
				error: function(xhr, textStatus, errorThrown)
				 {
				 	alert('ajax loading error... ... ');
				 	return false;
				}
			});		
		}
  }
 </script>
 <script>
 $(".toggle-password1").click(function() {

		$(this).toggleClass("fa-eye fa-eye-slash");
		var input = $($(this).attr("toggle"));
		if (input.attr("type") == "password") {
		input.attr("type", "text");
		} else {
		input.attr("type", "password");
		}
});
		
$(".toggle-password2").click(function() {

		$(this).toggleClass("fa-eye fa-eye-slash");
		var input = $($(this).attr("toggle"));
		if (input.attr("type") == "password") {
		input.attr("type", "text");
		} else {
		input.attr("type", "password");
		}
});
 </script>
</body>
</html>

