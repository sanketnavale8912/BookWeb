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
<html>
   <head>
      <title>Login | DrySign</title>
      
      
      
<link rel="apple-touch-icon" sizes="57x57" href="<%=appUrl %>/images/fav-icon/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="<%=appUrl %>/images/fav-icon/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="<%=appUrl %>/images/fav-icon/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="<%=appUrl %>/images/fav-icon/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="<%=appUrl %>/images/fav-icon/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="<%=appUrl %>/images/fav-icon/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="<%=appUrl %>/images/fav-icon/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="<%=appUrl %>/images/fav-icon/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="<%=appUrl %>/images/fav-icon/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="<%=appUrl %>/images/fav-icon/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="<%=appUrl %>/images/fav-icon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="<%=appUrl %>/images/fav-icon/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="<%=appUrl %>/images/fav-icon/favicon-16x16.png">
<link rel="manifest" href="<%=appUrl %>/images/fav-icon/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="<%=appUrl %>/images/fav-icon/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
      
      
      
      <meta charset="utf-8">
      <meta http-equiv="refresh" content="540" />
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="_csrf" content="${_csrf.token}"/>
	  <meta name="_csrf_header" content="${_csrf.headerName}"/>
      <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
      <link rel="stylesheet" href="<%=appUrl %>/css/bootstrap.min.css">
      <script src="<%=appUrl %>/js/jquery.min.js"></script>
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
		  	border-radius: 4px;
		  }
		  .field-icon {
			float: right;
			margin-left: -25px;
			margin-top: -25px;
			position: relative;
			z-index: 2;
		  }
	 	  

	  </style>
	</head>
   <body class="bg">
   <input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
      <section>
        <!-- Login -->
	    <div class="login">
            <div class="wrapper-lg">
                <div class="text-center"><a href="index"><img src="<%=appUrl %>/images/logo.png" alt="Logo" class="iMg" title="Logo"/></a></div>
               <div class="login-info ">
                 <%-- <c:if test="${not empty error}">
					<div class="error1">${error}</div>
				  </c:if>
				  <c:if test="${not empty msg}">
					<div class="msg">${msg}</div>
				  </c:if> --%>
				 <% String username = ""; %>
				<c:if test="${not empty sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}" >
              			<div class="alert alert-danger fade in" id="loginmodalalret">
					    <a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>

					   
					     <c:set var="errormsg" value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}"/>
						 <%
						    String errormsgstr = (String)pageContext.getAttribute("errormsg");  
						 	String[] errMsgArray = errormsgstr.split(",");
						 	username = errMsgArray[0];
						 	out.print(errMsgArray[1]);
						  %>  
					    
					 <c:remove var = "SPRING_SECURITY_LAST_EXCEPTION" scope = "session" />    
					</div> 
              		</c:if>
             		<c:if test="${not empty msg}">
					<div class="msg">${msg}</div>
					</c:if>
                 <form id="login-form" name='loginForm'
					action="${logoutUrl}" method='POST'>
				  	<div class="form-group has-feedback" style="padding:15px 0px;">
                        <label>Email</label>
                        <input type="text" name="username" placeholder="" value="${email}" class="form-control">
					 </div>
                     <div class="form-group has-feedback" style="padding:15px 0px;">
                    <!--     <div class="input-group"> -->
                           <label>Password</label>
                          <!--  <i class="fa fa-eye pull-right" aria-hidden="true"></i> -->
                           <input id="password-field" type="password" name="password" placeholder="" class="form-control ">
                          <!--  <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password">
                           --> 
                           <input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
                        <!-- </div> -->
                     </div>
                     <div class="row">
                        <div class="col-xs-12">
                           <div class="checkbox checkbox-primary">
                              <input type="checkbox" class="mycheckbox" id="checkbox2" >
                              <label for="checkbox2"> Show Password </label>
                           </div>
                        </div>
                     </div>
                     <div class="row">
						<div class="col-md-12 text-right"> <button type="submit" class="btn-link">Sign In</button> </div>
                        <div class="col-md-12 ">
                          <div class="user-pass">
                           <div class="col-xs-6 col-sm-6 col-md-6 text-left"><a href="#"  class="forgotpass link">Forgot Password?</a></div>
                           <div class="col-xs-6 col-sm-6 col-md-6 text-right"><%-- <a href="<%=appUrl %>/termsandcondition" class="">Terms & Conditions</a>  --%></div>
                        </div>
						 </div>
                    </div>
                  </form>
			   </div>
               <div class="wrapper-footer">
			 <div class="wrapper-footer_content">
				 <p>Need an account? <a href="#" class="signup">Sign Up</a></p>
				 
				 <p>  &copy; Copyright  <script>document.write(new Date().getFullYear())</script> Exela Technologies Inc., All Rights Reserved. </p>
			 </div>
			 </div>
            </div>
		</div>
		<!-- Forgot Password -->
        <div class="login-forgotpass">
            <div class="wrapper-lg">
				<a class="backbutton pull-left"><span class="glyphicon glyphicon-arrow-left"></span></a>
               <div class="text-center" id="forgot-icon"><img src="<%=appUrl %>/images/forgot-bg.png" alt="Logo" class="iMg" title="Logo"/></div>
               <div class="text-center" id="login-icon" style="display:none"><img src="<%=appUrl %>/images/logo.png" alt="Logo" class="iMg" title="Logo"/></div>
               <div class="login-info">
                  <div class="message text-center" id="password-success" style="display:none">
					   <p><img src="<%=appUrl %>/images/message-bg.png"/></p>
					   <h4>Check your email for a link to reset your password.</h4>
					   <p>If it doesn't appear within a few minutes, check your spam folder.</p>
					    <a class="btn backbutton btn-link ">CONTINUE TO DRYSIGN</a>           
				   </div>
                  <form id="forgotpassword-form">
                  	 <div class="">
						  <h3> Can't Sign In? Forgot your Password?</h3>
						  <p class="font-16">Enter your email address below and we will send you password reset instructions.</p>
					  </div>	
					   <div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="forgotpwdModelalert">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="forgotpwdmessage"></div>
					  </div> 
					  			  
					 <div class="form-group has-feedback" style="padding:15px 0px;">
                        <label>Enter your email address</label>
                        <input type="text" name="email" id="forgortEmailPassword" placeholder="" class="form-control" value="">
                     </div>
                   	<div class="row">
						 <div class="col-md-12 text-right"> <button type="button" id="frgtbtn" onclick="forgotPassword();"  class="btn has-spinner greenButton">Send Reset E-mail</button> </div>
                     </div>
                     <!-- /.col -->
                  </form>
                 
               </div>
            </div>
         </div>
         <!-- Register -->
       	  <div class="login-signup">
            <div class="wrapper-lg">
               <div class="text-center" id="register-icon" ><a href="index"><img src="<%=appUrl %>/images/logo.png" alt="Logo" class="iMg" title="Logo"/></a></div>
               <div class="login-info ">
                	<div class="message text-center" id="register-success" style="display:none">
					   <p><img src="<%=appUrl %>/images/message-bg.png"/></p>
					   <h4>YOUR ACCOUNT HAS BEEN CREATED!</h4>
					  <!--  <p>Congratulations! Your new account has been successfully created.</p> -->
					   <p>You will soon receive an email with a link to activate your new account.</p>
					      <a class="btn backbutton btn-link ">CONTINUE TO DRYSIGN</a>                   
				   </div>
				   
				 	<div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="regsiterModelalert">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="registerdmessage"></div>
					</div> 
                  <form id="register-form">
				  <div class="form-group has-feedback paddTB15" >
                        <label>First Name</label>
                        <input type="text" id="firstName" name="firstName" placeholder="" class="form-control">
                     </div>
                     <div class="form-group has-feedback paddTB15">
                        <label>Last Name</label>
                        <input type="text" id="lastname" name="lastname" placeholder="" class="form-control">
                     </div>
                     <div class="form-group has-feedback paddTB15">
                        <label>Email Address</label>
                        <input type="text" id="email" name="email" placeholder="" class="form-control">
                     </div>
                     <div class="form-group has-feedback paddTB15 ">
                       <!--  <div class="input-group"> -->
                           <label>Password</label>
                          <!--  <i class="fa fa-eye pull-right" aria-hidden="true"></i> -->
                           <input type="password" id="password-field1" name="password" placeholder="" class="form-control">
                           	<span toggle="#password-field1" class="fa fa-fw fa-eye field-icon toggle-password1">
                        <!-- </div> -->
                     </div>
                     <div class="form-group has-feedback paddTB15">
                      <!--   <div class="input-group"> -->
                           <label>Re-Type Password</label>
                         <!--   <i class="fa fa-eye pull-right" aria-hidden="true"></i> -->
                           <input type="password" id="password-field2" name="confirmpassword" placeholder="" class="form-control">
                           <span toggle="#password-field2" class="fa fa-fw fa-eye field-icon toggle-password2">
                       <!--  </div> -->
                     </div>
                     <div class="row">
						 <div class="col-md-12 text-right"> <button id="signupbtn" type="button" onclick="register();"  class="btn has-spinner greenButton">Sign up</button> </div>                        
                      
                     </div>
                   </form>
               </div>
                <div class="wrapper-footer">
			 <div class="wrapper-footer_content">
				 <p>Already have an account? <a href="#" class="backbutton">Sign In</a></p>
				  <p> &copy; Copyright  <script>document.write(new Date().getFullYear())</script> SourceHOV L.L.C. All Rights Reserved. </p>
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
 //alert('${msg}');
 var loginForm=$("#login-form").validate({
	//specify the validation rules
	rules: {
		username: {
			required: true,
			email: true //email is required AND must be in the form of a valid email address
		},
		password: {
			required: true,
			minlength : 8
		}
	},
	//specify validation error messages
	messages: {
		firstname: "First Name field cannot be blank",
		lastname: "Last Name field cannot be blank",
		password: {
			required: "Password field cannot be blank",
			minlength: "Your password must be at least 8 characters long"
		},
		username:{
			required:"Email Address field cannot be blank",
			email:"Please enter a valid email address"
		} 
	},
	submitHandler: function(form){
	form.submit();
	}
	 
});
 var registerForm=$("#register-form").validate({
		//specify the validation rules
		rules: {
			firstName:"required",
			lastname:"required",
			email: {
				required: true,
				email: true //email is required AND must be in the form of a valid email address
			},
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
			firstName: "First Name field cannot be blank",
			lastname: "Last Name field cannot be blank",
			password: {
				required: "Password field cannot be blank",
				minlength: "Your password must be at least 8 characters long"
			},
			confirmpassword:{
				required: "Re-Type Password field cannot be blank",
				minlength: "Your password must be at least 8 characters long",
				equalTo:"Please enter the same Password as above",
				
			},
			email: {
				required: "Email Address field cannot be blank",
				email:"Please enter a valid email address"
			}
		}
 });
 
function register(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	var valid = $("#register-form").valid();
	if(valid == true){
		var data = {
	    	      "firstName" : $("#firstName").val(),
	    	      "lastname" :$("#lastname").val(),
	    	      "email" :$("#email").val(),
	    	      "password" :$("#password-field1").val(),
	    	      "confirmpassword" :$("#password-field2").val()	    	     
	    }
		$.ajax({
			contentType : 'application/json; charset=utf-8',
			type : "POST",
			url : "registration",
			dataType : 'json',
			crossDomain: true,
			data : JSON.stringify(data),
			beforeSend : function(xhr) {
				$('#signupbtn').buttonLoader('start');
				xhr.setRequestHeader(header, token);
			},
			complete : function() {
				$("#signupbtn").buttonLoader('stop');
			},
			success : function(response) {
				if(response.msg == 1 || response.msg == "1"){
					//alert('Success');
					$("#registerdmessage").val('');
					$("#regsiterModelalert").hide();
					$("#register-form").hide();
					$("#register-success").show();
				}else{
					//alert('Error');
					$("#regsiterModelalert").show();
					$("#registerdmessage").html(response.msg);
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
var forgotForm= $("#forgotpassword-form").validate({
		//specify the validation rules
		rules: {
			email: {
				required: true,
				email: true //email is required AND must be in the form of a valid email address
			}
		},
		//specify validation error messages
		messages: {
			email:{
				required:"Please enter a valid email address",
				email:"Please enter a valid email address"
			} 
		}
});

function forgotPassword(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	var forgotemail = $('#forgortEmailPassword');
	var valid = $("#forgotpassword-form").valid();
	if(valid == true){
	$.ajax({
		type : "POST",
		url : "forgotPassword",
		data : {
			"forgotemail" : forgotemail.val().trim()
		},
		beforeSend : function(xhr) {
			$('#frgtbtn').buttonLoader('start');
			xhr.setRequestHeader(header, token);
		},
		complete : function() {
			$("#frgtbtn").buttonLoader('stop');
		},
		success : function(response) {
			if(response == 1){
				//alert('Success');
				$("#forgotpwdModelalert").hide();
				$("#forgotpassword-form").hide();
				$("#forgot-icon").hide();
				$("#login-icon").show();
				$("#password-success").show();
				
			}else{
				//alert('Error');
				$("#forgotpwdModelalert").show();
				$("#forgotpwdmessage").html(response);
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
 
 /* $("#email").change(function(){
     alert("The text has been changed.");
     var data=$("#email").val();
     var contextPath=$("#contextPath").val();
     $.ajax({
    	 type: "POST",
		 url: $("#contextPath").val()+"login/checkUserExistOrNot",   
		 dataType: "json",
		 data: data, 
		 success: function(returnData)
		 {
			  if (returnData!== 'true')
			  {
				  alert(true);
			  	return '<p>This email address is already registered.</p>';
			  }
			  else
			  {
				  alert(false);
			  	return true;
			  }
		 },
		 error: function(xhr, textStatus, errorThrown)
		 {
		 	alert('ajax loading error... ... ');
		 	return false;
		 }
   	});
 });  */
 </script>
 <script>
//open forgot password pop up
$('a.forgotpass, #back').click(function() {
	
	//reset form and validation
	loginForm.resetForm();
	registerForm.resetForm();
	forgotForm.resetForm();
	
	$("#login-icon").hide();
	$("#password-success").hide();
	$("#forgotpwdModelalert").hide();
	$("#forgotpwdmessage").val('');
	$('#login-form')[0].reset();
	$('#forgotpassword-form')[0].reset();
	
	$("#forgotpassword-form").show();
	$("#forgot-icon").show();
	$('#register-form')[0].reset();
		var $slider = $('.login-forgotpass');
		 $slider.animate({
 		 right: parseInt($slider.css('right'),10) == -415 ?
  		 0 : 415
	 });
});

$('a.backbutton').click(function() {
	
	//reset form and validation
	loginForm.resetForm();
	registerForm.resetForm();
	forgotForm.resetForm();
	$('#login-form')[0].reset();
	$('#forgotpassword-form')[0].reset();
	$('#register-form')[0].reset();
	$("#loginmodalalret").hide();
	$(".msg").hide();
    var $slider = $('.login-forgotpass');
    $slider.animate({
      right: parseInt($slider.css('right'),10) == 415 ?
       0 : -415
    });
});

//open register pop up
$('a.signup').click(function() {
	
	//reset form and validation
	loginForm.resetForm();
	registerForm.resetForm();
	forgotForm.resetForm();
	$('#login-form')[0].reset();
	$('#forgotpassword-form')[0].reset();
	$('#register-form')[0].reset();
	
	$("#registerdmessage").val('');
	$("#regsiterModelalert").hide();
	$("#register-form").show();
	$("#register-success").hide();
    
	
	var $slider = $('.login-signup');
    $slider.animate({
      right: parseInt($slider.css('right'),10) == -415 ?
       0 : 415
    });
});
		   
$('a.backbutton').click(function() {
	
	//reset form and validation
	loginForm.resetForm();
	registerForm.resetForm();
	forgotForm.resetForm();
	$('#login-form')[0].reset();
	$('#forgotpassword-form')[0].reset();
	$('#register-form')[0].reset();
	$("#loginmodalalret").hide();
	$(".msg").hide();
    var $slider = $('.login-signup');
    $slider.animate({
      right: parseInt($slider.css('right'),10) == 415 ?
       0 : -415
    });
});


</script>
<script>
$(".toggle-password").click(function() {

$(this).toggleClass("fa-eye fa-eye-slash");
var input = $($(this).attr("toggle"));
if (input.attr("type") == "password") {
input.attr("type", "text");
} else {
input.attr("type", "password");
}
});

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
	
$("#checkbox2").click(function() {
	if ($("#password-field").attr("type")=="password") {
	 $("#password-field").attr("type", "text");
	 }
	 else{
	 $("#password-field").attr("type", "password");
	}
});

	
</script>
</body>
</html>

