<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<% String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>${title}| DrySign</title>

<!-- Bootstrap -->
<link href="<%=appUrl %>/css/bootstrap.css" rel="stylesheet">
<style>
canvas {
	position: relative;
	margin: 1px;
	margin-left: 0px;
	border: 3px solid #2C3D4F;
	border-radius: 3px;
}
.selected {
    box-shadow: 9px 11px 28px -12px #080808;
}

.btn-bs-file{
    position:relative;
}
.btn-bs-file input[type="file"]{
    position: absolute;
    top: -9999999;
    filter: alpha(opacity=0);
    opacity: 0;
    width:0;
    height:0;
    outline: none;
    cursor: inherit;
}


.btn-blue {
    background-color: #0191e9;
    min-width: 89px;
    color: #fff;
    font-weight: bold;
    font-size: 14px !important;
    padding: 5px 10px !important;
    letter-spacing: 1px;
}
</style>
</head>
<body>
<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
<input type="hidden" id="usertoken" value="<%= request.getParameter("token") %>"/>

	<!-- Modal -->
	<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content" id="invalid_link" style="display:none">
				<div class="modal-header" style="background: #00b497;height: 94px;">
					<!--  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
					<!-- Nav tabs -->
					 <div class="text-left"><a href="index"><img src="<%=appUrl %>/images/1.0/logo_inner.png" alt="Logo" class="iMg" title="Logo"/></a><br><br></div>
					</div>
					<div class="modal-body">
					<div class="alert alert-warning" role="alert" id="invalid_message"></div>				
					</div>
				
				
			  <%-- <div class="text-left"><a href="index"><img src="<%=appUrl %>/images/logo_inner.png" alt="Logo" class="iMg" title="Logo"/></a><br><br></div>
					
				 <div class="row">
				 <div class="col-xs-12">
				<div class="alert alert-warning" role="alert" id="invalid_message"></div>
				</div></div> --%>
			</div>
			<div class="modal-content" id="valid_link" style="display:none">
				<div class="modal-header" style="background: #00b497;height: 94px;">
					<!--  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
					<!-- Nav tabs -->
					 <div class="text-left"><a href="index"><img src="<%=appUrl %>/images/1.0/logo_inner.png" alt="Logo" class="iMg" title="Logo"/></a><br><br></div>
					

				</div>
				<div class="modal-body">
				<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#draw"
							aria-controls="draw" role="tab" data-toggle="tab">DRAW</a></li>
						<li role="presentation"><a href="#type" aria-controls="type"
							role="tab" data-toggle="tab">TYPE</a></li>
						<li role="presentation"><a href="#upload" aria-controls="upload"
							role="tab" data-toggle="tab">UPLOAD</a></li>	
						<li role="presentation"><a href="#mysignature"
							aria-controls="mysignature" role="tab" data-toggle="tab">SAVED</a></li>
					</ul>
					<!-- Tab panes -->
					<div class="tab-content" style="padding:15px">
						<div role="tabpanel" class="tab-pane active" id="draw">
						  <div class="row">
							<div class="col-xs-12">
						  		<a class="" onclick="zkSignature.clear()" href="#">Clear</a>
						   	 </div>
						   	 <div class="col-xs-12">
					 		<div id="canvas">Canvas is not supported.</div>
					 		</div>
					 		<div class="col-xs-10 text-left">
									<div class="alert alert-success" id="signature-sucess-draw" style="display:none">
							      
									</div>
									<div class="alert alert-danger" id="drawsignature_error"  style="display:none">
					      				
									</div>
					  		</div>
					 		<div class="col-xs-2 text-right">
					 			<button type="button" class="btn btn-default" style="background: #00BC9C;" onclick="saveSignature('draw')">Save</button>
					 		</div>
					 		
					 	   </div>	
						</div>
						<div role="tabpanel" class="tab-pane" id="type">
							<div class="row">
								  <div class="col-xs-12">
								  Your Name <input type="text" id="typeName" value="${firstName} ${lastName}"/>
								  <br><br>
								  </div>
								  
								<div class="col-xs-12" id="showType">
								</div>
								<div class="col-xs-10 text-left">
									<div class="alert alert-success" id="signature-sucess-type" style="display:none">
							      
									</div>
									<div class="alert alert-danger" id="signature-type-error" style="display:none">
						      
									</div>
								</div>
								<div class="col-xs-2 text-right">
									<button type="button" class="btn btn-default" style="background: #00BC9C;" onclick="saveSignature('type')">Save</button>
								</div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="upload">
							
							<div class="row">
								 <div class="col-md-12 text-right">
					 		  	 <a class="text-red" id="clearId" style="display:none" href="#" onclick="clearUploadSignature();">Clear</a>
								  
					  		</div>  
							</div>
							<div class="row" id="show_upload_signature">
							   <div class="col-md-12 text-center">
							   	
							   	Upload a picture of your signature
							  
							   </div>
							    	<br> 	<br>
								  <div class="col-md-12 text-center">
								  	<div id="upload_signature">
										<form id="form1" >
										   <label class="btn-bs-file btn btn-lg btn-blue">
			                					<i class="fa fa-upload" aria-hidden="true"></i>Upload
			                				<input type='file' id="imgInp" class="demoInputBox"  />
			            					</label>
										   
										 
										</form>
										
									</div>
									
								 </div>
								  <div class="col-md-12 text-center">
								  <br><br>
							   		<p class="text-warning" >Maximum file size: 10 MB</p>
							   		<p class="text-warning">Acceptable file formats: png, jpg, jpeg, bmp</p>
							   	</div>
							</div>
							<div class="row" id="show_upload_error_signature">
					  			<div class="alert alert-danger"  id="file_error" style="display:none"></div>
								 </div>
							<div class="row" id="show_upload_yoursignature" style="display:none"> 		 
							<div class="col-md-12 text-center" style="height:300px">
								 <img id="blah" src="" class="img-thumbnail" width="750px" height="186px"  alt="" />
							</div>
							
							<div class="col-md-12 text-right">
									<button type="button" class="btn btn-default" style="background: #00BC9C;" onclick="saveSignature('upload')">Save</button>
							</div>
							<div class="col-xs-10 text-left">
									<div class="alert alert-success" id="signature-sucess-upload" style="display:none">
							      
									</div>
									<div class="alert alert-danger" id="signature-upload-error" style="display:none">
						      
									</div>
								</div>
						</div>	
						</div>
						
						<div role="tabpanel" class="tab-pane" id="mysignature">
						<div class="row">
						<div class="col-xs-12">
							<c:set var="mysignature" value="${userSignature}"/>
							<c:choose> 
					  			<c:when test="${userSignature == null}">
					  				<div class="alert alert-warning" role="alert">You have not saved your signature</div>
					  			</c:when>
					  			 <c:otherwise>
					  			 <div class="col-md-6 col-sm-6 col-xs-12 thumb">
					  			 
					  			 <img class="img-responsive" style="padding: 10px 10px 10px 10px;border: 1px solid #dee1e4;" id="showSignature"  src="${userSignature}" />
					  			 
					  			 </div>
					  			 </c:otherwise>
					  		</c:choose>	
							</div>
								<div class="col-xs-6 text-left">
									<!-- <button type="button" class="btn btn-primary" onclick="saveSignature('mysignature')">Save</button> -->
								</div>
								<div class="col-xs-6 text-right">
									<!-- <button type="button" class="btn btn-primary" onclick="saveSignature('mysignature')">Save</button> -->
								</div>
						   </div>
						</div>
					</div>
				</div>
				<!-- <div class="modal-footer">
       
      </div> -->
			</div>
		</div>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<%=appUrl %>/js/bootstrap.min.js"></script>
	<script src="<%=appUrl %>/js/signature.js"></script>
	<script src="<%=appUrl %>/js/jquery.browser.js"></script>
	<script>
    zkSignature.capture();
    $(document).ready(function () {
    	var serverResponse='${response}'; 
    	//alert(serverResponse);
    	if(serverResponse == 'error'){
    		$("#invalid_link").show();
    		$("#invalid_message").html('${message}');
    	}else{
    		$("#valid_link").show();
    	}
    		getSigntype();
	    	 $('#myModal').modal({
    		    backdrop: 'static',
    		    keyboard: false  // to prevent closing with Esc button (if you want this too)
    		})
    });
    function getSigntype(){
    	$("#signature-type-error").hide();
    	$("#signature-type-error").html('');
    	var typeValue=$("#typeName").val();
    	var token = $("meta[name='_csrf']").attr("content");
    	var header = $("meta[name='_csrf_header']").attr("content");
    	var contextPath=$("#contextPath").val();
    	$.ajax({  
    	     type : "GET",   
    	     url : contextPath+"typeSignature1",   
    	     data : "imgType="+typeValue,  
    	     dataType: 'json',
    	     beforeSend : function(xhr) {	                
    	    		xhr.setRequestHeader(header, token);
    	    },
    	     success : function(response) {  
    	    	 
    	    	 var imgData=response;
    	    	 $("#showType").empty();
    	 			
     	 		$.each( imgData, function( key, value ) {
    		 		$("#showType").append('<div class="col-md-6 col-sm-6 col-xs-12 thumb"><a  onclick="getTypeData('+key+')" class="imgselect'+key+' thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
    	 	     	//alert(key);
     				// $("#selectType").append('<div class="col-lg-4 col-md-4 col-xs-6 thumb"><a  onclick="getTypeData('+key+')" class="imgselect'+key+' thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
    			});
    	     },  
    	     error : function(e) {  
    	      alert('Error: ' + e);   
    	     }  
    	 });  
    }
    
    $("#typeName").keyup(function(){
     var element = document.getElementById('typeName');
   	 element.value = element.value.replace(/[^a-zA-Z ]+/, '');
   	        $("#signature-type-error").hide();
   			$("#signature-type-error").html('');
   			var typeValue=$("#typeName").val();
   			var token = $("meta[name='_csrf']").attr("content");
   			var header = $("meta[name='_csrf_header']").attr("content");
   			var contextPath=$("#contextPath").val();
   			$.ajax({  
   			     type : "GET",   
   			     url : contextPath+"typeSignature1?imgType="+typeValue,  
   			     dataType: 'json',
   			     beforeSend : function(xhr) {	                
   			    		xhr.setRequestHeader(header, token);
   			     },
   			     success : function(response) {  
   			    	 var imgData=response;
   			    	 	$("#showType").empty();
   		 		 			
   			    	 		$.each( imgData, function( key, value ) {
   			 		 		 
   		 		 			$("#showType").append('<div class="col-md-6 col-sm-6 col-xs-12 thumb"><a  onclick="getTypeData('+key+')" class="imgselect'+key+' thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
   			 		 	     
   		 		 		//alert(key);
   		 		 		// $("#selectType").append('<div class="col-lg-4 col-md-4 col-xs-6 thumb"><a  onclick="getTypeData('+key+')" class="imgselect'+key+' thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
   			    		});
   			     },  
   			     error : function(e) {  
   			     	 alert('Error: ' + e);   
   			     }  
   			    });  
   });
    
    function saveSignature(type){
    	var signature="";
    	var status="";
    	if(type =='mysignature'){
    		signature=$('#showSignature').attr('src');
    	}
		if(type =='draw'){
			var canvas = document.getElementById("newSignature");
			var dataURL = canvas.toDataURL("image/png");
			var defaultBase64;
			if ($.browser.mozilla && $.browser.version >= "2.0" ){
				defaultBase64=$("#drawBaseMozilla64").val();
			}
			/* if( $.browser.safari ){
			   alert('Safari');
			} */
			if ($.browser.chrome){
			   defaultBase64=$("#drawBase64").val();
			}
			if ($.browser.msedge || $.browser.msie && $.browser.version <= 6 || $.browser.msie && $.browser.version > 6){
			   defaultBase64=$("#drawBaseIE64").val();
			}
			if(defaultBase64 == dataURL){
				status="error"
				$("#drawsignature_error").empty();
				$("#drawsignature_error").show();
				$("#drawsignature_error").html("Please draw your signature.").fadeOut(2000);
			}else{
				signature=dataURL;
			}
    	}
		if(type =='type'){
			var sign = $("#myType").val();
			var typeSign=$("#typeName").val();
			var check=validationSignature1(sign,typeSign,"type");
			if(check ==true){
				signature=sign;
			}else{
				status="error";
			}
    	}if(type =='upload'){
    		var sign=$('#blah').attr('src');
    		signature=sign;
    	}
		if(status !="error"){
		var usertoken=$("#usertoken").val();
		var id='${id}';
		var email='${email}';
	    var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		var data = {
				 "id": id,
				 "email":email,
				 "token" : usertoken,
				 "signature" : signature	
		}
		$.ajax({  
		     type : "POST",   
		     url : contextPath+"saveUserSignature",  
		     dataType: 'json',
		     contentType: "application/json; charset=utf-8",
		     data: JSON.stringify(data),
		     beforeSend : function(xhr) {	                
		    		xhr.setRequestHeader(header, token);
		     },
		     success : function(response) {  
		    	if(response !="FAILURE" && response !=''){
		    		$("#showSignature").attr('src' , response);
		    		if(type =='draw'){
		    			$("#signature-sucess-draw").empty();
			    		$("#signature-sucess-draw").show();
			    		$("#signature-sucess-draw").html("Signature has been saved successfully").fadeOut(2000);	
		        	}
		    		if(type =='type'){
		    			$("#signature-sucess-type").empty();
			    		$("#signature-sucess-type").show();
			    		$("#signature-sucess-type").html("Signature has been saved successfully").fadeOut(2000);	
		        		
		        	}
		    		if(type =='upload'){
		    			$("#signature-sucess-upload").empty();
			    		$("#signature-sucess-upload").show();
			    		$("#signature-sucess-upload").html("Signature has been saved successfully").fadeOut(2000);	
		        		
		        	}
		    		
		    	}
		     },  
		     error : function(e) {  
		     	 alert('Error: ' + e);   
		     }  
		    });  
		}
    }
    
    function getTypeData(key){
    	$("#signature-type-error").hide();
    	$('.selected').removeClass('selected');
    	$('.imgselect'+key).addClass('selected');
    	var imgSrc=$('#img'+key).attr('src');
    	$("#myType").val(imgSrc);
    	
    }
  //add signature validation
    function validationSignature1(sign,typeSign,type){
    /* if(sign == "" && typeSign==""){
    	$("#signature-type-error").html("Please make sure you have type your signature and select a font first");
    } */
    if(typeSign == "Type Your Signature"){
    	$("#signature-type-error").show();
    	$("#signature-type-error").html("Please make sure that you have typed your signature and select a font");
    	return false;
    }
    if(typeSign == ""){
    	$("#signature-type-error").show();
    	$("#signature-type-error").html("Please make sure that you have typed your signature");
    	return false;
    }
    if(sign == ""){
    	$("#signature-type-error").show();
    	$("#signature-type-error").html("Please select a font");
    	return false;
    }

    return true;
    }
  
   $("#imgInp").change(function() {
    	  readURL(this);
   });
   
   function readURL(input) {
		if (input.files && input.files[0]) {
		    var reader = new FileReader();

		    reader.onload = function(e) {
		    	
		    	var checkFile=filevalidate();
		    	 if(checkFile == true){ 
			    	var token = $("meta[name='_csrf']").attr("content");
			    	var header = $("meta[name='_csrf_header']").attr("content");
			    	var contextPath=$("#contextPath").val();
			    	var data = {
							 "dataURL" :  e.target.result,
							 "signType" :"Draw"
					}
			    	$.ajax({  
			    	     type : "POST",   
			    	     url : contextPath+"saveResizeSignature",   
			    	     dataType: 'json',
			 		     contentType: "application/json; charset=utf-8",
			 		     data: JSON.stringify(data),
			    	     beforeSend : function(xhr) {	                
			   	    	 xhr.setRequestHeader(header, token);
				   			$("#loader2").show();
					     },
					     complete: function () {
					    	$("#loader2").hide();
					     },
						 success : function(response) {  
							 $("#show_upload_signature").hide();
							 $("#show_upload_yoursignature").show();
			    	    	 $('#blah').attr('src', 'data:image/jpeg;base64,'+response);	 
			    	    	 $("#clearId").show();
			    	    	 
			    		 },  
			    	     error : function(e) {  
			    	      alert('Error: ' + e);   
			    	     }  
			    	 });  
		    	 }
	    
		    }

		    reader.readAsDataURL(input.files[0]);
		  }
	
	}
   function filevalidate() {
		$("#file_error").html("");
		$(".demoInputBox").css("border-color","#F0F0F0");
		var file_size = $('#imgInp')[0].files[0].size;
		var fileInput = document.getElementById('imgInp');
		var filePath = fileInput.value;
	    var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.bmp)$/i;
	    if(!allowedExtensions.exec(filePath)){
	    	
	    	$("#file_error").show();
	    	$("#file_error").html('Please upload file having extensions .png, jpg, jpeg, bmp only.').fadeOut(10000);;
	        fileInput.value = '';
	        return false;
	    }   
	    else if(file_size>10485760) {
			
			$("#file_error").show();
			$("#file_error").html("File size is greater than 10MB").fadeOut(10000);
			$(".demoInputBox").css("border-color","#FF0000");
			return false;
		} 
		return true;
	}
   
 
   
   function clearUploadSignature(){
		
	   $('#blah').attr('src', '');
	    $("#imgInp").val("");
	    $("#show_upload_signature").show();
	    $("#show_upload_yoursignature").hide();
			
	}
 
    </script>
</body>
<input type="hidden" id="myType" value=""/>
<input type="hidden" id="drawBase64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQ0lEQVR4Xu3W0QkAIAxDQV3W/Teo4BQ+uE4QLv3InpmzHAECBAgQIECAAAECXwtsw/3rfoQjQIAAAQIECBAg8AQMd49AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDgAqC3dsd5CiH1AAAAAElFTkSuQmCC"/>
<input type="hidden" id="drawBaseIE64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAPbSURBVHhe7dZBEcAwDMCwbmDLn0H2GYj4TvqYgp+ZuQcAAFjt/QsAACxm3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAACw3jkfMvcE1ytbuLQAAAAASUVORK5CYII="/>
<input type="hidden" id="drawBaseMozilla64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAD2UlEQVR4nO3WMREAIBDAMNTi38EjgRF6lyF7x66Z2QAAwN/W6wAAAODOuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAg4AAckOtgbGrrvgAAAABJRU5ErkJggg=="/>
<input type="hidden" id="tdrawBaseIE64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAI0SURBVHhe7cExAQAAAMKg9U9tDB8gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4K4GhOIAAQ18YIgAAAAASUVORK5CYII="/>

</html>