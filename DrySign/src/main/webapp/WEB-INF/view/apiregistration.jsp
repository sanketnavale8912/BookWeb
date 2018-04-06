
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

.paddT50 {
   height: 450px;
}
.error {
    color: red;
}

    </style>
<div class="container-fluid pricing_website" style="margin-bottom:68px;">
         <!-- /.breadcrumb -->
         <!--         <ul class="breadcrumb">
            <li><a href="../index.html">Home</a></li>
            <li class="active">pricing</li>
            </ul> -->
            <form id ="apiregister">
         <div class="row">
         <div class="bg-RGpge">
             <div class="RG-topimg">

            </div>
            </div>

            <div class="RG-form-info">
            <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <h2 class="pull-right text-center">GET THINGS <br />DONE QUICKLY!</h2>
               </div>
               </div>
               <div class="row" id="show_message_form" style="display:none">
                  <div class="col-md-3"> </div>
                 <div class="col-md-6"> 
                   <div class="message text-center" id="register-success" style="display:none">
					   <p><img src="<%=appUrl %>/images/message-bg.png"/></p>
					   <h4>YOUR ACCOUNT HAS BEEN CREATED!</h4>
					  <!--  <p>Congratulations! Your new account has been successfully created.</p> -->
					   <p>You will soon receive an email.</p>
					      <a href="login" class="btn backbutton btn-link ">CONTINUE TO DRYSIGN</a>                   
				   </div>
				   
				<div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="regsiterModelalert">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="registerdmessage"></div>
				</div>
				</div>
				<div class="col-md-3"> </div>
				
				</div> 
               <div class="row paddT100" id="show_key_form">
                  <div class="col-md-6">
                       <div class="form-group">
                         <label for="nme"></label>
                         <input type="text" class="form-control" id="fname" name="fname"  placeholder="First Name">
                       </div>
                  </div>
                  <div class="col-md-6">
                     <div class="form-group">
                         <label for="Lnme"></label>
                         <input type="text" class="form-control" id="lname" name="lname" placeholder="Last Name">
                       </div>
                  </div>
                  <div class="col-md-6">
                       <div class="form-group">
                         <label for="email"></label>
                         <input type="email" class="form-control" id="email" name="email" placeholder="Email Address">
                       </div>
                  </div>
                  <div class="col-md-6">
                     <div class="form-group">
                         <label for="Tno"></label>
                         <input type="number" class="form-control" id="phone" name="phone" placeholder="Phone">
                       </div>
                  </div>
                  <div class="col-md-6">
                     <div class="form-group">
                            <!--    <span class="caret"></span> -->
                                  <select name="country" id="country" class="form-control"  placeholder="Country">
                                  </select>
                              </div>
                  </div>
                  <div class="col-md-6">
                     <div class="form-group">
                               <!-- <span class="caret"></span> -->
                                  <select name="state" id="state" class="form-control" placeholder="State">
                                  </select>
                              </div>
                  </div>
                  <div class="col-md-6">
                     <div class="form-group">
                         <label for="Lnme"></label>
                         <input type="text" class="form-control" id="company" name="company"  placeholder="Company Name">
                       </div>
                  </div>
                  <div class="col-md-6">
                     <div class="form-group">
                         <label for="Lnme"></label>
                         <input type="text" class="form-control" id="project" name="project" placeholder="Project name">
                       </div>
                  </div>
                  <div class="col-md-6">
                     
                      
                           <div class="checkbox checkbox-primary">
                              <input type="checkbox" class="mycheckbox" id="checkbox2">
                              <label for="checkbox2">  Do not want email alerts from DrySign.</label>
                           </div>
                     
                       <!--   <input type="checkbox"  id="project"  > -->
                       
                  </div>
 				<div class="col-xs-12 text-center">
                        <button type="button" id="loader_key" onclick="register();" class="btn has-spinner RG-btn btn-lg">GET AN API KEY</button>
                     </div>

               </div>
               </div>
                   
              

										  
            </div>
               

         </div>

</form>

      </div>
<script src="<%=appUrl %>/js/jquery.validate.js"></script>
<script src="<%=appUrl %>/js/countries.js"></script>
<script type="text/javascript">

$('#state').append('<option value="" selected="selected">Select State</option>');
populateCountries("country", "state");

  	var apiregisterform = $("#apiregister").validate({
		//specify the validation rules
		rules : {
			email : {
				required : true,
				email : true
			//email is required AND must be in the form of a valid email address
			},
			fname : {
				required : true
			},
			lname : {
				required : true
			},
			project : {
				required : true,
				
			},
			country: {
				required : true
			},
			state : {
				required : true,
				
			},
			phone : {
				required : true,
				
			},
			company : {
				required : true,
			}
			

		},
		//specify validation error messages
		messages : {
			email : {
				required : "Please enter a valid email address",
				email : "Please enter a valid email address"
			},
			fname : {
				required : "Please enter First Name",

			},
			lname : {
				required : "Please enter Last Name",

			},
			project : {
				required : "Please enter Project Name",
				
            },
			country: {
				required : "Please select Country"
			},
			state : {
				required : "Please select State",
				

			},
			phone : {
				required : "Please enter Phone",
				

			},
			company : {
				required : "Please enter Company Name",
				

			}
		}
	});
  	
  	
  	
	function register(){
		
		var isEmailAlert= $('#checkbox2').is(":checked");
		if(isEmailAlert){
			isEmailAlert = 0;
		}else{
			isEmailAlert = 1;
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		var valid = $("#apiregister").valid();
		var btn=$("#loader_key");
		if(valid == true){
			 var contextPath=$("#contextPath").val();
			    var data = {
		    	      "firstName" : $("#fname").val(),
		    	      "lastname" :$("#lname").val(),
		    	      "email" :$("#email").val(),
		    	      "phone" :$("#phone").val(),
		    	      "country" :$("#country").val(),
		    	      "state" :$("#state").val(),
		    	      "companyName" :$("#company").val(),
		    	      "project" :$("#project").val(),
		    	      "isEmailAlert":isEmailAlert
		    	      		    	     
		    	   }
	        $.ajax({
	            contentType : 'application/json; charset=utf-8',
	            type:'POST',
	            url: "formregisterkey",
	            crossDomain: true,
	            dataType : 'json',
	            data : JSON.stringify(data),
	            beforeSend : function(xhr) {
	            	$(btn).buttonLoader('start');
					xhr.setRequestHeader(header, token);
			        
				},
			    complete : function() {
			    	$(btn).buttonLoader('stop');
				},
	            success : function(callback){
	            	//alert("Response :"+callback.msg);
// 	            	$("#errorMsg").val('');
// 	            	$("#successMsg").val('');
// 	            	$("#success-alert").addClass('hidden');
// 	            	$("#error-alert").addClass('hidden');
	                if(callback.msg== '1' || callback.msg== 1){
						$("#show_message_form").show();
						$("#show_key_form").hide();
	                	$("#registerdmessage").val('');
						$("#regsiterModelalert").hide();
						$(".get_info").hide();
						$("#register-success").show();
	                	//$("#successMsg").html('You have successfully registered.Please verify your account by email.');
	                }else{
	                	$("#show_message_form").show();
	                	$("#regsiterModelalert").show();
						$("#registerdmessage").html(callback.msg);
// 	                	if(callback.msg =="This Email is Already exists."){
// 	                		 $("#emailfailalert").show();
// 	 						$("#emailfail").html(callback.msg);
	                		
// 	                	}else{
	                	document.getElementById("apiregister").reset();
	                	$(".minicolors-swatch-color").css('background-color','rgb(176, 25, 25)');
	                	
	                }
	                
	                
	            },
	            error : function(){
	                $(this).html("Error!");
	            }
	        });
		 }
	 }
      
      </script>

<jsp:include page="plan_footer.jsp" />