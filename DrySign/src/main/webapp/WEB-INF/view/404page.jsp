<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<% String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>${title} | DrySign</title>
<!-- Bootstrap -->
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<link href="<%=appUrl %>/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet"  href="<%=appUrl %>/css/style.css"/>
<link rel="stylesheet"  href="<%=appUrl %>/css/inner_page.css"/>
<style>
.footer{
	position: fixed;
    bottom: 0;
    width: 100%;
    height: 60px;
    z-index: 99999;
}
</style>
</head>
<body>
<nav class="navbar navbar-default inner-header">
  <div class="container-fluid"> 
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header" style="width: 100%">
      <a class="navbar-brand" href="#"><img src="<%=appUrl %>/images/logo_inner.png"/></a>
    
   </div>
  </div>
  <!-- /.container-fluid --> 
</nav>
<div class="container-fluid" style="margin-top: 100px;">
	<div class="Content-wh-module text-center" id="401error" style="display:none;margin-top: 20px;" >
		<img src="<%=appUrl %>/images/fail.png"/>		   	
		<h4 class="message-text text-color-burmoda" id="error-messgae-401" style="color:#e83123">You have already signed the document</h4>
		<p class="font-16" style="margin-top: 50px; width: 600px; max-width: 90%;margin: 0 auto; "></p>
	  	<!-- <a style="margin-top: 50px;" href="login" class="btn btn-primary font-24">Go To Login</a> -->
   </div>   
   <div class="Content-wh-module text-center" id="404error" style="display:none;margin-top: 20px;">
		<img src="<%=appUrl %>/images/fail.png"/>		   	
		<h4 class="message-text text-color-burmoda" id="error-messgae-404" style="color:#e83123">404 Status</h4>
		<p class="font-16" style="margin-top: 50px; width: 600px; max-width: 90%;margin: 0 auto; "><span id="errorMsg"></span></p>
	  	<!-- <a style="margin-top: 50px;" href="login" class="btn btn-primary font-24">Go To Login</a> -->
   </div> 
   <div class="Content-wh-module text-center" id="402error" style="display:none;margin-top: 20px;">
		<img src="<%=appUrl %>/images/fail.png"/>		   	
		<h4 class="message-text text-color-burmoda" id="error-messgae-402" style="color:#e83123"></h4>
		<p class="font-16" style="margin-top: 50px; width: 600px; max-width: 90%;margin: 0 auto; "></p>
   </div>   
</div>
<!--/.Footer -->
<div class="footer">
	<div class="text-center">
		Copyrights  &copy; <script>document.write(new Date().getFullYear())</script> Exela Technologies Inc., All Rights Reserved.
	</div>
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/bootstrap.js"></script>
<script>	
$(window).on("load resize", function() {
    var viewportWidth = $(window).width();
    if (viewportWidth < 768) {
	(function($) {
            $(document).ready(function() {
				//alert('hi');
              $( ".m-view" ).prependTo( ".dropdown-menu li.bottom" );
 				$( ".m-view.user" ).prependTo( ".dropdown-menu" );  
            });
         }) (jQuery);
    }
});	
$(document).ready(function(){
	var flag='${flag}';
	//alert('${errorMsg}');
	var errorMsg='${errorMsg}';
	if(flag == 401){
		$("#error-messgae-401").html(errorMsg);
		$("#404error").hide();
		$("#402error").hide();
		$("#401error").show();
	}
	if(flag == 402){
		$("#error-messgae-402").html(errorMsg);
		$("#404error").hide();
		$("#401error").hide();
		$("#402error").show();
	}
	if(flag == 404){
		$("#errorMsg").html(errorMsg);
		$("#401error").hide();
		$("#402error").hide();
		$("#404error").show();
	}
});
</script>
</body>
</html>
