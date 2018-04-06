
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
    <li class="">pricing</li>
    <li class="active">DRYSIGN API PLANS</li>
</ul>
 
  <div class="row">
	  <div class="col-xs-12 text-center">
		  <h2>DrySign API Plans</h2>
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
    <li><div class="module_tab silver">
		  <div class="top-heading"> <span></span></div>
		  <h2>BASIC</h2>
		  <div class="price">
		  	$110
		  </div>
		  <div class="mid-content">
			  <p>50 API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents

</p>
		  </div>
		  <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
	  </div></li>
   <li> <div class="module_tab light-gray">
		  <div class="top-heading"> <span></span></div>
		  <h2>STANDARD</h2>
		  <div class="price">
			  $440 <span>Per user</span>
		  </div>
		  <div class="mid-content">
			  <p>200 API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents

</p>
		  </div>
		  <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
	  </div></li>
   <li><div class="module_tab golden">
		
		  
		      <div class="top-heading"> <span></span></div>
		  <h2>PREMIUM</h2>
		  <div class="price">
		  	$1100<span>Per user</span>
		  </div>
		  <div class="mid-content">
			  <p>500 API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents

</p>
		  </div>
		 <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
	  </div></li>	  
   <li><div class="module_tab dark-gray">
		  <div class="top-heading"> <span></span></div>
		  <h2>ENTERPRISE</h2>
		  <div class="price">
		  	$2200<span>Per user</span>
		  </div>
		  <div class="mid-content">
			  <p>HIGH VOLUME API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents

</p>
		  </div>
		  <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
	  </div></li>                                               
</ul>
   </div>
  </div>
  
  <div class="tab-pane" id="annually">
 	 <ul class="flexiselDemo3">
 	 <li>
  	 <div class="module_tab silver">
		  <div class="top-heading"> <span></span></div>
		  <h2>BASIC</h2>
		  <div class="price">
		  	$110
		  </div>
		  <div class="mid-content">
			  <p>50 API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents
</p>
		  </div>
		   <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
	  </div></li>
	  <li>
	  <div class="module_tab light-gray">
		  <div class="top-heading"> <span></span></div>
		  <h2>STANDARD</h2>
		  <div class="price">
			  $440 <span>Per user</span>
		  </div>
		  <div class="mid-content">
			  <p>200 API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents

</p>
		  </div>
		  <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
	  </div></li>
	  <li>
	  <div class="module_tab golden">
		  <div class="top-heading"> <span></span></div>
		  <h2>PREMIUM</h2>
		  <div class="price">
		  	$1100<span>Per user</span>
		  </div>
		  <div class="mid-content">
			  <p>500 API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents

</p>
		  </div>
		  <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
	  </div></li>
	  <li>
	  <div class="module_tab dark-gray">
		  <div class="top-heading"> <span></span></div>
		  <h2>ENTERPRISE</h2>
		  <div class="price">
		  	$2200<span>Per user</span>
		  </div>
		  <div class="mid-content">
			  <p>HIGH VOLUME API Signature Requests<br/>
Summary<br/>
Track documents history<br/>
View documents<br/>
Download Documents

</p>
		  </div>
		  <button class="buy-now" onclick="window.location.href='<%=appUrl %>/cart'">
		  	Buy Now
		  	
		  </button>
		  </div></li>
	  </ul>
  </div>

</div>


		</div>
	</div>

</div>

<jsp:include page="plan_footer.jsp" />