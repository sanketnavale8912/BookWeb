<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
 <jsp:include page="header.jsp"></jsp:include>
 <script src="<%=appUrl %>/js/jquery.min.js"></script> 
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
		<li class="active">Settings</li>		
	</ol>		
	</div>
	<!-- Main content -->
	<div class="container-fluid">
		<div class="row margB20">
			<div class="col-xs-12">
				<div class="alert alert-success alert-dismissible" role="alert"
					id="alert" style="display: none;">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<strong>Success!</strong> Form has been saved successfully.
				</div>
				<div class="alert alert-danger" role="alert" id="projalert" style="display: none;">Please enter Project Name</div>
				<div class="alert alert-danger" role="alert" id="themealert" style="display: none;">Please enter Theme</div>
				<div class="Content-wh-module" style="margin: 0 auto; width: 400px; max-width: 100%">
					<form id="setting-form" action="savesettings" method="get">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-field">
							<label for="">Project Name</label>
								<input id="project" name="project" type="text" class="validate" value="${projectname}">
								
								<!--  <i class="icon-eye pull-right eye_set" aria-hidden="true"></i> -->
								
							</div>							
						</div>
						<div class="col-xs-12">
							<div class="input-field">
							<label for="">Theme</label>
							
								<input id="theme"  name="theme" type="text" class="validate" value="${theme}">
								
								<!--  <i class="icon-eye pull-right eye_set" aria-hidden="true"></i> -->
								
							</div>							
						</div>
						<div class="col-xs-12">
							<div class="input-field">
							<label for="">Logo</label>
								<input id="logo" name="logo" type="text" class="validate">
								
								 <!-- <i class="icon-eye pull-right eye_set" aria-hidden="true"></i> -->
								
							</div>		
												
						</div>
						<div class="col-xs-12 text-center">
							<!-- <a href="#" style="text-transform: uppercase" onclick="	check(); ">Save</a> -->
							<input type="submit">save
						</div>
					</div>
					</form>
					 <input type="hidden" id="status" value='${status}'/>

				</div>
			</div>
		</div>
	</div>
 </div>
 <jsp:include page="footer.jsp"></jsp:include>
<script src="<%=appUrl%>/js/materialize.js"></script>

<script type="text/javascript" src="<%=appUrl%>/js/jquery.validate.js"></script>
<!-- Loader -->
<script>
//alert('${msg}');
$("#setting-form").validate({
	//specify the validation rules
	rules: {
		project: {
			required: true,
			//email: true //email is required AND must be in the form of a valid email address
		},
		theme: {
			required: true
		}
	},
	//specify validation error messages
	messages: {
		project: "First Name field cannot be blank",
		theme: "Last Name field cannot be blank",
		password: {
			required: "Please enter a password",
			minlength: "Your password must be at least 8 characters long"
		},
		username:{
			required:"Please enter a valid email address",
			email:"Please enter a valid email address"
		} 
	},
	submitHandler: function(form){
	form.submit();
	}
	 
});
	$(document).ready(function() {
		var status='${status}';
	
		if (status == "success") {
			document.getElementById('alert').style.display = 'block';
		}

	});
	
    function check()
    {
        if (document.getElementById('project').value=="" || document.getElementById('project').value==undefined)
        {
        	document.getElementById('projalert').style.display = 'block';
           
        }
        else if(document.getElementById('theme').value=="" || document.getElementById('theme').value==undefined)
        	{
        	document.getElementById('themealert').style.display = 'block';
        	
        	}
        else{
        	document.getElementById('setting-form').submit();
        }
    }
</script>

