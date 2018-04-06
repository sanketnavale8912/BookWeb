
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <jsp:include page="plan_header.jsp" />
<% 

String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<div class="container-fluid pricing_website">
 
	<div class="row bg-mess">
		<div class="message-info">
			<p><span><img src="images/1.0/smily.png"/></span>Your Payment was completed. <br/>Thank You for your order!  <br/>You purchased ${plan.currency.name} ${plan.price}</p>		
		</div>
	</div>
	
	<div class="row">
		<div class="message-info module">
			<div class="heading">
				<figur><img src="images/1.0/Gold-i.png"/></figur><h2>DRYSIGN ${plan.category.name }  <span>Successful Purchase!</span> </h2>
			</div>
			
			<div class="row">
			<div class="col-md-12" style="padding: 20px 30px">
			<div class="row">
				<div class="col-md-6 col-xs-6">Date</div>
				<div class="col-md-6 col-xs-6 text-right">${todayDate}<!-- 12.24.2016  01:10 (UTC -08:00) --></div>
			</div>
			<div class="row paddTB15">
				<div class="col-md-6 col-xs-6">Details</div>
				<div class="col-md-6 col-xs-6  text-right">${user.firstName} ${user.lastname}</div>
			</div>
			<div class="row paddTB15">
				<div class="col-md-6 col-xs-6">Transaction Number</div>
				<div class="col-md-6 col-xs-6  text-right">${transactionID}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-md-6 col-xs-6 total">Other Total</div>
				<div class="col-md-6 col-xs-6 text-right total-amt">${plan.currency.name} ${plan.price}	</div>
			</div>
			</div>				
			</div>
			<img class="stampimg" src="images/1.0/stamp.png"/>
		</div>
	</div>
	<div class="row text-center margTB20">
				<div class="col-md-12">
					<button onclick="window.location='app/dashboard'" type="submit" value="GO to dashboard" class="btn btn-primary font-24">Go To Dashboard</button>
				</div>
	</div>
			

 

</div>

<jsp:include page="plan_footer.jsp" />