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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>Home | DrySign</title>

<!-- Bootstrap Core CSS -->
<link rel="stylesheet" href="<%=appUrl %>/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="<%=appUrl %>/css/fonts_icon.css" type="text/css">
<!-- Custom Fonts -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Plugin CSS -->
<link rel="stylesheet" href="<%=appUrl %>/css/animate.min.css" type="text/css">


<!-- Custom CSS -->

<link rel="stylesheet"  href="<%=appUrl %>/css/style1.css"/>
<link rel="stylesheet"  href="<%=appUrl %>/css/inner_page.css"/>
<link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style>
	.checkbox {
      margin-left: 20px;
}
.error {
    color: red;
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
</style>

</head>

<body>
<nav class="navbar navbar-default index inner-header">
  <div class="container"> 
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#defaultNavbar1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
      <a class="navbar-brand" href="#"><img src="<%=appUrl %>/images/Logo-w.png"/></a></div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse pull-right" id="defaultNavbar1">
      <ul class="nav navbar-nav">
      
       
      
        <li><a href="#product">Product</a></li> 
 		 <li><a href="#features">Features</a></li>
  		  <li><a href="pricing">Pricing</a></li>
  		    <li ><a href="api">API</a></li> 
        <li><a href="login">Sign in</a></li>
      </ul>
    </div>
    <!-- /.navbar-collapse --> 
  </div>
  <!-- /.container-fluid --> 
</nav>
<div class="container-fluid index pricing_website" style="padding: 0"> 
  <!-- Main Content -->
  
  
  
  <div class="feather_quill_pen"><img src="<%=appUrl %>/images/1.0/feather_quill_pen.png"></div>
<div class="container-fluid index-inner">

	<div class="container">
	
	<div class="col-md-7 col-sm-7 verticalmiddle-text">
		<section class="welcome-info-note">
		<span>DrySign is a digital signature platform enabling quick and secure contract signing.</span>
	</section>
	</div>
	
	

	
	
	<form id="indexregister">
	<div class="col-md-5 col-sm-5">
		<div class="welcome-note "  >
		
			<div class="message text-center" id="register-success" style="display:none;padding: 30px;">
					   <p><img src="<%=appUrl %>/images/message-bg.png"/></p>
					   <h4>YOUR ACCOUNT HAS BEEN CREATED!</h4>
					  <!--  <p>Congratulations! Your new account has been successfully created.</p> -->
					   <p>You will soon receive an email with a link to activate your new account.</p>
					      <a href="login" class="btn backbutton btn-link continuelink">CONTINUE TO DRYSIGN</a>                   
				   </div>
				   
				 	<div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="regsiterModelalert">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="registerdmessage"></div>
					</div> 
		
		
			<div class="get_info">
			<h4 class="margB20 "  data-wow-delay=".4s">SIGN-UP FOR A FREE TRIAL <br>OF DRYSIGN TODAY</h4>
			<br/><br/>
				<div class="row ">
					<div class="col-xs-12 " >
					<div  class="row">
						<div class="col-md-6 col-sm-6 margB20">
						<input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name"/>
						</div>
						<div class="col-md-6 col-sm-6 margB20">
						<input type="text" class="form-control"  id="lastname" name="lastname" placeholder="Last Name"/>
						</div>
					
					</div>
					
					</div>
					
					<div class="col-xs-12 " ><input type="text" class="form-control" id="email" name="email"  placeholder="Email"/></div>
				
						<div class="col-xs-12  margTB20 " ><input type="password" id="password-field1" name="password" class="form-control" placeholder="Password"/></div>
				
				</div>
				<div class="row">
				<div class="col-md-6 col-sm margTB20 ">
					<div class="checkbox checkbox-primary">
                              <input type="checkbox" id="termsandcondition" name="termsandcondition">
                              <label for="termsandcondition"> terms & conditions</label>
                            
                           </div>
						</div>
					<div class="col-md-6 col-sm margTB20 " ><button id="signupbtn" type="button" class="btn btn-primary btn_fullwidth font-18" placeholder="" onclick="register();" style="background-color: #0FC0A2;background: linear-gradient(267deg, #00B998 0%, #02C7C8 100%);">Submit</button></div>
				</div>
				  <label style="float: none;" for="termsandcondition" class="error" generated="true"></label>
			</div> 
		</div>
		</div>
		</form>
	</div>
	<div class="inner-wh-div"></div>
</div>
</div>

	<div class="container" style="margin-bottom: 100px;">
			<section class="section_mar" id="product" style="outline: none;">
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<h2 class="section-heading">Product</h2>
                </div>
		    </div>
            <div class="row">
                <div class="col-md-6 col-sm-6 " data-wow-delay=".1s">
                    <img class="img-responsive" src="<%=appUrl %>/images/website_section_01.png" />
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="Platform">
					<div class="row mbottom60">
						<div class="col-md-2 col-sm-3 product-iconbox col-xs-3">
							<i class="icon1 icon1-secure"></i>
						</div>
						 <div class="col-md-10 col-sm-9 col-xs-9">
							<div class="head_solustion" data-wow-delay=".4s">
								<h2 class="font-24">Secure and Accessible </h2>
								<p>Exchange contracts and documents with individuals or groups to be signed digitally in a user friendly, secure hosted environment.</p>
							</div>
						 </div>
					</div>
					<div class="row">
						<div class="col-md-2 col-sm-3 product-iconbox col-xs-3">
							<i class="icon1 icon1-platform"></i>
						</div>
						 <div class="col-md-10 col-sm-9 col-xs-9">
							<div class="head_solustion" data-wow-delay=".4s">
								<h2 class="font-24">Platform Integrated </h2>
								<p>Available for seamless integration with your applications, creating a better user experience through streamlined contract execution.</p>
							</div>
						 </div>
					</div>                          
                    </div>
                </div>

            </div>


        </section>
        
        		<section class="section_mar" >
			
            <div class="row">
                <div class="col-md-4 col-sm-4 text-right" data-wow-delay=".1s">
						<div class="col-md-12 col-sm-12 text-right mbottom110" data-wow-delay=".1s" style="padding:0px;"> 
							 <div class="col-xs-3 text-center data-iconbox hidden-lg hidden-md hidden-sm">
									<img class="img-responsive" src="<%=appUrl %>/images/Documen-signature-request.png" />
							 </div>
							<div class="head_solustion col-xs-9 col-md-12 col-sm-12" data-wow-delay=".4s">
								<h2 class="font-24">Document signature request</h2>
								<p>Obtain signatures in seconds by sending an invitation to the secure DrySign platform</p>
							</div>
						</div>
						<div class="col-md-12 col-sm-12 text-right" data-wow-delay=".1s" style="padding:0px;"> 
						     <div class="col-xs-3 text-center data-iconbox hidden-lg hidden-md hidden-sm">
									<img class="img-responsive" src="<%=appUrl %>/images/Hierarchical-signature.png" />
							 </div>
							<div class="head_solustion  col-xs-9 col-md-12 col-sm-12" data-wow-delay=".4s">
								<h2 class="font-24">Hierarchical signature </h2>
								<p>Multiple signature capability enabling users to specify the preferred order of signature execution </p>
							</div>
						</div>

                </div>
				
			
				<div class="col-md-4 col-sm-4 hidden-xs" data-wow-delay=".1s">
						<img class="img-responsive" src="<%=appUrl %>/images/image01a.png" />

                </div>
				
				<div class="col-md-4 col-sm-4 text-left" data-wow-delay=".1s">
						<div class="col-md-12 col-sm12 text-left mbottom110" data-wow-delay=".1s" style="padding:0px;"> 
							 <div class="col-xs-3 text-center data-iconbox hidden-lg hidden-md hidden-sm">
									<img class="img-responsive" src="<%=appUrl %>/images/Secure-documents.png" />
							 </div>
							<div class="head_solustion col-xs-9 col-md-12 col-sm-12" data-wow-delay=".4s" >
								<h2 class="font-24">Secure documents archival</h2>
								<p>Documents are stored electronically with a complete audit trail, enabling the user to search for and download executed documents</p>
							</div>
						</div>
						<div class="col-md-12 col-sm12 text-left" data-wow-delay=".1s" style="padding:0px;"> 
							<div class="col-xs-3 text-center data-iconbox hidden-lg hidden-md hidden-sm">
									<img class="img-responsive" src="<%=appUrl %>/images/Seamless-integration.png" />
							 </div>
							<div class="head_solustion col-xs-9 col-md-12 col-sm-12" data-wow-delay=".4s" >
								<h2 class="font-24">Seamless integration with applications </h2>
								<p>Can be integrated with other applications through an API, enabling digital signature capabilities in your applications </p>
							</div>
						</div>						
                </div>
				</div>
				
				<div class="row">
						<div class="col-md-4 col-sm-4 text-center mbottom110 securitybox" style="padding:0px;margin: 20px auto; float: none; margin-bottom: 0px;"> 
							<div class="col-xs-3 text-center data-iconbox hidden-lg hidden-md hidden-sm">
									<img class="img-responsive" src="<%=appUrl %>/images/Improved-authantication-and-security.png" />
							 </div>
							
							<div class="head_solustion col-xs-9 col-md-12 col-sm-12" data-wow-delay=".4s">
								<h2 class="font-24">Improved authentication and security</h2>
								<p>Single or multi-factor authentication capabilities depending on user preference</p>
							</div>
						</div>
				</div>


        </section>
		
        
	
		 <section class="section_mar"  id="features" style="outline: none;">
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<h2 class="section-heading">For Users</h2>
                </div>
		    </div>
            <div class="row">
				 <div class="col-md-6 col-sm-6">
                    <div class="Platform">
					<div class="row mbottom20">
						 <div class="col-md-12 col-sm-12">
							<div class="head_solustion" data-wow-delay=".4s">
								<h2 class="font-24">Sign Documents Digitally </h2>
								<p>All you need is an internet connection and your mobile phone or a desktop</p>
							</div>
						 </div>
					</div>
					
					<div class="row mbottom20">
						 <div class="col-md-12 col-sm-12">
							<div class="head_solustion" data-wow-delay=".4s">
								<h2 class="font-24">Group Sign </h2>
								<p>Send documents to multiple people for their signature</p>
							</div>
						 </div>
					</div>
					
					<div class="row mbottom20">
						 <div class="col-md-12 col-sm-12">
							<div class="head_solustion" data-wow-delay=".4s">
								<h2 class="font-24">Visibility</h2>
								<p>Track the status of documents that need multiple signatures</p>
							</div>
						 </div>
					</div>
					
					<div class="row mbottom20">
						 <div class="col-md-12 col-sm-12">
							<div class="head_solustion" data-wow-delay=".4s">
								<h2 class="font-24">Records</h2>
								<p>View signature history</p>
							</div>
						 </div>
					</div>
					                       
                    </div>
                </div>
                <div class="col-md-6 col-sm-6 " data-wow-delay=".1s">
                    <img class="img-responsive" src="<%=appUrl %>/images/website_section_02.png" />
                </div>
               

            </div>


        </section>
	
	 <section class="section_mar">
            <div class="row">
				<div class="col-md-7 col-sm-7 text-center ">
                    <img class="img-responsive" src="<%=appUrl %>/images/website_section_03.png" />
                </div>
                <div class="col-md-5 col-sm-5  " data-wow-delay=".5s">
				
						<div class="row">
							<div class="col-md-12 col-sm-12">
								<h2 class="section-heading">For Developers</h2>
							</div>
						</div>
						<div class="row mbottom20">
						 <div class="col-md-12 col-sm-12">
							<div class="head_solustion" data-wow-delay=".4s">
								<p>Seamlessly integrate with applications through our API, which enables digital signature capabilities in your systems. </p>
							</div>
						 </div>
						</div>
                   

                </div>
            </div>
        </section>
	
	<section class="section_mar contactus">
		<div class="row">
				
				<div class="col-md-12 col-sm-12">
					<h2 class="section-heading">Contact Us</h2>
                </div>
		    
		</div>
		<div class="row">
			<div class="col-md-5 col-cs-5 ">
				<ul>
					<li class="" ><figure><img src="<%=appUrl %>/images/phone-i.png"/></figure>Have a Question? Call us on <span>+1-770-776-2509</span></li>
					<li class="" data-wow-delay=".8s"><figure><img src="<%=appUrl %>/images/mail-box-i.png"/></figure>Drop us an email on <span> support@drysign.global</span></li>
					
				</ul>
				
			</div>
			<form id="submitquery">
			<div class="col-md-7 col-cs-7  "  data-wow-delay=".1s">
			<div class="alert alert-success fade in" style="display:none;text-align:center;margin: 0px;" id="emailsuccessalert">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="emailsuccess">Your Query has been sent successfully,We will get back to you soon.</div>
					  </div> 
					  <div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="emailfailalert">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="emailfail"></div>
					  </div> 
				<div class="row margTB20">
					<div class="col-xs-6" >
						<input type="text" id ="queryName" name="name" class="form-control" placeholder=" Name"/>
					</div>
					<div class="col-xs-6 " >
						<input type="text" id ="queryemail" name="email" class="form-control" placeholder="Email"/>
					</div>
					<div class="col-xs-12 margTB20 text-left" >
						<textarea class="form-control" id="querymessage" name="message" rows="10" placeholder="Message"></textarea>
					</div>
					<div class="col-xs-12 text-right">
					<button type="button" class="btn has-spinner btn-primary" id="sendquerybtn" onclick="sendquery();">Send</button>
						<!-- <button type="button"  class="btn has-spinner greenButton"  >Send</button> -->
					</div>
				</div>
				
			</div>
			</form>
		</div>
			
	
	</section>
	</div>
	<div class="footer">
    <div class="text-center">
   <span class="icon-language"></span>  ENGLISH |
    &copy; Copyright  <script>document.write(new Date().getFullYear())</script> Exela Technologies Inc., All Rights Reserved.
</div>
</div>
<!-- jQuery --> 
<script src="<%=appUrl %>/js/jquery.min.js"></script>
<!-- Plugin JavaScript --> 
<script src="<%=appUrl %>/js/jquery.easing.min.js"></script> 
<script src="<%=appUrl %>/js/wow.min.js"></script> 
<script src="<%=appUrl %>/js/bootstrap.js"></script> 
<script src="<%=appUrl %>/js/jquery.validate.js"></script>
<script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>

<!-- Custom Theme JavaScript --> 

<script type="text/javascript">
    

$(document).ready(function(){
	document.getElementById("email").value = "";
	document.getElementById("password-field1").value = "";
});
	 // Initialize WOW.js Scrolling Animations
  new WOW().init();
	 
	var indexregisterform = $("#indexregister").validate({
		//specify the validation rules
		rules : {
			email : {
				required : true,
				email : true
			//email is required AND must be in the form of a valid email address
			},
			firstName : {
				required : true
			},
			lastname : {
				required : true
			},
			password : {
				required : true,
				minlength: 8
			},
			termsandcondition: {
				required : true
			}

		},
		//specify validation error messages
		messages : {
			email : {
				required : "Please enter a valid email address",
				email : "Please enter a valid email address"
			},
			firstName : {
				required : "Please enter First Name",

			},
			lastname : {
				required : "Please enter Last Name",

			},
			password : {
				required : "Please enter a password",
				minlength: "Your password must be at least 8 characters long"

			},
			termsandcondition: {
				required : "Please accept terms and conditions"
			}
		}
	});

	var submitqueryform = $("#submitquery").validate({
		//specify the validation rules
		rules : {
			email : {
				required : true,
				email : true
			//email is required AND must be in the form of a valid email address
			},
			name : {
				required : true
			},
			message : {
				required : true
			}
			

		},
		//specify validation error messages
		messages : {
			email : {
				required : "Please enter a valid email address",
				email : "Please enter a valid email address"
			},
			name : {
				required : "Please enter Name",

			},
			message : {
				required : "Please write your query",

			}
			
		}
	});

	
	function register(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		var valid = $("#indexregister").valid();
		if(valid == true){
			var data = {
		    	      "firstName" : $("#firstName").val(),
		    	      "lastname" :$("#lastname").val(),
		    	      "email" :$("#email").val(),
		    	      "password" :$("#password-field1").val()
		    	     // "confirmpassword" :$("#password-field2").val()	    	     
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
						$(".get_info").hide();
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
	
	
	/* function indexregister(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath = $("#contextPath").val();
		var valid = $("#indexregister").valid();
		if (valid == true){
			alert("success");
		}
		else{
			alert("Try Again");
		}
	} */
	
	function sendquery() {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath = $("#contextPath").val();
		var name = $('#queryName');
		var email = $('#queryemail');
		var message = $("#querymessage");
		var valid = $("#submitquery").valid();
		/* 		var data = {
		 "name" : name.val(),
		 "email" : email.val().trim(),
		 "message" : message.val()	     
		 } */
		if (valid == true) {
			$.ajax({
				type : "POST",
				url : "submitquery",
				data : {
					name : name.val(),
					email : email.val().trim(),
					message : message.val()
				},
				//	data : JSON.stringify(data),
				//	contentType: "application/json; charset=utf-8",
				beforeSend : function(xhr) {
					$('#sendquerybtn').buttonLoader('start');
					xhr.setRequestHeader(header, token);
				},
				complete : function() {
					$("#sendquerybtn").buttonLoader('stop');
				},

				success : function(response) {
					if (response == 1) {
						$("#emailsuccessalert").show();
						

					} else {
						
						 $("#emailfailalert").show();
						$("#emailfail").html(response); 
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert('ajax loading error... ... ');
					return false;
				}
			});
		}
	}
	
	
	// Select all links with hashes
	$('a[href*="#"]')
	  // Remove links that don't actually link to anything
	  .not('[href="#"]')
	  .not('[href="#0"]')
	  .click(function(event) {
	    // On-page links
	    if (
	      location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
	      && 
	      location.hostname == this.hostname
	    ) {
	      // Figure out element to scroll to
	      var target = $(this.hash);
	      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
	      // Does a scroll target exist?
	      if (target.length) {
	        // Only prevent default if animation is actually gonna happen
	        event.preventDefault();
	        $('html, body').animate({
	          scrollTop: target.offset().top
	        }, 1000, function() {
	          // Callback after animation
	          // Must change focus!
	          var $target = $(target);
	          $target.focus();
	          if ($target.is(":active")) { // Checking if the target was focused
	            return false;
	          } else {
	            $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
	            $target.focus(); // Set focus again
	          };
	        });
	      }
	    }
	  });
	

</script> 


</body>
</html>
