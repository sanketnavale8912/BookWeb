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
  <style>
 form .error {
 			
	 		color: #ff0000;
	 	  }
 </style>
  <div class="content-wrapper bg_wrap">
	 <div class="container-fluid">
	<!-- breadcrumb -->
	<ol class="breadcrumb">		
		<li>Home</li>
		<li class="active">Password</li>		
	</ol>		
	</div>
	<!-- Main content -->
	<div class="container-fluid">
		<div class="row margB20">
			<div class="col-xs-12">
				<div class="Content-wh-module" style="margin: 0 auto; width: 400px; max-width: 100%">
					<form id="password-form">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-field">
							<label for="">Old Password</label>
								<input id="password-field" type="password" class="validate" value="${password}" readonly>
								 <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password">
								<!--  <i class="icon-eye pull-right eye_set" aria-hidden="true"></i> -->
								
							</div>							
						</div>
						<div class="col-xs-12">
							<div class="input-field">
							<label for="">New Password</label>
								<input id="password"  name="password" type="password" class="validate">
								<span toggle="#password" class="fa fa-fw fa-eye field-icon toggle-password1">
								<!--  <i class="icon-eye pull-right eye_set" aria-hidden="true"></i> -->
								
							</div>							
						</div>
						<div class="col-xs-12">
							<div class="input-field">
							<label for="">Confirm New Password</label>
								<input id="confirmpassword" name="confirmpassword" type="password" class="validate">
								 <span toggle="#confirmpassword" class="fa fa-fw fa-eye field-icon toggle-password2">
								 <!-- <i class="icon-eye pull-right eye_set" aria-hidden="true"></i> -->
								
							</div>		
												
						</div>
						<div class="col-xs-12 text-center">
							<a href="#" onclick="changePassword();" style="text-transform: uppercase">Change Password</a>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
 </div>
 <jsp:include page="footer.jsp"></jsp:include>
 <script src="<%=appUrl %>/js/materialize.js"></script>
 <script>
 var passwordForm=$("#password-form").validate({
		//specify the validation rules
		rules: {
			password: {
				required: true,
				minlength: 8
			},
			confirmpassword : {
				required: true,
				minlength : 8,
				equalTo : "#password"
			}
		},
		//specify validation error messages
		messages: {
			password: {
				required: "Password field cannot be blank",
				minlength: "Your password must be at least 8 characters long"
			},
			confirmpassword:{
				required: "Confirm Password field cannot be blank",
				minlength: "Your password must be at least 8 characters long",
				equalTo:"Please enter the same Password as above",
				
			}
		}
});
 
 function changePassword(){
	  var token = $("meta[name='_csrf']").attr("content");
	  var header = $("meta[name='_csrf_header']").attr("content");
	  var contextPath=$("#contextPath").val();
	  var valid = $("#password-form").valid();
	  if(valid == true){
			var data = {
					  "password" :$("#password").val(),
		    	      "confirmpassword" :$("#confirmpassword").val()	    	     
		    }
			$.ajax({
				contentType : 'application/json; charset=utf-8',
				type : "POST",
				url : contextPath+"app/updatePasword",
				dataType : 'json',
				crossDomain: true,
				data : JSON.stringify(data),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				complete : function() {
				},
				success : function(response) {
					if(response =="success"){
						alert('Success');
						
					}else{
						//alert('Error');
						
					}
				},
				error: function(xhr, textStatus, errorThrown)
				 {
				 	alert('ajax loading error... ... ');
				 	return false;
				}
			});		
		}
	 
 }
 
 $(".toggle-password").click(function() {

	 $(this).toggleClass("fa-eye fa-eye-slash");
	 var input = $($(this).attr("toggle"));
	 if (input.attr("type") == "password") {
	 input.attr("type", "text");
	 } else {
	 input.attr("type", "password");
	 }
	 });

	 $(".toggle-password1").click(function() {

	 	$(this).toggleClass("fa-eye fa-eye-slash");
	 	var input = $($(this).attr("toggle"));
	 	if (input.attr("type") == "password") {
	 	input.attr("type", "text");
	 	} else {
	 	input.attr("type", "password");
	 	}
	 	});
	 	
	 $(".toggle-password2").click(function() {

	 	$(this).toggleClass("fa-eye fa-eye-slash");
	 	var input = $($(this).attr("toggle"));
	 	if (input.attr("type") == "password") {
	 	input.attr("type", "text");
	 	} else {
	 	input.attr("type", "password");
	 	}
	 	});
 </script>
