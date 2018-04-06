
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="plan_header.jsp" />
<% 

String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<div class="container-fluid">
 
 <!-- /.breadcrumb -->
 <ul class="breadcrumb">
    <li><a href="#">Home</a></li>
    <li class="active">pricing</li>
</ul>
 
  <div class="row">
	  <div class="col-xs-12 text-center">
	  	  
	  	  
 <c:choose>
	<c:when test="${not empty categories}">


	<c:forEach items="${categories }" var="category">
	  	  	
	  	  	<div class="module_api">
		  	<img src="<%=appUrl %>/images/1.0/api_GP.png" width=" 70px;"/>
			  <div class="heading-text">
				  DrySign<span>${category.name}</span>			  	
			  </div>
			  <button type="submit" value="ViewPlan" class="btn btn-api blue" onclick="window.location.href='<%=appUrl %>/plans?category_name=${category.name}&category=${category.category_id}'">View Plans</button>
		  	</div>
	  	 
	  	  </c:forEach>
		
    </c:when>
	<c:otherwise>
	<tr><td>There is no categories available.</td></tr>
	</c:otherwise>
</c:choose>
	  	  
	  	  
	  	  
	  	  
	  	  
		  
		  
		  <%-- <div class="module_api">
		  	<img src="<%=appUrl %>/images/1.0/api_.png" width=" 70px;"/>
			  <div class="heading-text">
				  DrySign<span>API Plans</span>			  	
			  </div>
			  <button type="submit" value="ViewPlan" class="btn btn-api red" onclick="window.location.href='<%=appUrl %>/plans?plan=api-plans'">View Plans</button>
		  </div> --%>
	  </div>
   
  </div>

</div>

<jsp:include page="plan_footer.jsp" />