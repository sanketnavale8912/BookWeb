<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="com.drysign.model.Registration,org.springframework.security.core.context.SecurityContextHolder,org.springframework.security.core.Authentication" %>
<% Authentication auth = SecurityContextHolder.getContext().getAuthentication(); %>
<% Registration registration = (Registration)auth.getPrincipal(); %>
<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" href="<%=appUrl %>/css/style.css"/>
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css"/>
 <link href="<%=appUrl %>/css/materialize.css" rel="stylesheet"/>
 <link class="jsbin" href="<%=appUrl %>/css/jquery-ui.css" rel="stylesheet" type="text/css" />
<%-- <script class="jsbin" src="<%=appUrl %>/js/jquery.min.js"></script> --%>
<script class="jsbin" src="<%=appUrl %>/js/jquery-ui.min.js"></script>
<script src="<%=appUrl %>/js/bootstrap.js"></script> 
<meta charset=utf-8 />
<style>
.error {
	color: #ff0000;
} 
</style> 

 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper bg_wrap">
    <div class="container-fluid">
	<!-- breadcrumb -->
	<ol class="breadcrumb">
	<li>Home</li>		
		<li class="active">Profile</li>		
	</ol>		
	</div>
   <!-- /.content-wrapper --> 
 	<div class="container-fluid">
		<div class="Content-wh-module">
			<div class="row">
				<div class="col-md-4 col-sm-4 border-right profilepic-container">
					<div class="user-info ">
					<div class="col-md-12 col-sm-12 " style="padding:0px;"> 
						<div class="user-info-photo">
								<img style="height:150px; width:100%;" src="${mypic}" id="img" class="img-responsive"/>
						</div>
					</div>
					<div class="col-md-12 col-sm-12 " style="padding:0px;"> 
						<div class="user-info-avtar">
								PROFILE PICTURE
								<!-- <input type='file' class="btn btn-primary update_info" name='fileName' id="inp" />
								<button type="button" class="btn btn-primary update_info" value="update">Delete</button>  -->
								
								<div class="file-field input-field" style="margin: 0;    text-align: center;">
					      
					        <button type="button"  class="btn btn-primary update_info" style="float:none;height:30px;line-height: 30px;">Upload Photo</button>
					       <input type='file' accept="image/*" class="btn btn-primary update_info" name='fileName' id="inp" />
					
					     
					    </div>
					  </div>	
  					</div>	
								
						</div>
					</div>
<div class="alert alert-danger" id="picerror" style="display:none">
     Only Image files allowed.
				</div>
		
			<div class="col-md-8 col-sm-8">
				<div class="row Profile-info">
					<form id="profile-form">
						<div class="col-md-6 sm-6">
							<div class="head3_1">Basic Information</div>							
							<div class="inputfield">
    							<label for="last_name" >First Name <span class="redstar1">*</span></label>
     							<input id="firstname" name="firstName" class="disabledCheckboxes" type="text" value="<%=registration.getFirstName()%>" disabled />								
							</div>
							
							<div class="inputfield">
    							<label for="last_name">Last Name <span class="redstar1">*</span></label>
     							<input id="lastname" name="lastname"  class="disabledCheckboxes" type="text" value="<%=registration.getLastname()%>" disabled >								
							</div>
							
							<div class="inputfield">
    							<label for="last_name" >Email Address <span class="redstar1">*</span></label>
     							<input id="email" name="email" class="disabledCheckboxes" type="text" value="" disabled  readonly>								
							</div>
							
							
							<div class="head3_1" style="margin-top: 31px;">Contact Details</div>							
							<!-- <div class="inputfield">
    							<label for="first_name" >Mobile Number </label>
     							<input id="mobile" name="mobile" class="disabledCheckboxes" align="" type="text" value="" disabled />								
							</div> -->
							
													
							<div class="inputfield">
    							<label for="last_name" >Phone Number</label>
     							<input id="phone" name="phone"  class="disabledCheckboxes" type="text" value="" disabled  >								
							</div>							
						</div>
				
						<div class="col-md-6 sm-6">
							<div class="head3_1">Address Details </div>							
							<div class="inputfield">
    							<label > Country </label>
    							
    							<input id="country" name="country" class="disabledCheckboxes" type="text" value="" disabled  >
    							<!-- <select onchange="print_state('state',this.selectedIndex);" id="country" class="" >
    							
								 <option value="" disabled selected>Select Country</option>
								</select> -->						
							</div>
							
							<div class="inputfield">
    							<label for="State" class="disabledCheckboxes" >State</label>
    							<!-- <input id="state" name="state" class="disabledCheckboxes" align="" type="text" value="" disabled /> -->
     							<!--  <select name ="state" id ="state" class="disabledCheckboxes">
     							 <option value="" disabled selected>Select State</option>
     							 </select> -->
     							 <input id="state" name="state" class="disabledCheckboxes" type="text" value="" disabled  >
							</div>
							
							<div class="inputfield">
    							<label for="last_name" class="disabledCheckboxes">City</label>
     							<input id="city" name="city" class="disabledCheckboxes" type="text" value="" disabled  >								
							</div>
							<div class="inputfield">
    							<label for="last_name" >Street Address</label>
     							<input id="address" name="address"  class="disabledCheckboxes" type="text" value="" disabled  >								
							</div>
							<div class="inputfield">
    							<label for="last_name" >ZIP Code</label>
     							<input id="pincode" name="pincode"  class="disabledCheckboxes" type="text" value="" disabled />								
							</div>							
						</div>
						<div class="col-md-12 sm-12 text-right">
						
							<a href="#" id="editprofile" class="btn btn-blue blue-text-link">Edit</a>
							
							<a href="#" id="cancelprofile" class="edit_ST btn btn-cancel">cancel</a>
							
							<a href="#" id="saveprofile" onclick="saveProfile();" class="edit_ST  btn btn-green">Save</a>
							
							<!-- <button type="button" class="edit_button " value="edit_button">Edit</button>-->
						</div>
					</form>
				</div>
			</div>
		</div>
		</div>
	</div>
</div>
 <jsp:include page="footer.jsp"></jsp:include>
  <!-- Validation -->
 
 
<script src="<%=appUrl %>/js/materialize.js"></script>
<script type= "text/javascript" src = "<%=appUrl %>/js/countries.js"></script>
<script type= "text/javascript" src = "<%=appUrl %>/js/Base64.js"></script>  

<script>

$(document).ready (function(){
	
	 $(".Content-wh-module").css({ minHeight: $(window).innerHeight() - '150' });
	  $(window).resize(function() {
	    $(".Content-wh-module").css({ minHeight: $(window).innerHeight() - '150' });
	  });
	  
	  $(".profilepic-container").css({ minHeight: $(window).innerHeight() - '150' });
	  $(window).resize(function() {
	    $(".profilepic-container").css({ minHeight: $(window).innerHeight() - '150' });
	  });
		
	   
	


//print_country("country");
Materialize.updateTextFields();    

	$('select').material_select();
	$('#country').prop('disabled', true);
	$('#cancelprofile').hide();
	$('#saveprofile').hide();
	$('#editprofile').click (function(){
		$('#editprofile').hide();
		$('#saveprofile').show();
		$('#cancelprofile').show();
		$('.disabledCheckboxes').prop("disabled", false);
		
		//$('.select-dropdown').prop("disabled", false);	
	})

});
	
$('.disabledCheckboxes').prop("disabled", true);
$('.select-dropdown').prop("disabled", true);

$('#cancelprofile').click(function(){
	//profileForm.resetForm();
	//getProfile();
	profileForm.resetForm();
	$('#profile-form')[0].reset();
	getProfile();
	$('#editprofile').show();
	$('#saveprofile').hide();
	$('#cancelprofile').hide();
	$('.disabledCheckboxes').prop("disabled", true);
	$('.select-dropdown').prop("disabled", true);
});

document.getElementById("inp").addEventListener("change", readFile);

function readFile() {
	  
	  if (this.files && this.files[0]) {
		  var file = this.files[0];
			var fileType = file["type"];
			var ValidImageTypes = ["image/gif", "image/jpeg", "image/png"];
			if ($.inArray(fileType, ValidImageTypes) > 0) {
			  
	    
	    var FR= new FileReader();
	    
	    FR.addEventListener("load", function(e) {
	      document.getElementById("img").src       = e.target.result;
	      var dataURL=e.target.result;
	      var contextPath=$("#contextPath").val();
	      var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  var data = {
		   			 "dataURL" : dataURL
		   		}
		        $.ajax({
		        	type: 'POST',
		        	url: contextPath+'app/picupload',
		            dataType: 'json',
		    	    contentType: "application/json; charset=utf-8",
		    	    data: JSON.stringify(data),
		            beforeSend : function(xhr) {
		    			xhr.setRequestHeader(header, token);
		    		},
		            success: function(data){
		            	var x = document.getElementById('picerror');
						 x.style.display = 'none';
		              //  alert(data);
		           //   window.location.href=contextPath+"app/getpic" 
		              
		            },
		            error: function(err){
		                alert(err);
		            }
		   });
		  
	     // document.getElementById("b64").innerHTML = e.target.result;
	    }); 
	    
	    FR.readAsDataURL( this.files[0] );
	  }
			else{
				 var x = document.getElementById('picerror');
				 x.style.display = 'block';
			}
	  }
	  
	}

/* function readURL(input) {
    var files,dataURL;
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#blah')
                .attr('src', e.target.result)
                .width(150)
                .height(200);
          dataURL =e.target.result;
            
        };
        var contextPath=$("#contextPath").val();
        
        files=input.files[0];
        reader.readAsDataURL(input.files[0]);
        
        var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
        var formData = new FormData($('form')[0]);    
        
        var data = {
   			 "dataURL" : dataURL
   		}
        $.ajax({
        	type: 'POST',
        	url: contextPath+'app/picupload',
            dataType: 'json',
    	    contentType: "application/json; charset=utf-8",
    	    data: JSON.stringify(data),
            beforeSend : function(xhr) {
    			xhr.setRequestHeader(header, token);
    		},
            success: function(data){
                alert(data);
            },
            error: function(err){
                alert(err);
            }
        });
    }
 
} */

function getpic(){
	
	 $.ajax({
     	type: 'POST',
     	url: contextPath+'app/getpic',
         dataType: 'json',
 	    contentType: "application/json; charset=utf-8",
 	    data: JSON.stringify(data),
         beforeSend : function(xhr) {
 			xhr.setRequestHeader(header, token);
 		},
         success: function(data){
           //  alert(data);
           getpic();
         },
         error: function(err){
             alert(err);
         }
});
	
}


</script>

<script src="<%=appUrl %>/js/jquery.validate.js"></script>
 <script>
	$( document ).ready(function() {
		getProfile();
	});
	
	function getProfile(){
		var contextPath=$("#contextPath").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type : "GET",
			url : contextPath+"app/getProfile",
			beforeSend : function(xhr) {
				//$('#signupbtn').buttonLoader('start');
				xhr.setRequestHeader(header, token);
			},
			complete : function() {
				//$("#signupbtn").buttonLoader('stop');
			},
			success : function(response) {
				//alert(response.email);
				if(response !=null && response != 'undefined'){
					//$("#firstName").val(response.firstName);
					//$("#profileName").html(response.firstName+' '+response.lastname);
					//$("#lastname").val(response.lastname);
					$("#email").val(response.email);
					//$('#country option:selected').val("sanket")
					//$("#country select").val("val2");
					$("#country").val(response.country);
					$("#state").val(response.state);
					$("#pincode").val(response.pincode);
					$("#city").val(response.city);
					$("#address").val(response.address);
					$("#mobile").val(response.mobile);
					$("#phone").val(response.phone);
				}
			},
			error: function(xhr, textStatus, errorThrown)
			 {
			 	alert('ajax loading error... ... ');
			 	return false;
			}
		})	
	}
	
	 $.validator.addMethod('mobilephone', function (value, element) {
	        return this.optional(element) || /^(\+91-|\+91|0)?\d{10}$/.test(value);
	    }, "Please enter a valid mobile number");

	
	 $.validator.addMethod('customphone', function (value, element) {
	        return this.optional(element) || /^(\+91-|\+91|0)?\d{10}$/.test(value);
	    }, "Please enter a valid phone number");

	 jQuery.validator.addMethod("zipcode", function(value, element) {
		  return this.optional(element) || /^\d{5}(?:-\d{4})?$/.test(value);
		}, "Please provide a valid zipcode.");
	
	var profileForm=$("#profile-form").validate({
		//specify the validation rules
		rules: {
			firstName:"required",
			lastname:"required",
			email: {
				required: true,
				email: true //email is required AND must be in the form of a valid email address
			},
			phone:"customphone",
			mobile:"mobilephone",
			pincode:{
				 number: 1
			}
		},
		//specify validation error messages
		messages: {
			firstName: "First Name field cannot be blank",
			lastname: "Last Name field cannot be blank",
			email: "Please enter a valid email address",
			mobile:"Please enter 10 digit mobile number"
		},
		highlight: function(element) {
            $(element).closest('.inputfield').addClass('has-error');
        },
		unhighlight: function(element){
            $(element).closest('.inputfield').removeClass('has-error');
        },
 });
	
	
	function saveProfile(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		var valid = $("#profile-form").valid();
		if(valid == true){
		var data = {
	    	      "firstName" : $("#firstname").val(),
	    	     "lastname" :$("#lastname").val(),
	    	      "mobile" :$("#mobile").val(),
	    	      "phone" :$("#phone").val(),
	    	      "country" :$("#country").val(),
	    	      "state" :$("#state").val(),
	    	      "city" :$("#city").val(),
	    	      "address" :$("#address").val(),
	    	      "pincode" :$("#pincode").val() 
	    	      
	    }
		//alert(contextPath);
			$.ajax({
				contentType : 'application/json; charset=utf-8',
				type : "POST",
				url : contextPath+"app/saveProfile",
				dataType : 'json',
				data : JSON.stringify(data),
				beforeSend : function(xhr) {
					//$('#signupbtn').buttonLoader('start');
					xhr.setRequestHeader(header, token);
				},
				complete : function() {
					//$("#signupbtn").buttonLoader('stop');
				},
				success : function(response) {
					
					if(response=='success'){
						getProfile();
						var fn= $("#firstname").val()+" ";
						var ln= $("#lastname").val() ;
						document.getElementById("profileName").innerHTML= fn + ln ;
						$('#editprofile').show();
						$('#saveprofile').hide();
						$('#cancelprofile').hide();
						$('.disabledCheckboxes').prop("disabled", true);
						$('.select-dropdown').prop("disabled", true);
					}else{
						alert('failed')
					}
				},
				error: function(xhr, textStatus, errorThrown)
				 {
				 	alert('ajax loading error... ... ');
				 	return false;
				}
			})	
		}else{
			
		}
	}
	</script> 
</head>
</html>