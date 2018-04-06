<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
 <jsp:include page="plan_header.jsp" />
 
<% 

String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>



<div class="container-fluid" style="background: #eeeeee;">
  <div class="row"> 
    <div class="col-md-6 col-sm-12 " style="background: #fff"> 
      <!-- /.breadcrumb -->
      <ul class="breadcrumb">
        <li><a href="#">Home</a></li>
        <li class="">pricing</li>
        <li >DRYSIGN API PLANS</li>
        <li >Contact Us</li>
       <!--  <li class="active">Payment Method</li> -->
      </ul>
      <c:url var="cartUrl" value="cartSubmit"/>

		<form:form name="cart" action="${cartUrl}" method="POST" class="login-form" role="form" id="register">
		<div class="info-payment" style="padding: 20px 50px;">
		<%-- <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/> --%>
		<c:if test="${not empty msg}" >
  						<c:choose>
						    <c:when test="${msg=='1'}">
							<div class="alert alert-success fade in">
						    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
    							Thank you for your query with DrySign. <br/><br/>We will contact you soon...   
							</div> 						       
						    </c:when>    
						    <c:otherwise>
							<div class="alert alert-danger fade in">
						    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
    							${msg }
    						</div>
						    </c:otherwise>
						</c:choose>
              		</c:if>
		<!-- <h2 class="font-24">ACCOUNT AND PAYMENT</h2> -->
			
			<div class="row">
				<div class="col-md-12">
					<h3>Contact us <span> </span></h3>
					<!-- <h3>Create Your Account <span> or  use an existing account</span></h3> -->
				</div>
				<div class="col-md-12 no-gutter">
					<div class="row ">
						<div class="col-md-6 col-sm-6 col-xs-12">
						<div class="input-field">
 
     						  <form:input path="firstName" value="${firstName}" placeholder="" class="validate"/>
    						  <form:errors path="firstName" class="sperrors"  />
							<label for="last_name">First Name<span class="redstar">*</span></label>
							</div>
							
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="input-field">
							<form:input path="lastName" value="${lastName}" placeholder="" class="validate"/>
    						<form:errors path="lastName" class="sperrors"  />
						
          <label for="last_name">Last Name<span class="redstar">*</span></label>
							</div>
						</div>
					</div>
					
				</div>
				<div class="col-md-12">
					
						<div class="input-field">

     
     						<form:input path="email" value="${email}" placeholder="" class="validate"/>
    						<form:errors path="email" class="sperrors"  />
     						
							<label for="">Email address<span class="redstar">*</span></label>
							</div>
							
				</div>
				
				<div class="col-md-12">
					
						<div class="input-field">
     				
     					<form:input path="company" value="${company}" placeholder="" class="validate"/>
    						<form:errors path="company" class="sperrors"  />
							<label for="">Company</label>
							</div>
							
				</div>
				
				<div class="col-md-12">
				<div class="input-field ">
   <!--  <select>
      <option value="" disabled selected>Choose your option</option>
      <option value="1">Option 1</option>
      <option value="2">Option 2</option>
      <option value="3">Option 3</option>
    </select>
    <label>Industry</label> -->
    <label for="">Message</label>
    <form:textarea path="message" style="border: none;border-bottom: 1px solid #9e9e9e;" rows="20" cols="20" />
    <form:errors path="message" class="sperrors"  />
  	</div>
	</div>
	<div class="col-md-12">
			 <button type="submit" class="btn btn-primary" style="min-width: 100%; margin-bottom: 10px;">Submit</button>
	 </div>		
	</div>
		</div>
     </form:form> 
      <hr/>
      <!-- <div class="info-payment" style="padding: 20px 50px;">
			
			<div class="row">
				<div class="col-md-12">
					<h3>Payment Information</h3>
				</div>
				<div class="col-md-12">
					Your purchase is secured using 256-bit encryption
				</div>
				
				<div class="col-md-12">
					
						<div class="input-field">
     <input id="" type="text" class="validate">
							<label for="">Name On card</label>
							</div>
							
				</div>
								
				
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 col-sm-6">
							
							<div class="input-field">
     <input id="" type="text" class="validate">
							<label for="">card name</label>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="row">
								<div class="col-md-6 col-xs-6">
									<div class="input-field ">
    <select>
      <option value="" disabled selected>Monts</option>
      <option value="1">Option 1</option>
      <option value="2">Option 2</option>
      <option value="3">Option 3</option>
    </select>
    <label>Expiration Date</label>
  </div>
									
								</div>
								<div class="col-md-6 col-xs-6">
									
									<div class="input-field ">
    <select>
      <option value="" disabled selected>Year</option>
      <option value="1">Option 1</option>
      <option value="2">Option 2</option>
      <option value="3">Option 3</option>
    </select>
    <label></label>
  </div>
								</div>
								
							</div>
						</div>
						
					</div>
				
				</div>
				
			</div>
		</div> -->
     
     <hr/>
     
     <!-- <div class="info-payment" style="padding: 20px 50px;">
			
			<div class="row">
				<div class="col-md-12">
					<h3>Billing Address</h3>
				</div>
				
					<div class="col-md-12">
				<div class="input-field ">
    <select>
      <option value="" disabled selected>Choose your option</option>
      <option value="1">Option 1</option>
      <option value="2">Option 2</option>
      <option value="3">Option 3</option>
    </select>
    <label>Country</label>
  </div>
				</div>
				
				<div class="col-md-12">
					
						<div class="input-field">
     <input id="" type="text" class="validate">
							<label for="">Steet Address</label>
							</div>
							
				</div>
				<div class="col-md-12 no-gutter">
					<div class="row ">
						<div class="col-md-6 col-sm-6 col-xs-12">
						<div class="input-field">
     <input id="" type="text" class="validate">
							<label for="last_name">Zip Code</label>
							</div>
							
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="input-field">
							 <input id="" type="text" class="validate">
          <label for="">City</label>
							</div>
						</div>
					</div>
					
				</div>
				
				
				
				<div class="col-md-12">
				<div class="input-field ">
    <select>
      <option value="" disabled selected>Choose your option</option>
      <option value="1">Option 1</option>
      <option value="2">Option 2</option>
      <option value="3">Option 3</option>
    </select>
    <label>State</label>
  </div>
				</div>
				
			</div>
		 <div class="row">
			 <div class="col-md-12">
				 <button type="submit" class="btn btn-primary" style="min-width: 100%; margin-bottom: 10px;">PURCHASE PLAN</button>
				 <p>By clicking the "UPGRADE PLAN" button above, you agree to the <a href="#">Terms & Conditions, Privacy Policy</a> and automatically recurring billing subscription with DrySign.</p>
			 </div>
		 	
		 </div>
		</div> -->
      
    </div>
    <!-- <div class="col-md-6 col-sm-12" > 
		<div class="wh-module order-summery">
			<div class="row">
				<div class="col-md-12">
					<div class="heading">Order Summary</div>					
				</div>
				
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6 text-info">
							DrySign API Gold Plan <br/>1 user<br/>Billed Annually
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 text-right">400$</div>
					</div>
										
				</div>
				<div style="border-bottom: 1px solid #00bc9c; clear: both; margin: 2px 0"></div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6 text-info">
							Sub Total
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 text-right">400$</div>
					</div>
									<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6 text-info">
							Promo code
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 text-info text-right" >Add Code</div>
					</div>
										
				</div>
				<div style="border-bottom: 1px solid #00bc9c; clear: both; margin: 2px 0"></div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-6 font-24">
							Sub Total
						</div>
						<div class="col-md-6 col-sm-6 col-xs-6 font-24 text-right">400$</div>
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
    </div> -->
  </div>
</div>

<jsp:include page="plan_footer.jsp" />


  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.js"></script>
  
  <script>




$(function() {
	
    // Setup form validation on the #register-form element
    $("#contactus").validate({
   
        // Specify the validation rules
        rules: {
        	first_Name: "required",
        	last_name: "required",
        	contact_email: {
                required: true,
                email: true
            },
            contact_company: "required",
            contact_message: {
                required: true,
                minlength: 5
            }
        },
        
        // Specify the validation error messages
        messages: {
        	first_Name: "Please enter your first name",
        	last_name: "Please enter your last name",
            
        	contact_email: "Please enter your contact email.",
        	contact_company: "Please enter your company name.",
        	contact_message: "Please enter message.",
        },
        
        submitHandler: function(form) {
            form.submit();
        }
    });

  });
</script>
  