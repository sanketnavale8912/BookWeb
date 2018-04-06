<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
 <%@ page import="com.drysign.model.Registration,org.springframework.security.core.context.SecurityContextHolder,org.springframework.security.core.Authentication" %>
 
 <jsp:include page="plan_header.jsp" />

 <% Authentication auth = SecurityContextHolder.getContext().getAuthentication(); %>

<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<link href="<%=appUrl %>/css/materialize.css" rel="stylesheet"/>
 <link href="<%=appUrl %>/css/creditly.css" rel="stylesheet"/>
 
   <link rel="stylesheet" type="text/css" href="<%=appUrl %>/css/inner_page.css" />
 <script src="<%=appUrl %>/js/creditly.js"></script>
 <link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
 
 <style>

   .inner-header.navbar-default .navbar-nav>li>a {
  
    font-family: 'Roboto-regular';
   }
   
   .pricing_website h2 , .wh-module .heading{
    font-family: roboto-regular;
    font-weight: 500;
}
</style>
 <script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
<div class="container-fluid pricing_website" style="background: #eeeeee;">
  <div class="row"> 
    <div class="col-md-6 col-sm-12 paymentform" style="background: #fff"> 
      <!-- /.breadcrumb -->
      <ul class="breadcrumb">
        <li>Home</li>
        <li class="">pricing</li>
        <li ><%= request.getParameter("category") %></li>
        <li >CHECKOUT</li>
       <!--  <li class="active">Payment Method</li> -->
      </ul>
      <c:url var="cartUrl" value="cartSubmit"/>


<div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="checkouterror">
  	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
	<div id="checkouterrormessage"></div>
</div> 
<div class="alert alert-success" style="display:none;" id="checkoutsuccess">
  	<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
  	<div id="checkoutsuccessmessage"></div>
</div> 


		<form name="cart"  class="login-form" role="form" id="checkoutform" action="checkout" method="post">
		<div class="info-payment" style="padding: 20px 50px;">
		<input type="hidden" name="token" value="${token}" />
		
		<h2 class="font-24">ACCOUNT AND PAYMENT</h2> 
			
			<div class="row">
				<div class="col-md-12">
				<% if(auth.getPrincipal().equals("anonymousUser")){ %>
						<h3> <a style="color: #000" href="registration" target="_BLANK">Create Your Account</a> <span> <em>or</em> <a style="    color: #00b497;" href="login">use an existing account</a> </span></h3>
					<% }else{ Registration registration = (Registration)auth.getPrincipal(); %>
						<h3>You are logged in as : <a style="    color: #00b497;"  href="app/profile"><%=registration.getFirstName() %> <%=registration.getLastname() %></a></h3>
					<%}%>
					
					
					
				</div>
				
				
	</div>
		</div>
     
      <hr/ style="margin:0;">
      <div class="info-payment creditly-wrapper gray-theme" style="padding: 20px 50px;">
			
			<div class="row credit-card-wrapper">
				<div class="col-md-12">
					<h3>Payment Information</h3>
				</div>
				
				
				<div class="col-md-12">
				
						<div class="col-md-6 col-sm-6">
					<div class="input-field">
						<select name="cardtype" id=cardtype>
							<option value="1">DEBIT</option>
							<option value="0">CREDIT</option>
						</select>
	     				
						<label for="">Card Type</label>
					</div>			
					</div>
					
					<div class="col-md-6 col-sm-6">
					<div class="input-field">
	     				<input id="cardnumber" type="text" class="validate number credit-card-number form-control" name="number" pattern="(\d*\s){3}\d*"
	     				inputmode="numeric" autocomplete="cc-number" autocompletetype="cc-number" x-autocompletetype="cc-number"
                    placeholder="&#149;&#149;&#149;&#149; &#149;&#149;&#149;&#149; &#149;&#149;&#149;&#149; &#149;&#149;&#149;&#149;">
						<div id="cardname" class="card-type" style="position: absolute;top: 12px;right: -15px"></div>
						<label for="">Card Number</label>
					</div>			
					</div>
					
				</div>
								
				
				<div class="col-md-12">
					<div class="">
						<div class="col-md-6 col-sm-6">
							
							<div class="input-field">
     						<input id="nameoncard" class="billing-address-name form-control" type="text" name="name" placeholder="Name on Card">
							<label for="">Name on Card</label>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="row">
								<div class="col-md-6 col-xs-6">
									<div class="input-field ">
   									<input id="expirationdate" class="expiration-month-and-year form-control" type="text" name="expiration-month-and-year" placeholder="MM / YY">
								    <label>Expiration Date</label>
								    </div>
									
								</div>
								<div class="col-md-6 col-xs-6">
									
									<div class="input-field ">
									<input id="cvv" class="security-code form-control" inputmode="numeric" pattern="\d*" type="text" name="security-code" placeholder="&#149;&#149;&#149;">
									
									<label for="">CVV</label>
									    <label></label>
									  </div>
								</div>
								
							</div>
						</div>
						
					</div>
				
				</div>
				
			</div>
		</div>
     
      <hr/ style="margin:0;">
    
     <div class="info-payment" style="padding: 20px 50px;">
			
			
		 <div class="row">
			 <div class="col-md-12">
				 <button type="button" class="btn btn-primary creditly-gray-theme-submit" style="min-width: 100%; margin-bottom: 10px;">PURCHASE PLAN</button>
				 <p>By clicking the "PURCHASE PLAN" button above, you agree to the <a href="#">Terms & Conditions, Privacy Policy</a> and automatically recurring billing subscription with DrySign.</p>
			 </div>
		 </div>
		</div>
       </form> 
    </div>
    <div class="col-md-6 col-sm-12" > 
		<div class="wh-module order-summery">
			<div class="row">
				<div class="col-md-12">
					<div class="heading">Order Summary</div>					
				</div>
				
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6 text-info">
							<%= request.getParameter("category") %> ${plan.name } <br/><small>${plan.noOfUsers } user<br/>${plan.duration.name }</small>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 text-right">${plan.price } ${plan.currency.name }</div>
					</div>
										
				</div>
				<div style="border-bottom: 1px solid #00bc9c; clear: both; margin: 2px 0"></div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6 text-info">
							Sub Total
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 text-right">${plan.price } ${plan.currency.name }</div>
					</div>
									<div class="row">
						<!-- <div class="col-md-6 col-sm-6 col-xs-6 text-info">
							Promo code
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 text-info text-right" >Add Code</div> -->
					</div>
										
				</div>
				<div style="border-bottom: 1px solid #00bc9c; clear: both; margin: 2px 0"></div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6 font-24">
							Total
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 font-24 text-right">${plan.price } ${plan.currency.name }</div>
					</div>
									
										
				</div>
				
			</div>
			<div class="add-img">
			<div class="img-info">
				<h3 class="heading">QUESTIONS</h3>
				<span><a href="#">view FAQs</a> or<a href="#"> Email Support</a></span>
			</div>
			</div>
			
		</div>
    </div>
  </div>
</div>

<jsp:include page="plan_footer.jsp" />
	<script src="<%=appUrl %>/js/materialize.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	var DocHeight = $(window).height()
	$(".paymentform").height(DocHeight-150);
	
	   Materialize.updateTextFields();
	   $('select').material_select();
}); 

$(function() {
    // For the gray theme
    var grayThemeCreditly = Creditly.initialize(
        '.creditly-wrapper.gray-theme .expiration-month-and-year',
        '.creditly-wrapper.gray-theme .credit-card-number',
        '.creditly-wrapper.gray-theme .security-code',
        '.creditly-wrapper.gray-theme .card-type');

    $(".creditly-gray-theme-submit").click(function(e) {
      e.preventDefault();
      $("#checkouterror").hide();
      $("#checkoutsuccess").hide();
      var output = grayThemeCreditly.validate();
      if (output) 
      {
        // Your validated credit card output
          
        
        checkoutProcess();
    
       /*  var abc =  {
        		  "status": "success",
        		  "message": "1",
        		  "transactionid": "17C102000001119"
        		};
        alert(abc["status"]); */
        
        
        //console.log(output);  
      }
      
    });      
  });

function checkoutProcess()
{
	
	$(".credit-card-number").removeClass("has-error");
	$(".expiration-month-and-year").removeClass("has-error");
	$(".security-code").removeClass("has-error");
	
	$("#checkouterror").hide();
    $("#checkoutsuccess").hide();
    
    var cardtype = $("#cardtype").val().trim();
    var cardnumber = $("#cardnumber").val().trim();
    var nameoncard = $("#nameoncard").val().trim();
    var expirationdate = $("#expirationdate").val().trim();
    var cvv = $("#cvv").val().trim();
    var cardname = $("#cardname").text().trim();
   
    var split = expirationdate.split("/");
    var month = split['0'];
    var year = split['1'];
    
    var plan_token = "${token}";
    var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	data = {"card_number":cardnumber,"card_type":cardname,"cardholder_name":nameoncard,"cvv2":cvv,"expire_month":month,"expire_year":year,"payment_cardtype":cardtype};
	$.ajax({
		type : "POST",
	    url: "checkusersession?token="+plan_token,
	    data:JSON.stringify(data), 
	    contentType: "application/json",
	    //dataType: "json",
	    beforeSend : function(xhr) {
	    	$('.creditly-gray-theme-submit').buttonLoader('start');
			 xhr.setRequestHeader(header, token);
			
		},
		complete : function() {
			$(".creditly-gray-theme-submit").buttonLoader('stop');
		},
		
		success : function(response) {
			
			var res = response.split(":");
			var status = res[0];
			var transactionid = res[1];
			var message = res[2];
			
			
			if(message == "notlogin"){
				$("html, body").animate({ scrollTop: 0 }, 1000);
				$("#checkouterror").show();
				$("#checkouterrormessage").html("Kindly login to proceed...");
			} else if(message == "activeplan"){
				$("html, body").animate({ scrollTop: 0 }, 2000);
				$("#checkouterror").show();
				$("#checkouterrormessage").html("You already have active plan. You cant subscribe until your current plan over.");
			}else if(res == "notactiveplan"){
				//window.location = "paymentresponse?product="+plan_token;
			}/* else if(message == "1"){
				$("html, body").animate({ scrollTop: 0 }, 1000);
				$("#checkouterror").show();
				$("#checkouterrormessage").html("Your plan has been activated successfully .");
			} */else if(status == "success"){
				window.location = "paymentresponse?product="+plan_token+"&transactionid="+transactionid;
			}else{
				$("html, body").animate({ scrollTop: 0 }, 2000);
				$("#checkouterror").show();
				$("#checkouterrormessage").html(status);
			} 
			  
		}
	});
}


</script>
