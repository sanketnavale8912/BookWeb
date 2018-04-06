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
		<li class="active">Document</li>
	</ol>
  </div>
  <!-- breadcrumb -->
  <div class="container-fluid">
   <!-- Main content -->
  	 <div class="col-xs-12 text-center">
  	 <a href="<%=appUrl %>/app/document/selfsign">
	  <div class="module_api" style="background-color: #fff">	  
	  	<img src="<%=appUrl %>/images/self.png" heigh="160px"/>
		 <span class="btn btn-yellow" style="background: #00bb9c;">Self Sign</span>		
	  </div>
	   </a>
	   <a href="<%=appUrl %>/app/document/groupsign">
	 <div class="module_api" style="background-color: #fff">
	  	<img src="<%=appUrl %>/images/group.png" heigh="160px"/>
		   <span class="btn btn-yellow " style="background: #00bb9c;">Group Sign</span>
	  </div>
	  </a>
     </div>
     
  </div>
  <!-- /.content --> 
 </div>  
<jsp:include page="footer.jsp"></jsp:include>