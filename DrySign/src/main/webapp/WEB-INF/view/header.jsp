<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.drysign.model.Registration,org.springframework.security.core.context.SecurityContextHolder,org.springframework.security.core.Authentication" %>

<% Authentication auth = SecurityContextHolder.getContext().getAuthentication(); %>
<% Registration registration = (Registration)auth.getPrincipal(); %>
<% 
String fileName="user.png";
if(registration.getPhoto() != null) 
	{
		fileName = registration.getPhoto();
	}
String picPath = "images/profile/"+fileName;
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<%
if(auth == null){
	
}
%>
<!DOCTYPE html>
<html manifest="ie11WebSite.appcache">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge;" />-->
<title>${title} | DrySign</title>




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





<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="<%=appUrl %>/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<link href="<%=appUrl %>/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
<!-- custom style -->
<link rel="stylesheet" href="<%=appUrl %>/css/icons.css"/>
<link rel="stylesheet" href="<%=appUrl %>/css/fonts_icon.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.css">

<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
<input type="hidden" id="fullName" value="<%=registration.getFirstName()%> <%=registration.getLastname()%>" />
<input type="hidden" id="firstName" value="<%=registration.getFirstName()%>" />
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper"> 
  <!-- Main Header -->
  <header class="main-header"> 
    <!-- Logo --> 
    <a href="<%=appUrl %>/app/dashboard" class="logo"> 
    <!-- mini logo for sidebar mini 50x50 pixels --> 
    <span class="logo-mini"><img style="height: 62px;" cllogass="img-responsive" src="<%=appUrl %>/images/drysignlogo_mob.png"  alt="logo"></span> 
    <!-- logo for regular state and mobile devices --> 
    <span class="logo-lg hidden-xs"><img cllogass="img-responsive" src="<%=appUrl %>/images/drysignlogo.png" height="auto"  alt="logo"> </span>
      <span class="logo-lg visible-xs"><img  cllogass="img-responsive" src="<%=appUrl %>/images/drysignlogo_mob_.png" height="auto"  alt="logo"> </span> </a> 
    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation"> 
      <!-- Sidebar toggle button--> 
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span class="sr-only">Toggle navigation</span> </a> 
     <!-- <a href="#" class="sidebar-toggle"  role="button"> <span class="sr-only">Toggle navigation</span> </a>  -->
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <li class="m-view"><i class="icon1-phone callnumber"></i><span class="Tel-No">+1-770-776-2509</span></li>
          <!-- <li class="m-view"><button class="btn btn-buy" onclick="location.href = '../pricing';">BUY NOW</button></li>
 -->          <li class="m-view">
            <!-- <button type="submit" value="Upgrade" class="btn btn btn_2">Upgrade</button> -->
          </li>
          <li class="m-view user"> 
            <!-- Inner Menu: contains the notifications -->
            <ul class="menu">
              <li> 
                <!-- Sidebar user panel (optional)-->
                <div class="user-panel">
                  <div class="pull-left image">
                   <%-- <img src="<%=appUrl %>/images/user.png" class="img-circle" alt="User Image" height="100px" width="200px"> --%> 
                   <img src="<%=appUrl %>/images/user.png" class="img-circle" alt="User Image" height="100px" width="200px">
                   </div>
                  <div class="pull-left info">
                    <p id="profileName"><% if (registration != null) { %>
					 		<%=registration.getFirstName()%> <%=registration.getLastname()%> 
						   <% } %> </p>
                    <!-- Status --> 
                  </div>
                </div>
              </li>
              <!-- end notification -->
            </ul>
          </li>
          <li class="dropdown "> 
            <!-- Menu toggle button --> 
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true"> <i class="fa fa-ellipsis-v" aria-hidden="true"></i></a>
            <ul class="dropdown-menu" id="drpdwn">
              <li><a href="<%=appUrl %>/app/profile">Profile</a></li>
<%--               <li><a href="<%=appUrl %>/app/changePasword">Password</a></li>
              <li><a href="<%=appUrl %>/app/settings">Settings</a></li> --%>
              <li><a href="#" class="logout">Logout</a></li>
              <li class="bottom"></li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar"> 
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar"> 
      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" id="headernavigation">
        <li><a href="<%=appUrl %>/app/dashboard"><i class="icon-dashboard"></i><span>DASHBOARD</span></a></li>
        <li ><a href="<%=appUrl %>/app/document"><i class="icon-document"></i><span>DOCUMENT</span></a></li>
        <li><a href="#"><i class="icon-history"></i><span>HISTORY</span> <i class="fa fa-angle-left pull-right"></i></a>        
			<ul class="treeview-menu" id="headersubnavigation">
				<li><a href="<%=appUrl %>/app/history/completedDocuments">COMPLETED DOCUMENTS</a></li>
				<li><a href="<%=appUrl %>/app/history/outforSignature">OUT FOR SIGNATURE</a></li>
				<li><a href="<%=appUrl %>/app/history/draft">DRAFT</a></li>				
			</ul>
        </li>
      </ul>
      <!-- /.sidebar-menu --> 
    </section>
    <!-- /.sidebar --> 
  </aside>
  <script type="text/javascript">
  setInterval(function() {
	  var contextPath=$("#contextPath").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
	    $.ajax({type: 'POST',
        	url: contextPath+'app/session',
    	         beforeSend : function(xhr) {
    			xhr.setRequestHeader(header, token);
    		},
    		success: function (result) {
    	        userInSession = result.userInSession;
    	        console.log("in session");
    	    },
	    	
	    error: function(request, textStatus, errorThrown) {
	         //load login page
	    	$.confirm({
	    	    title: 'Session Timedout!',
	    	    content: ' ',
	    	    buttons: {
	    	        somethingElse: {
	    	            text: 'Ok',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	            	window.location = contextPath+"logout";
	    	            }
	    	        }
	    	    }
	    	});
	    	       
	        }
	    });
	}, 1830000)
</script>