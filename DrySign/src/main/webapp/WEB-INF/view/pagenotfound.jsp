<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" />

<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
 %>
 
<link rel="stylesheet" href="<%=appUrl %>/css/style.css"/>
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css"/>
 <div class="content-wrapper bg_wrap">
  <div class="container-fluid">
   <!-- breadcrumb -->
	<ol class="breadcrumb">
		<li><a href="<%=appUrl %>/app/dashboard">Home</a></li>
		<li class="active">PAGE NOT FOUND</li>
	</ol>
  </div>
  <!-- breadcrumb -->
  <div class="container-fluid">
   <!-- Main content -->
  	<div class="Content-wh-module text-center">
		   	
		   	  <img src="<%=appUrl %>/images/fail.png"/>		   	
			   <h4 class="message-text text-color-burmoda" style="color:#e83123">STATUS 404</h4>
			     <p>The document has not found
				</p>
				<button style="margin-top: 50px;" type="button" onClick="window.location.href = 'index.html';" value="GO to dashboard" class="btn btn-primary font-24">Go To Dashboard</button>
		   </div>   

  </div>
  <!-- /.content --> 
 </div>  
<jsp:include page="footer.jsp"></jsp:include>