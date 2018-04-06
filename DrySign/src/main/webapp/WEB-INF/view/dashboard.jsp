<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link href="<%=appUrl %>/css/materialize.css" rel="stylesheet"/>
<link rel="stylesheet" href="<%=appUrl %>/css/style.css"/>
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css"/>

 <style>
	canvas {
			position: relative;
			margin: 1px;
			margin-left: 0px;
			 border: 3px solid #2C3D4F;
			border-radius: 3px;
	}
	 .loader2 {
    position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=appUrl %>/images/ajax-loader_1.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
 }
	
	.selected {
    box-shadow: 9px 11px 28px -12px #080808;
}


</style>
<div id="loader2" class="loader2" style="display:none"></div>
  <!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper bg_wrap">
	<div class="container-fluid">
	<!-- breadcrumb -->
	<ol class="breadcrumb">		
		<li class="active">Home</li>		
	</ol>		
	</div>
	<!-- Main content -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-5 col-sm-12 col-xs-12 margB25">
				<div class="Content-dashboard-module" style="min-height: 350px;">
					<div class="head3_0 margB20">
						OVERVIEW  <span class="pull-right" style="color:#767f88;">Last 6 Month</span>
					</div>
					<div class="Overview-chart">
					<div class="row">
						<div class="col-xs-8">
							<span class="icon-total_document"></span> Total Documents
						</div>
						<div class="col-xs-4 text-right">
							${totalDocument} <span class="icon-eye"></span>
						</div>
					</div>
					<hr/>
					<div class="row" style="color: #43D99A">
						<div class="col-xs-8">
							<span class="icon-completed"></span> Completed
						</div>
						<div class="col-xs-4 text-right">
							${completed} <a href="<%=appUrl %>/app/history/completedDocuments"><span class= "icon-eye"></span></a>
						</div>
					</div>
					<div class="row" style="color: #FFCC80">
						<div class="col-xs-8">
							<span class="icon-waiting"></span> Out for Signature
						</div>
						<div class="col-xs-4 text-right">
							${outForSignature} <a href="<%=appUrl %>/app/history/outforSignature"><span class= "icon-eye"></span></a>
						</div>
					</div>
					<div class="row" style="color: #FF8C89;">
						<div class="col-xs-8">
							<span class="icon-draft"></span> Draft
						</div>
						<div class="col-xs-4 text-right">
							${draft} <a href="<%=appUrl %>/app/history/draft"><span class= "icon-eye"></span></a>
						</div>
					</div>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<p class="font-12" style=" color: #67747c; "><c:if test="${not empty activePurchase.planName }">	* You have utilized ${activePurchase.subscription.usedDocuments }/${activePurchase.subscription.creditedDocuments } documents of your ${activePurchase.planName } Account. <!-- Please click on <a href="" style="color:#00bb9c; font-weight: bold;">BUY NOW</a> to continue with the service. --></c:if>
							 <!-- Please 	   click on <a href="#">BUY NOW</a> to continue with the service. --></p>
							<p class="font-12" style=" color: #67747c; ">* NOTE: You won't lose the saved signatures and documents of your 	${activePurchase.planName } Account once you purchase any of the plan.</p>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-7 col-sm-12 col-xs-12 margB25">
				<div class="Content-dashboard-module" style="min-height: 356px;">
					<div class="head3_0">
						OVERVIEW GRAPH
					</div>
					<div id="container" style="width: 400px; max-width: 100%; height: 300px; margin: 0 auto"></div>
					
				</div>
			</div>
		</div>
		<div class="row " >
			<div class="col-md-5 col-sm-12 col-xs-12 margB25">
				<div class="Content-dashboard-module" style="min-height: 408px;">
					<div class="head3_0" style="z-index: 1;position: relative;">
						${activePurchase.planName } <span class="pull-right"> <!-- <a href="#" id="openSignature" class="btn pull-left btn-blue">BUY NOW</a> -->
						
						<c:if test="${upgrade == 'true' || upgrade == 'TRUE'}">
							
							
							
							<c:choose>
							    <c:when test="${isInternalEmail=='true'}">
							     	<a href="#" style="font-size: 16px;"  onclick ="renew()" class="btn pull-left btn-blue">RENEW</a>
							    </c:when>
							    <c:otherwise> 
							       <a href="<%=appUrl %>/pricing" style="font-size: 16px;"  class="btn pull-left btn-blue">Buy now</a>
							    </c:otherwise>
							</c:choose>
							
							
								
						</c:if>
						</span>
					</div>
					<div class="chart-gauge"></div>
						<div class=" day_left">
							${days} <span>Days Left</span>
						</div>
					<div class="row">
						<div class="col-xs-12" style="font-weight: bold;">
							<c:if test="${not empty expires}">Plan Expires: ${expires}</c:if>
							<br/>
							<c:if test="${not empty  activePurchase.subscription.usedDocuments}">Documents Remaining: ${totalLeftDoc} <small>(${activePurchase.planName }  ACCOUNT)</small></c:if>
						</div>
					</div>
			</div>
			</div>
			<div class="col-md-7 col-sm-12 col-xs-12 ">
			<div class="col-md-12 col-sm-12 col-xs-12 margB25" style="    padding: 0px;">
				<div class="Content-dashboard-module">
					<div class="head3_0">
						Your initials
					</div>
					<c:set var="mysignature" value="${signature}"/>
					<c:set var="signatureType" value="${signatureType}"/>
					<c:choose> 
					  <c:when test="${mysignature == null}">
					    <figure id="show_signature" style="margin-left:217px;    height: 135px;">
						<img class="img-responsive" id="showSignature"  src="data:image/png;base64,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" />						
						</figure>
					  </c:when>
					  <c:when test="${signatureType == 'Type'}">
					    <figure id="show_signature" style="margin-left:143px;    height: 135px;">
						<img class="img-responsive" id="showSignature"  src="${signature}" />						
						</figure>
					  </c:when>
					  <c:otherwise>
					   <figure id="show_signature" style="    height: 135px;">
						<img class="img-responsive" id="showSignature"  src="${signature}" />						
						</figure>
					  </c:otherwise>
					</c:choose>
					<div class="row">
					<div class="col-xs-12">
						<a href="#" id="openSignature" class="btn pull-left btn-blue">EDIT SIGNATURE</a>
						<!-- <a href="#" class="pull-right font-16 btn btn-green">USE NOW</a> -->
					</div>
					</div>
				</div>
				</div>
				
				<div class="col-md-12 col-sm-12 col-xs-12 "  style="    padding: 0px;">
				<div class="Content-dashboard-module" style="min-height: 145px;">
					<div class="head3_0">
						WE WANT YOUR FEEDBACK
					</div>
					<P style="color: #2c3d4f;margin: 15px 0px;">We appreciate your ideas, suggetions, bugs and even your compliments.</P>
					
					<div class="row">
					<div class="col-xs-12">
						<a href="#" id="openSignature" class="btn pull-left btn-blue" onclick="givefeedback();">GIVE FEEDBACK</a>
						
					</div>
					</div>
				</div>
				</div>
				
				
			</div>
		</div>
	</div>
 </div>
<jsp:include page="footer.jsp"></jsp:include>
<!-- Draw Signature -->
  <div class="signature-sign">
	 <div class="header">	 	
		 <a class="close" href="#"><span class="icon-close"></span></a>
	 </div>
	 <ul class="nav nav-tabs self-sign">
			<li id="sDraw"><a href="#draw" data-toggle="tab">DRAW</a>
			</li>
			<li id="sType">
       		 <a  href="#type" data-toggle="tab">TYPE</a>
			</li>
			<li id="uType">
       		 <a  href="#upload" data-toggle="tab">UPLOAD</a>
			</li>
			
	</ul>
	<div class="tab-content self_sing_tab ">
			<div class="tab-pane" id="draw">
         		 <div class="row margTB20">
					 
				 </div>
				 <div class="row margB20">
					  <div class="col-xs-12 text-right">
						  <a class="text-red" onclick="zkSignature.clear()" href="#">Clear</a>
						   <a class="text-green" id="saveSignature" href="#">Save</a>
					  </div>
				  </div>
				  <div class="row margTB20">
					  <div class="col-xs-12">
					  	<div id="canvas">
								Canvas is not supported.
						</div>
					 </div>
					  <div class="col-xs-12" id="drawsignature_error" style="display:none">
					   <div class="alert alert-danger">
					      Please draw your signature.
						</div>
					  </div>
					</div>
				</div>
				<div class="tab-pane" id="upload">
         		 <div class="row margTB20">
				 </div>
				 <div class="row margB20">
					  <div class="col-xs-12 text-right">
					    <a class="text-red"  href="#" onclick="clearUploadSignature();">Clear</a>
						   <a class="text-green"  href="#" onclick="saveUploadSignature();">Save</a>
					  </div>
				  </div>
				  <div class="row margTB20" id="show_upload_signature">
				   <div class="col-xs-12 head3_0 text-center">
				   	
				   	Upload a picture of your signature
				  
				   </div>
				    	<br> 	<br>
					  <div class="col-xs-12 text-center">
					  	<div id="upload_signature">
							<form id="form1" >
							   <label class="btn-bs-file btn btn-lg btn-blue">
                					<i class="fa fa-upload" aria-hidden="true"></i>Upload
                				<input type='file' id="imgInp" class="demoInputBox"  />
            					</label>
							   
							 
							</form>
							
						</div>
						
					 </div>
					  <div class="col-xs-12 text-center">
					  <br><br>
				   		<p class="text-warning" >Maximum file size: 10 MB</p>
				   		<p class="text-warning">Acceptable file formats: png, jpg, jpeg, bmp</p>
				   	</div>
					</div>
					 <div class="row margTB20" id="show_upload_error_signature">
					  	
					  	<div class="alert alert-danger"  id="file_error" style="display:none"></div>
					 </div>
					  <div class="col-xs-12 text-center">
					 <img id="blah" src="" class="img-thumbnail" width="750px" height="186px"  alt="" style="display:none"/>
					 </div>
				</div>
			  <div class="tab-pane" id="type">
				  <div class="row margTB20">
						<div class="col-md-6 col-sm-6 col-xs-12">
						<div class="input-field">
							<input id="typeName" type="text" value="<%=registration.getFirstName()%> <%=registration.getLastname()%>" class="validate">
							<label for="last_name">Your Name</label>
						</div>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12 text-right">
							<!-- <a class="text-red" href="#">Reset</a> -->
						   <a class="text-green" href="#" onclick="saveTypeSignature();">Save</a>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12" >
						
						</div>
				  </div>
				   <div class="row">
			    	<div class="col-xs-12" >
				   		<div class="alert alert-danger" id="signature-type-error" style="display:none">
				      
						</div>
				  </div>
				  </div>
				  <div class="row">
					  <div class="col-xs-12 text-right">
						 <!--  <a class="text-red" href="#">Reset</a>
						   <a class="text-green" href="#">Save</a> -->
					  </div>
				  </div>
				  <div class="row margTB20" id="showType">
					  <!-- <div class="col-xs-12">
					  	<div class="pdf_view" id="showType">
					 
						</div>
					  </div> -->
				  </div>
				   
				</div>	
	</div>
</div>

 <div class="overlay-bg"></div>
 <input type="hidden" id="myType" value=""/>
<input type="hidden" id="drawBase64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQ0lEQVR4Xu3W0QkAIAxDQV3W/Teo4BQ+uE4QLv3InpmzHAECBAgQIECAAAECXwtsw/3rfoQjQIAAAQIECBAg8AQMd49AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDgAqC3dsd5CiH1AAAAAElFTkSuQmCC"/>
<input type="hidden" id="drawBaseIE64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAPbSURBVHhe7dZBEcAwDMCwbmDLn0H2GYj4TvqYgp+ZuQcAAFjt/QsAACxm3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAACw3jkfMvcE1ytbuLQAAAAASUVORK5CYII="/>
<input type="hidden" id="drawBaseMozilla64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAD2UlEQVR4nO3WMREAIBDAMNTi38EjgRF6lyF7x66Z2QAAwN/W6wAAAODOuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAg4AAckOtgbGrrvgAAAABJRU5ErkJggg=="/>
<input type="hidden" id="drawBaseSafari64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQ0lEQVR4Ae3WQQ3AQAwDweuBLX8GqVQUWWmCwBrn4Wdm3uMIECBAgAABAgQIEFgtcFenE44AAQIECBAgQIAAgV/AcPcIBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEPjL3BNcQbtHHAAAAAElFTkSuQmCC"/>
<script src="<%=appUrl %>/js/highcharts.js"></script>
<script src="<%=appUrl %>/js/custom-file-input.js"></script> 
<script src="<%=appUrl %>/js/jquery.validate.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.12/d3.min.js"></script> 
<%-- <script src="<%=appUrl %>/js/D3.js"></script> --%>
<script src="<%=appUrl %>/js/materialize.js"></script>
<script>
	$(function() {
		
	
        // Create the chart
        var completed='${completed}';
        var docLeft=5;
        var draft='${draft}';
        var outForSignature='${outForSignature}';
        var deleted='${deleted}';
        var totalDocument='${totalDocument}';
        var creditdoc = '${activePurchase.subscription.creditedDocuments }';
        var debitdoc = '${activePurchase.subscription.usedDocuments }';
        var totalLeftDoc = '${totalLeftDoc}';
        creditdoc = creditdoc=="" ? 0 : creditdoc;
        debitdoc = debitdoc=="" ? 0 : debitdoc;
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'pie'
            },
            title: {
                text: parseInt(totalLeftDoc)+'<br>Document(s) Left',//parseInt(debitdoc)+'/'+parseInt(creditdoc)
                align: 'center',
                verticalAlign: 'middle',
                y: -30
            },
            yAxis: {
                title: {
                    text: 'Total percent market share'
                }
            },
            plotOptions: {
                pie: {
                    shadow: false
                }
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.point.name +'</b>: '+ this.y +'';
                }
            },
            series: [{
                name: 'Browsers',
                data: [["Completed",parseInt(completed)],["Draft",parseInt(draft)],["Out for Signature",parseInt(outForSignature)]],
                size: '99%',
                innerSize: '70%',
                showInLegend:true,
                dataLabels: {
                    enabled: false
                }
            }]
        });
    });
</script>
<script>
//Upload
function saveUploadSignature(){
	var sign = $('img[id="blah"]').attr('src');
	var fileInput = document.getElementById('imgInp');
	if(sign == ''){
		$("#file_error").show();
    	$("#file_error").html('Please upload a picture of your signature.').fadeOut(10000);;
        fileInput.value = '';
	}else{
	
	$(".signature-sign").hide();
	$('.overlay-bg').hide();
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	var data = {
			 "dataURL" : sign,
			 "signType" :"Upload"
	}
	 $.ajax({
		type : "POST",
		url : contextPath+"app/saveSignature",
		dataType: 'json',
	    contentType: "application/json; charset=utf-8",
	    data: JSON.stringify(data),
	    beforeSend: function (xhr) {
   			xhr.setRequestHeader(header, token);
   			$("#loader2").show();
	    },
	    complete: function () {
	    	$("#loader2").hide();
	    },
        success : function(response) {
         	if(response != 'failed'){
         		$("#show_upload_error_signature").show();
         		document.getElementById("showSignature").src = sign;
        		$("#show_signature").css("margin-left","0px");
         	}else{
            	alert('failed');
            }
		},
		 error : function(e) {  
		   // alert('Error: ' + e);   
		}  
	 }); 
	}
}

//Type

function saveTypeSignature(){
	    var sign = $("#myType").val();
		var typeSign=$("#typeName").val();
		var check=validationSignature1(sign,typeSign,"type");
		if(check ==true){
			
		/* 	val=$("#field_"+fieldValue).attr('src', sign);	
			$("#field_"+fieldValue).val(val); */
			
			$(".signature-sign").hide();
			$('.overlay-bg').hide();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var contextPath=$("#contextPath").val();
			var data = {
					 "dataURL" : sign,
					 "signType" :"Type"
			}
			$.ajax({
				type : "POST",
				url : contextPath+"app/saveSignature",
				dataType: 'json',
			    contentType: "application/json; charset=utf-8",
			    data: JSON.stringify(data),
			    beforeSend: function (xhr) {
		   			xhr.setRequestHeader(header, token);
		   			$("#loader2").show();
			    },
			    complete: function () {
			    	$("#loader2").hide();
			    },
		        success : function(response) {
		         	if(response != 'failed'){
		        		//alert("success");
		         		
		    			document.getElementById("showSignature").src = sign;
		    			$("#show_signature").css("margin-left","143px");
		            }else{
		            	alert('failed');
		            }
				},
				 error : function(e) {  
				   // alert('Error: ' + e);   
				}  
			 });
		
		}
}

String.prototype.fulltrim = function() {
	  return this.replace(/(?:(?:^|\n)\s+|\s+(?:$|\n))/g, '').replace(/\s+/g, ' ');
	};

	
function getTypeData(key){
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
		$("#signature-type-error").html("Please make sure you have type your signature and select a font");
		return false;
	}
	if(typeSign == ""){
		$("#signature-type-error").show();
		$("#signature-type-error").html("Please make sure you have type your signature");
		return false;
	}
	if(sign == ""){
		$("#signature-type-error").show();
		$("#signature-type-error").html("Please select a font");
		return false;
	}
	
	return true;
}


$("#typeName").keyup(function(){
	
	 var element = document.getElementById('typeName');
	 element.value = element.value.replace(/[^a-zA-Z ]+/, '');

		 $("#signature-type-error").hide();
			$("#signature-type-error").html('');
			var typeValue=$("#typeName").val().fulltrim();
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var contextPath=$("#contextPath").val();
			$.ajax({  
			     type : "GET",   
			     url : contextPath+"app/typeSignature?imgType="+typeValue,  
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
function getSigntype(){
	$("#signature-type-error").hide();
	$("#signature-type-error").html('');
	var typeValue=$("#typeName").val();
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	$.ajax({  
	     type : "GET",   
	     url : contextPath+"app/typeSignature",   
	     data : "imgType="+typeValue.fulltrim(),  
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

//Draw Signature
$('#openSignature').click(function() {
	$("#drawsignature_error").hide();
	$("#file_error").hide();
	zkSignature.clear();
	getSigntype();
	$("#sType").removeClass('active');
	$("#type").removeClass('active');
	$("#uType").removeClass('active');
	$("#uType").removeClass('active');
	$("#upload").removeClass('active');
	$("#sDraw").addClass('active');
	$("#draw").addClass('active');
	$("#show_upload_signature").show();
	$("#blah").hide();
	 
	$("#myType").val('');
	$("#blah").attr('src', '');
	document.getElementById("imgInp").value = "";
	
	$('.overlay-bg').show();
	$('.signature-sign').show();
		var $slider = $('.signature-sign');
		$slider.animate({
		 right: parseInt($slider.css('right'),10) == -350 ? 0 : 0
		});
});

$('.close').click(function(){
	//$('.save-signature-box').hide();
	$(".signature-sign").hide();
	$('.overlay-bg').hide();
	 //return false;
}); 

$("#saveSignature").click(function(){
	
	var canvas = document.getElementById("newSignature");
	// save canvas image as data url (png format by default)
	var dataURL = canvas.toDataURL("image/png");
	console.log(dataURL);
	var defaultBase64;
	if ($.browser.mozilla && $.browser.version >= "2.0" ){
		defaultBase64=$("#drawBaseMozilla64").val();
	}
	 if( $.browser.safari ){
		  defaultBase64=$("#drawBaseSafari64").val();
	} 
	if ($.browser.chrome){
	   defaultBase64=$("#drawBase64").val();
	}
	if ($.browser.msedge || $.browser.msie && $.browser.version <= 6 || $.browser.msie && $.browser.version > 6){
	   defaultBase64=$("#drawBaseIE64").val();
	}
	if(defaultBase64 == dataURL){
		
		$("#drawsignature_error").show();
	}else{
		$(".signature-sign").hide();
		$('.overlay-bg').hide();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		var data = {
				 "dataURL" : dataURL,
				 "signType" :"Draw"
		}
		$.ajax({
			type : "POST",
			url : contextPath+"app/saveSignature",
			dataType: 'json',
		    contentType: "application/json; charset=utf-8",
		    data: JSON.stringify(data),
		    beforeSend: function (xhr) {
	   			xhr.setRequestHeader(header, token);
	   			$("#loader2").show();
		    },
		    complete: function () {
		    	$("#loader2").hide();
		    },
	        success : function(response) {
	         	if(response != 'failed'){
	        	
	        		document.getElementById("showSignature").src = dataURL;
	        		$("#show_signature").css("margin-left","0px");
	        				
	            }else{
	            	alert('failed');
	            }
			},
			 error : function(e) {  
			    alert('Error: ' + e);   
			}  
		 });
	}
});
</script> 
<script src="<%=appUrl %>/js/signature.js"></script>
<script>
zkSignature.capture();
//End Draw Singature
</script>

<script>
//script of days chart


(function () {
    var Needle, arc, arcEndRad, arcStartRad, barWidth, chart, chartInset, degToRad, el, endPadRad, height, i, margin, needle, numSections, padRad, percToDeg, percToRad, percent, radius, ref, sectionIndx, sectionPerc, startPadRad, svg, totalPercent, width;
    percent = ${daysLeftPercent};
    barWidth = 40;
    numSections = 3;
    sectionPerc = 1 / numSections / 2;
    padRad = 0.05;
    chartInset = 10;
    totalPercent = 0.75;
    el = d3.select('.chart-gauge');
    margin = {
        top: 20,
        right: 20,
        bottom: 30,
        left: 20
    };
    width = el[0][0].offsetWidth - margin.left - margin.right;
    height = width;
    radius = Math.min(width, height) / 2;
    percToDeg = function (perc) {
        return perc * 360;
    };
    percToRad = function (perc) {
        return degToRad(percToDeg(perc));
    };
    degToRad = function (deg) {
        return deg * Math.PI / 180;
    };
    svg = el.append('svg').attr('width', width + margin.left + margin.right).attr('height', height + margin.top + margin.bottom);
    chart = svg.append('g').attr('transform', 'translate(' + (width + margin.left) / 2 + ', ' + (height + margin.top) / 2 + ')');
    for (sectionIndx = i = 1, ref = numSections; 1 <= ref ? i <= ref : i >= ref; sectionIndx = 1 <= ref ? ++i : --i) {
        /*if (window.CP.shouldStopExecution(1)) {
            break;
        }*/
        arcStartRad = percToRad(totalPercent);
        arcEndRad = arcStartRad + percToRad(sectionPerc);
        totalPercent += sectionPerc;
        startPadRad = sectionIndx === 0 ? 0 : padRad / 2;
        endPadRad = sectionIndx === numSections ? 0 : padRad / 2;
        arc = d3.svg.arc().outerRadius(radius - chartInset).innerRadius(radius - chartInset - barWidth).startAngle(arcStartRad + startPadRad).endAngle(arcEndRad - endPadRad);
        chart.append('path').attr('class', 'arc chart-color' + sectionIndx).attr('d', arc);
    }
   /* window.CP.exitedLoop(1);*/
    Needle = function () {
        function Needle(len, radius1) {
            this.len = len;
            this.radius = radius1;
        }
        Needle.prototype.drawOn = function (el, perc) {
            el.append('circle').attr('class', 'needle-center').attr('cx', 0).attr('cy', 0).attr('r', this.radius);
            return el.append('path').attr('class', 'needle').attr('d', this.mkCmd(perc));
        };
        Needle.prototype.animateOn = function (el, perc) {
            var self;
            self = this;
            return el.transition().delay(500).ease('elastic').duration(3000).selectAll('.needle').tween('progress', function () {
                return function (percentOfPercent) {
                    var progress;
                    progress = percentOfPercent * perc;
                    return d3.select(this).attr('d', self.mkCmd(progress));
                };
            });
        };
        Needle.prototype.mkCmd = function (perc) {
            var centerX, centerY, leftX, leftY, rightX, rightY, thetaRad, topX, topY;
            thetaRad = percToRad(perc / 2);
            centerX = 0;
            centerY = 0;
            topX = centerX - this.len * Math.cos(thetaRad);
            topY = centerY - this.len * Math.sin(thetaRad);
            leftX = centerX - this.radius * Math.cos(thetaRad - Math.PI / 2);
            leftY = centerY - this.radius * Math.sin(thetaRad - Math.PI / 2);
            rightX = centerX - this.radius * Math.cos(thetaRad + Math.PI / 2);
            rightY = centerY - this.radius * Math.sin(thetaRad + Math.PI / 2);
            return 'M ' + leftX + ' ' + leftY + ' L ' + topX + ' ' + topY + ' L ' + rightX + ' ' + rightY;
        };
        return Needle;
    }();
    needle = new Needle(90, 15);
    needle.drawOn(chart, 0);
    needle.animateOn(chart, percent);
    
    
    
}.call(this));

function renew(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	$.ajax({
		type : "POST",
		url : contextPath+"/renew",
		//dataType: 'json',
	    //contentType: "application/json; charset=utf-8",
	    //data: JSON.stringify(data),
	    beforeSend: function (xhr) {
   			xhr.setRequestHeader(header, token);
   			$("#loader2").show();
	    },
	    complete: function () {
	    	$("#loader2").hide();
	    },
        success : function(response) {
        	if(response == "true"){
        		
        		$.confirm({
    	    	    title: 'Subscription renewed successfully.',
    	    	    content: ' ',
    	    	    buttons: {
    	    	        somethingElse: {
    	    	            text: 'Ok',
    	    	            keys: ['enter', 'shift'],
    	    	            action: function(){
    	    	            	window.location = contextPath+'app/dashboard';
    	    	            	//alert(location.href);
    	    	            }
    	    	        }
    	    	    }
    	    	});
        		
        		
        	}else{
        		$.confirm({
    	    	    title: response,
    	    	    content: ' ',
    	    	    buttons: {
    	    	        somethingElse: {
    	    	            text: 'Ok',
    	    	            keys: ['enter', 'shift'],
    	    	            action: function(){
    	    	            	window.location = contextPath+'app/dashboard';
    	    	            }
    	    	        }
    	    	    }
    	    	});
        		
        	}
         	
		},
		 error : function(e) {  
		    alert('Error: ' + e);   
		}  
	 });	
}

var submitqueryform = $("#submitfeedback").validate({
	//specify the validation rules
	rules : {
		email : {
			required : true,
			email : true
		//email is required AND must be in the form of a valid email address
		},
		name : {
			required : true
		},
		message : {
			required : true
		}
		

	},
	//specify validation error messages
	messages : {
		email : {
			required : "Please enter a valid email address",
			email : "Please enter a valid email address"
		},
		name : {
			required : "Please enter Name",

		},
		message : {
			required : "Please write your query",

		}
		
	}
});

function givefeedback(){
	$.confirm({
	    title: '',
	    content: '' +
	    '<form action="" class="formName" id="submitfeedback">' +
	    '<div class="form-group">' +
	    '<label>Name<span class="redstar1">*</span></label>' +
	    '<input type="text" value="<%=registration.getFirstName()%> <%=registration.getLastname()%>" class="name form-control" readonly required />' +
	    '</div>' +
	    '<div class="form-group">' +
	    '<label>Email Address<span class="redstar1">*</span></label>' +
	    '<input type="text" value="<%=registration.getEmail()%>" class="email form-control" readonly required />' +
	    '</div>' +
	    '<div class="form-group">' +
	    '<label>Message<span class="redstar1">*</span></label>' +
	    '<textarea type="text" id="message" placeholder="Type Message" class="message form-control" required ></textarea>' +
	    '</div>' +
	    '</form>',
	    buttons: {
	    	 
	    	formSubmit: {
	            text: 'SEND',
	            btnClass: 'btn-green',
	            action: function () {
	            	var token = $("meta[name='_csrf']").attr("content");
	        		var header = $("meta[name='_csrf_header']").attr("content");
	                var name = this.$content.find('.name').val();
	        		var email = this.$content.find('.email').val();
	        		var message = this.$content.find('.message').val().trim();
	        		var valid = $("#submitfeedback").valid();
	        	//	if ($('#message').val().trim() != "") {
	                  if(!message){
                    $.alert('Kindly provide some feedback message');
                    return false;
	                  }
	                  else{
	    			$.ajax({
	    				type : "POST",
	    				url : "submitfeedback",
	    				data : {
	    					name : name,
	    					email : email,
	    					message : message
	    				},
	    				//	data : JSON.stringify(data),
	    				//	contentType: "application/json; charset=utf-8",
	    				 beforeSend: function (xhr) {
              				   			xhr.setRequestHeader(header, token);
              				   			$("#loader2").show();
              					    },
              					    complete: function () {
              					    	$("#loader2").hide();
              					    },

	    				success : function(response) {
	    					if (response == 1) {
	    						  $.alert('Thanks for your Feedback ');
	    						//$("#emailsuccessalert").show();
	    						

	    					} else {
	    						  $.alert('There is some issue in submitting the feedback ');
	    						// $("#emailfailalert").show();
	    					//	$("#emailfail").html(response); 
	    					}
	    				},
	    				error : function(xhr, textStatus, errorThrown) {
	    					alert('ajax loading error... ... ');
	    					return false;
	    				}
	    			});
	            }
	        		
	            }
	        },
	        cancel: {
		        btnClass: 'btn-red'
            },
	     
	    },
	    onContentReady: function () {
	        // bind to events
	        var jc = this;
	        this.$content.find('form').on('submit', function (e) {
	            // if the user submits the form by pressing enter in the field.
	            e.preventDefault();
	            jc.$$formSubmit.trigger('click'); // reference the button and click it
	        });
	    }
	});
}
	
//upload siggnature code
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
		    	     url : contextPath+"app/resizeSignature",   
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
						 $("#blah").show();
		    	    	 $('#blah').attr('src', 'data:image/jpeg;base64,'+response);	 
		    		 },  
		    	     error : function(e) {  
		    	      alert('Error: ' + e);   
		    	     }  
		    	 });  
	    	 }
    
	    }

	    reader.readAsDataURL(input.files[0]);
	  }
 /*  if (input.files && input.files[0]) {
   
	 	 var reader = new FileReader();
    	 reader.onload = function(e) {
    		
   		  var checkFile=filevalidate();
   		   alert('Hii check');
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
	    	     url : contextPath+"app/resizeSignature",   
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
	    	    	 $('#blah').attr('src', 'data:image/jpeg;base64,'+response);	 
	    		 },  
	    	     error : function(e) {  
	    	      alert('Error: ' + e);   
	    	     }  
	    	 });  	
    
      
  	  }

    	reader.readAsDataURL(input.files[0]);
	  }
  } */
}

$("#imgInp").change(function() {
  readURL(this);
});

function clearUploadSignature(){
	$('#blah').attr('src', '');
    $("#imgInp").val("");
    $("#show_upload_signature").show();
    $("#blah").hide();
		
}
</script>