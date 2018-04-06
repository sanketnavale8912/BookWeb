
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
    <style>
    ul.flexiselDemo3 li {
    float: none;
    display: inline-block;
    list-style: none;
}
.tab-content,.pricing_website {
    min-height: 450px;
}
    </style>
<div class="container-fluid pricing_website">
 
 <!-- /.breadcrumb -->
 <ul class="breadcrumb">
    <li><a href="login">Home</a></li>
    <li><a href="<%=appUrl %>/pricing">pricing</a></li>
    <li class="active"><%= request.getParameter("category_name") %></li>
</ul>

  <div class="row">
	  <div class="col-xs-12 text-center">
		  <h2><%= request.getParameter("category_name") %></h2>
	  </div>   
  </div>
	<div class="row">
		<div class="col-xs-12">
		<ul class="nav nav-tabs responsive" id="myTab">
  <li class="active"><a href="#monthly">monthly</a></li>
  <li><a href="#annually">annually</a></li>

</ul>

<div class="tab-content responsive">
<div class="tab-pane active" id="monthly">
<div>	  
<ul class="flexiselDemo3">
    
<c:choose>
<c:when test="${not empty plans}">  
<c:forEach items="${plans }" var="plan">
	<c:if test="${plan.duration.time == '30' }">
   <li> 
   	<div class="module_tab ">
		  <div class="top-heading"><span></span></div>
		  <h2>${plan.name }</h2>
		  <div class="price">${plan.currency.name} ${plan.price} <span>Per user</span></div>
		  <div class="mid-content">
			  <p>
			  <%-- <c:if test="${not empty plan.noOfUsers}">${plan.noOfUsers} users<br/></c:if> --%>
			  <c:if test="${not empty plan.noOfDocuments}">${plan.noOfDocuments} documents<br/></c:if>
			  <c:forTokens items="${plan.features }" delims="," var="splitPlan">
				   <c:out value="${splitPlan}"/></br>
				</c:forTokens>	
				</p>
		  </div>
		  <div class="buy-now">
		  <a href="#" class="buy-now" onclick="window.location.href='<%=appUrl %>/checkout?plan=${plan.token}&category=<%= request.getParameter("category_name") %>'">Buy Now</a>
	 </div>
	 </div>
	 
	</li>
	</c:if>
</c:forEach>
</c:when>
	<c:otherwise>
	<li style="min-height: 480px;">There is no plan available.</li>
	</c:otherwise>
</c:choose>                                        
</ul>
</div>
</div>
  
<div class="tab-pane" id="annually">
 	 <ul class="flexiselDemo3">	
 	 <c:choose>
	<c:when test="${not empty plans}">  
	<c:forEach items="${plans }" var="plan">
	<c:if test="${plan.duration.time == '365' }">
	  <li>
		  <div class="module_tab">
		  <div class="top-heading"><span></span></div>
		  <h2>${plan.name }</h2>
		  <div class="price">${plan.currency.name} ${plan.price} <span>Per user</span></div>
		  <div class="mid-content">
			  <p>
			  <%-- <c:if test="${not empty plan.noOfUsers}">${plan.noOfUsers} users<br/></c:if> --%>
			  <c:if test="${not empty plan.noOfDocuments}">${plan.noOfDocuments} documents<br/></c:if>
		
			  <c:forTokens items="${plan.features }" delims="," var="splitPlan">
				   <c:out value="${splitPlan}"/></br>
				</c:forTokens>	
				</p>
		  </div>
		   <div class="buy-now">
		  <a href="#" class="buy-now" onclick="window.location.href='<%=appUrl %>/checkout?plan=${plan.token}&category=<%= request.getParameter("category_name") %>'">Buy Now</a>
		  </div>
	 </div>
	  </li>
	  </c:if>
</c:forEach>
</c:when>
	<c:otherwise>
	<li style="min-height: 480px;" >There is no plan available.</li>
	</c:otherwise>
</c:choose>   	 
	  </ul>
  </div>

</div>


</div>
</div>
</div>

<jsp:include page="plan_footer.jsp" />