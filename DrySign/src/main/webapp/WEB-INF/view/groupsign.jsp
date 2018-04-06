<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page import="com.drysign.model.Registration,org.springframework.security.core.context.SecurityContextHolder,org.springframework.security.core.Authentication" %>

<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<% Authentication auth = SecurityContextHolder.getContext().getAuthentication(); %>
<% Registration registration = (Registration)auth.getPrincipal(); %>
 <jsp:include page="header.jsp"></jsp:include>

 
<link rel="stylesheet" href="<%=appUrl %>/css/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="<%=appUrl %>/css/jquery-ui.css">
<link rel="stylesheet" href="<%=appUrl %>/css/materialize-tags.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">

<style>
.red-tooltip  {background-color: #000; color:#fff: display: block !important }
.red-tooltip > .tooltip-arrow {
  border-top-color: red;
}
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
     border-top: 0px;
}
.Message {
      box-shadow: 0px 0px 10px 1px #d4d4d4 !important;
}
.modal-header .close {
    margin-top: -20px;
    font-size: 50px;
    margin-right: -35px;
}
.drag-textbox{
    border-radius: 1px !important;
    border-color: #a29999 !important;
    min-width: 165px !important;
    border: 1px solid;
   
    color: #fff;
    /* box-shadow: 0 3px 3px 0 rgba(0, 0, 0, 0.14), 0 1px 7px 0 rgba(0, 0, 0, 0.12), 0 3px 1px -1px rgba(0, 0, 0, 0.2); */
    display: inline-block;
    /* padding: 6px 12px; */
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
}
.modal {
    display:block;
}

 input[type=image]{
 height: 54px;
 width:185px;
 background: #eee;
 background-color: transparent;
 }

.loader {
   position: absolute;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=appUrl %>/images/ajax-loader_1.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
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
 
  form .error{
     color: #ff0000 !important;
 }
.dragSigners{
    z-index: auto !important;
}
.modal-body {
    max-height: calc(100vh - 210px);
    overflow-y: auto;
}

</style>
 <style>
	canvas {
			position: relative;
			margin: 1px;
			margin-left: 0px;
			 border: 3px solid #2C3D4F;
			border-radius: 3px;
	}
</style>
<link href="<%=appUrl %>/css/materialize.css" rel="stylesheet"/>
<link rel="stylesheet" href="<%=appUrl %>/css/style.css">
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css"/>
<%-- <link rel="stylesheet" href="<%=appUrl %>/css/site-demos.css"> --%>
<style>
.table-sortable tbody tr {
   cursor: move;
}
</style>
<style type="text/css">
.ui-sortable tr {
	cursor:pointer;
}
/*		
.ui-sortable tr:hover {
	background:rgba(244,251,17,0.45);
}
*/
.required {
    color: red;
}
</style>
<style>
#signthis-document-viewer{
    width: 100%;
    height: 600px;
}
.document-reader img {
    border: 1px solid #c5c5c5;
      display: block;
}
.page-number{
    margin-bottom: 5px;
    border: 1px solid #bdb8b6;
    color: #a59595;
    background: #eee;
}

.dragSigners, .dragMe{
   /*  margin: 5px;
    padding: 5px;
 	background: #2E2E33;
    color: #FFF;
    text-align: center;
    border-radius: 3px;
    font-family: Helvetica,Arial,sans-serif;
    font-size: 12px;*/
     cursor: move;
}
.dragSigners{
    z-index: 999;
}
.dragMe{
    position: relative;
}
.closeIt{
    color: #111;
   /* padding: 0 2px;*/
    cursor: pointer;
}
/*end responsive iframe*/

/*table rows color*/
.even{background-color: #F5F5F5;}
/*end table rows color*/

.error{
    color: red;
    font-size: 12px;
}

#handwriting_scroll {
    height: 100px;
    position: relative;
    overflow: auto;
}

.signature-section{
    border-left: 1px solid blue;
    border-top: 1px solid blue;
    border-bottom: 1px solid blue;
    border-radius: 5px;
    padding: 5px;
}
.signature-section img{
    max-width: 75px;
}

.main-wrapper{
    max-height: 600px;
    overflow: auto;
}

/* .sidebar{
    position: fixed;
} */

.document-content{
    position: relative;
    left: 325px;
}
.drop-area {
    background-color:#afd1b2;
}
/* .hideIt {
    visibility: hidden;
} */

.drop-select .closeIt {
    font-size: 8px;
    width: 15px;
    height: 15px;
    background: #000000;
    border-radius: 50%;
    color: #fff;
    box-shadow: none;
    text-shadow: none;
    padding: 2px 3px;
    position: absolute;
    top: 3px;
    right: -14px;
    z-index: 999;
}

</style>
<div id="loader2" class="loader2" style="display:none"></div>
 
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper bg_wrap">
  <div class="container-fluid">
    <!-- breadcrumb -->
	<ol class="breadcrumb">
		<li><a href="<%=appUrl %>/app/dashboard">Home</a></li>
		<li><a href="<%=appUrl %>/app/document">Document</a></li>
		<li class="active">Group Sign</li>
		
	</ol>
	  </div>
        <!-- breadcrumb -->
        
        <!-- Main content -->
        
       <div class="container-fluid">   
       <div id="show-groupsign-steps">
    <div class="wizard">
      <div class="wizard-inner group-sign">
        <div class="connecting-line"></div>
        <ul class="nav nav-tabs" role="tablist">
			<li role="presentation" id="steplist1" class="disabled"> <a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" > <span class="round-tab" style="left: 0"></span> </a> </li>
            <li role="presentation" id="steplist2" class="disabled"> <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" > <span class="round-tab div_add"></span></a> </li>
            <li role="presentation" id="steplist3" class="disabled"> <a href="#step3" data-toggle="tab" aria-controls="step3" role="tab" > <span class="round-tab div_add1"> </span> </a> </li>
            <li role="presentation" id="steplist4" class="disabled"> <a href="#step4" data-toggle="tab" aria-controls="step4" role="tab" > <span class="round-tab" style="right: -15px"></span> </a> </li>
        </ul>
      </div>
      <div class="tab-content accordion"> 
        <!-- Personal Information -->
        <div class="tab-pane" role="tabpanel" id="step1">
          <div class="step1">
            <section>
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                      
                        <h3 class="head3_1">Step 1: please upload your document</h3>                       
                      </div>
                      
                    </div>                   
                    <div class="row">                    
                      <div class="col-xs-12">   
<!--                       <button type="submit" id="pick"style="border: 0; background: transparent"> -->
<%-- 							<img src="<%=appUrl %>/images/photo.jpg" width="70" height="70" alt="submit" /> --%>
<!-- 							</button>                     -->
                        <div class="upload-fild">
                        
                         <!-- <input type="file" name="file-7[]" id="file-7" class="inputfile inputfile-6" data-multiple-caption="{count} files selected" placeholder="select the pdf file to upload" onchange="readURL(this); " /> -->
                        <div class="custom-file-upload">
                        
   							<input id="fileupload" placeholder="Please select uploaded file" type="file" name="files">
   							
   								<button data-toggle="tooltip" class="red-tooltip" data-placement="top" title="Google Drive" type="submit" class="" id="pick"style="border: 0;background: transparent;float: right;position: absolute;right: -20px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/photo.jpg" width="30" height="30" alt="submit" />
								</button>
								
								<button data-toggle="tooltip" class="red-tooltip" data-placement="top" title="Dropbox" type="submit" class="" id="dropbox"style="border: 0;background: transparent;float: right;position: absolute;right: -50px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/dropbox.png" width="30" height="30" alt="submit" />
								</button>
								<button data-toggle="tooltip" class="red-tooltip" data-placement="top" title="OneDrive" type="submit" class="" id="onedrive" onclick="launchOneDrivePicker()" style="border: 0;background: transparent;float: right;position: absolute;right: -90px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/onedrive.png" width="30" height="30" alt="submit" />
								</button>
								<!-- Egnyte -->
								<%-- <button onclick="return popitupEgnyte('egnyte')" data-toggle="tooltip" class="red-tooltip" data-placement="top" title="Dropbox" type="submit" class="" id="egnyte" style="border: 0;background: transparent;float: right;position: absolute;right: -128px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/egnyte.png" width="30" height="30" alt="submit" />
								</button> --%>
						</div>
                         
                          <div id="progress" class="progress">
							<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">  
							</div>
 						  </div>
 						  <span id="show_upload_error" style="color:#ff0000"></span>
                        </div>
                      </div>
                    </div>
                
                    
                    <ul class="list-inline text-center">
                      <li>
                        <button type="button" id="jumpstep2" class="btn btn-primary next-step " disabled>SAVE AND NEXT </button>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </section>
          </div>
          
          <!-- button --> 
          
              <div>

	<input  type="text" id="filename" type="text" style="display: none;" >
	<input  type="button" id="save" value="save" onclick="download()" style="display: none;"></button>
	<input type="hidden" id="fileId">

</div>
          
        </div>
        
        <!-- Profestional Information -->
        <div class="tab-pane" role="tabpanel" id="step2">
          <div class="step2">
            <section>
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <h3 class="head3_1">Step 2: Signatures required for this document</h3>
                      </div>
                    </div>
                    
                    
                    
					<!--   <div class="Group-Sign-addremove">
						  <div class="row th">
						  	<div class="col-md-1 col-xs-1 col-sm-1 th">
							  </div>
							  <div class="col-md-4 col-xs-12 col-sm-4 th">
							  	Signee Name
							  </div>
							   <div class="col-md-4 col-xs-12 col-sm-4 th">
							   	Email Address
							   </div>
							    <div class="col-md-3 col-xs-12 col-sm-3 th">
							    	
							    </div>
						  </div>
                   <div class="row marg ">
						  	<div class="col-md-1 col-xs-1 col-sm-1 ">
						  	1
							  </div>
							  <div class="col-md-4 col-xs-12 col-sm-4 ">
							  	GurcharanJeet Singh (ME)
							  </div>
							   <div class="col-md-4 col-xs-12 col-sm-4 ">
							   	gurcharanjeet.singh@banctec.in
							   </div>
							    <div class="col-md-3 col-xs-12 col-sm-3 ">
									<button type="submit" class="btn btn-red" value="Remove">Remove</button>
							    </div>
						  </div>
                   <div class="row marg ">
						  	<div class="col-md-1 col-xs-1 col-sm-1 ">
						  	2
							  </div>
							  <div class="col-md-4 col-xs-12 col-sm-4 ">
							  	GurcharanJeet Singh (ME)
							  </div>
							   <div class="col-md-4 col-xs-12 col-sm-4 ">
							   	gurcharanjeet.singh@banctec.in
							   </div>
							    <div class="col-md-3 col-xs-12 col-sm-3 ">
									<button type="submit" class="btn btn-red" value="Remove">Remove</button>
							    </div>
						  </div>
                   <div class="row marg ">
						  	<div class="col-md-1 col-xs-1 col-sm-1 ">
						  	3
							  </div>
							  <div class="col-md-4 col-xs-12 col-sm-4 ">
							  	GurcharanJeet Singh (ME)
							  </div>
							   <div class="col-md-4 col-xs-12 col-sm-4 ">
							   	gurcharanjeet.singh@banctec.in
							   </div>
							    <div class="col-md-3 col-xs-12 col-sm-3 ">
									<button type="submit" class="btn btn-red" value="Remove">Remove</button>
							    </div>
						  </div>
                    </div>
					  
					  <div class="text-left margTB15">
					  <a class="" href="#">Add More</a>
					  </div> -->
					  
			
	            <table class="table Group-Sign-addremove table-striped" id="diagnosis_list">
	                <thead>
	                    <tr class="th" ><th class="priority_header">Priority</th><th>Signee Name</th><th>Email Address</th><th></th></tr>
	                </thead>
	                <tbody>
						<tr id='addr0'>
						  <td class='priority' id="priority0">1</td>
						  <td>
							<input type="text" name='signername' id="signername0" placeholder='Signee Name' class="form-control" onchange="validateSigners();"/>
							 <span class="required" id="signervalidname0" style="display:none">Please enter signer name </span>
						  </td>
						  <td>
							<input type="text" name='signeremail' id='signeremail0' placeholder='Email Address' class="form-control" onchange="validateSigners();"/>
							<span class="required" id="signervalidemail0" style="display:none">Please enter valid email address</span>
						  </td>
						  <td><a class='btn btn-red'>Remove</a></td>
						</tr>
						<tr id='addr1'></tr>
						
	                </tbody>
	            </table>
			
			 <div class="text-left margTB15">
			 	<a class="" id="add_row" href="#">Add More</a> <!-- &nbsp 	 <a class="" id="add_row" href="#">Add CC</a> -->
			 </div>
			 <div class="row">
                  <div class="col-xs-3">
                     <div class="checkbox checkbox-primary">
                        <input type="checkbox" onclick="enable_disable_proirity();" class="mycheckbox" id="checkbox2"  >
                        <label for="checkbox2"> Assign signer order </label>
                     </div>
                  </div>
                  <div class="col-xs-9"></div>
               </div>
				<input type="hidden" id="add-row" value="1"/>
				<input type="hidden" id="total-row" value="1"/>
                   <hr/>
                    <ul class="list-inline text-right">                     
                      <li>
                        <button id="save_next_2" type="button" class="btn btn-primary next-step" disabled>Save and Next</button>
                      </li>
                    </ul>
                  </div>
				  </div>
                <!-- Buttons --> 
              </div>
            </section>
          </div>
        </div>
         <!-- Profestional Information -->
        <div class="tab-pane" role="tabpanel" id="step3">
          <div class="step3">
            <section>
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature" style="width: 95%; float: left">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <h3 class="head3_1">Step 3: Prepare and sign</h3>
                      </div>
                    </div>
                     <div class="pdf_view">
					  	<div class="force-overflow">
						  	 <div class="pdf-inner mCustomScrollbar" >
						 	 		<div id="loader1" class="loader"></div>
					  			 <div class='document-reader' id="document-reader">
		                          	<div id='draggable-signature' class="fixed">
		                          	
		                      			
		                            
		                            <!-- <img width="890px" height="1152px" class="loadImage" onload="loadImage()" src="http://drysign.global:80/img?fileid=689&filename=2OfferLetterHourlyTemplatewithDSlanguage_2015Updated (1).pdf&page=1">
		                            <div class="page-number">Page 1</div>
		                            
		                            <img width="890px" height="1152px" class="loadImage" onload="loadImage()" src="http://drysign.global:80/img?fileid=689&filename=2OfferLetterHourlyTemplatewithDSlanguage_2015Updated (1).pdf&page=2">
		                            <div class="page-number">Page 2</div>
		                            
		                             <img width="890px" height="1152px" class="loadImage" onload="loadImage()" src="http://drysign.global:80/img?fileid=689&filename=2OfferLetterHourlyTemplatewithDSlanguage_2015Updated (1).pdf&page=2">
		                            <div class="page-number">Page 3</div>
		                            
		                             <img width="890px" height="1152px" class="loadImage" onload="loadImage()" src="http://drysign.global:80/img?fileid=689&filename=2OfferLetterHourlyTemplatewithDSlanguage_2015Updated (1).pdf&page=2">
		                            <div class="page-number">Page 4</div> -->
		                            
		                            <%-- <img width="890px" height="1152px" src="<%=appUrl %>/images/PDF_view.jpg">
		                            <div class="page-number">3</div> --%>
		                        </div>
	                      </div>
	                      </div>
						   <%-- <div class="pdf-inner mCustomScrollbar">
						  	  <img src="<%=appUrl %>/images/PDF_view.jpg"/>
								 <div class="drop-select">
									<a class="btn btn-default btn-select">
                						<input type="hidden" class="btn-select-input" id="" name="" value="" />
                						<span class="btn-select-value">Select an Item</span>
                					<span class="btn-select-arrow fa fa-angle-down"></span>
                						<ul>
						                    <li>Option 1</li>
						                    <li class="selected">Option 2</li>
						                    <li>Option 3</li>
						                    <li>Option 4</li>
						                </ul>
            						</a>
								</div>
					    		<button type="button" class="btn btn-light-Bermuda signature-tab"><span class="icon-menu pull-left"></span>SIGNATURE<span class="icon-menu pull-right"></span></button>
					  		 </div> --%>
						  </div>
					  </div>
                 	   <ul class="list-inline text-right">                     
                    	  <li>
                        	<button type="button" id="step3-button" onclick="jumpstep2(3)" class="btn btn-primary next-step" disabled>Save and Next</button>
                      	  </li>
                      </ul>
                  </div>
                  <div class="self-slide">  
                	 <div class="pollSlider">
                 		<div class="main-content">
                 			 <div class="header-text text-center">
						 		<i>Drag-Drop the fields on the PDF</i>
					 		</div>
							 <div class="text-center margTB20">
						 		<div id="signer-1" class="dragMe dragSigners btn btn-light-oragne margB20" data-signer-id="1" data-document-id="1">
                           		 <span class="icon-menu pull-left"></span>NAME<span class="icon-menu pull-right"></span>
                            </div>
                            
                            <div id="signer-2" class="btn btn-light-yellow margB20 dragMe dragSigners" data-signer-id="2" data-document-id="1">
                              <span class="icon-menu pull-left"></span>DATE<span class="icon-menu pull-right"></span>
                            </div>
                            
                            <div id="signer-3" class="btn btn-light-Bermuda margB20 dragMe dragSigners" data-signer-id="3" data-document-id="1">
                              <span class="icon-menu pull-left"></span>SIGNATURE<span class="icon-menu pull-right"></span>
                            </div>
                            
                             <div id="signer-4" class="btn btn-light-purple margB20 dragMe dragSigners" data-signer-id="4" data-document-id="1">
                              <span class="icon-menu pull-left"></span>TEXTBOX<span class="icon-menu pull-right"></span>
                            </div>
                            
                            <!--  <div id="signer-5" class="btn btn-light-blue margB20 dragMe dragSigners" data-signer-id="5" data-document-id="1">
                              <span class="icon-menu pull-left"></span>CHECKBOX<span class="icon-menu pull-right"></span>
                            </div> -->
                            
                            <div id="signer-6" class="btn btn-light-brown margB20 dragMe dragSigners" data-signer-id="6" data-document-id="1">
                              <span class="icon-menu pull-left"></span>INITIALS<span class="icon-menu pull-right"></span>
                            </div>
						 </div>
					 </div>
                 </div>
				<div id="pollSlider-button"><span class="icon-arrow_left"></span></div>
                </div>
				  </div>
                <!-- Buttons --> 
                
              </div>
            </section>
          </div>
        </div>
        
        
        
        <div class="tab-pane" role="tabpanel" id="step4">
          <div class="step4">
            <section>
            <form id="step3-form">
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <h3 class="head3_1">Step 4: Add a subject and message for the recipient(s)</h3>
                      </div>
                    </div>
                    <div class="row ">
						<div class="col-md-4 col-sm-4 col-xs-12">
						<div class="input-field">
     						<input id="from" type="text" class="validate" value="<%=registration.getEmail()%>" readonly>
							<label for="last_name">From Email Address<span class="redstar">*</span></label>
							</div>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-12">
						<div class="input-field">
     						<input id="cc" name="cc" type="text" class="validate">
							<label for="last_name">CC Email Address</label>
							</div>
						</div>
					  </div> 
                     <div class="row">
						  <div class="col-md-8 col-sm-8 col-xs-12">						  	
						  	<div class="input-field">
							 <input id="subject" name="subject" type="text" class="validate">
          						<label for="file_name">Subject<span class="redstar">*</span></label>
							</div>
						  </div>
					  </div>
                    <div class="row">
						  <div class="col-md-8 col-sm-8 col-xs-12">						  	
						  	<div class="input-field">
							 <textarea id="message" name="message" class="materialize-textarea"></textarea>
          						<label for="textarea1">Message<span class="redstar">*</span></label>
							</div>
						  </div>
					  </div>
                     <ul class="list-inline text-right">                     
                      <li>
                         <button type="button" class="btn btn-danger" style="background: #2c3d4f;border: 1px solid transparent;text-transform: UPPERCASE;" id="preview" value="Prepare Document">Preview</button>
                         <button id="send" type="button" onclick="saveGroupSign();" class="btn has-spinner btn-danger" style="background: #00bc9c;text-transform: UPPERCASE;border: 1px solid transparent;">Send</button>
                      </li>
                    </ul>
                  </div>
                
				  </div>
                <!-- Buttons --> 
                
              </div>
              </form>
            </section>
          </div>
        </div>
        <div class="clearfix"></div>
      </div>
    </div>
    </div>
    
  	<div class="Content-wh-module text-center" id="success-group-messgae" style="display:none">
   	
   	<img src="<%=appUrl %>/images/message-bg.png"/>		   	
	   <h4 class="message-text text-color-burmoda">Message sent successfully!</h4>
	   <p style="margin-top: 50px; font-size: 16px; width: 850px; max-width: 90%; margin: 0 auto">Message sent successfully to the assigned signees. You can now check the status in History > <a href="<%=appUrl %>/app/history/outforSignature"> Out for Signatures.</a>
				   and once all the signees are done with signing the document, it would be moved to History > <a href="<%=appUrl %>/app/history/completedDocuments">Completed Documents.</a>You will be notified in your mailbox once all the signees are done signing.
		</p>
		<a style="margin-top: 50px;" type="submit" value="GO to dashboard" href="<%=appUrl %>/app/dashboard" class="btn btn-primary font-24">Go To Dashboard</a>
   </div>   
   
	  </div>
 <!-- /.content --> 
  </div>
<jsp:include page="footer.jsp"></jsp:include>
<input type="hidden" id="docId" value=""/>
<input type="hidden" id="draftId" value=""/>
<input type="hidden" id="stepNumber" value=""/>
 <!--  Signatucher Tab -->
<input type="hidden" id="drawsignature_no" value=""/>
 <div class="signature-sign">
	 <div class="header">	 	
		 <a class="close" href="#"><span class="icon-close"></span></a>
	 </div>
	 
	
		<ul class="nav nav-tabs self-sign">
			<li class="active">
       		 <a  href="#type" data-toggle="tab">TYPE</a>
			</li>
			<li><a href="#draw" data-toggle="tab">DRAW</a>
			</li>
			<li><a href="#saved" data-toggle="tab">SAVED</a>
			</li>
		</ul>

			<div class="tab-content self_sing_tab ">
			  <div class="tab-pane active" id="type">
				  <div class="row">
						<div class="col-md-6 col-sm-6 col-xs-12">
						<div class="input-field">
     	<input id="" type="text" class="validate">
							<label for="last_name">Your Name</label>
							</div>
							
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="input-field">
							 <input id="" type="text" class="validate">
          <label for="file_name">File Name</label>
							</div>
						</div>
						
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="input-field">							
								<select>
								  <option value="" disabled selected>Signerica Medium Regular</option>
								  <option value="1">Signerica Medium Regular</option>
								  <option value="2">Signerica Medium Regular</option>
								  <option value="3">Signerica Medium Regular</option>
								</select>
								<label>Font Type</label>
							</div>
						</div>
				  </div>
				  
				  <div class="row">
					  <div class="col-xs-12 text-right">
						  <a class="text-red" href="#">Reset</a>
						   <a class="text-green" href="#">Save</a>
					  </div>
				  </div>
				  
				  <div class="row margTB20">
					  <div class="col-xs-12">
					  	<div class="pdf_view">
					  <br>
				    <br>
				    <br>
				    <br><br>
				    <br><br>
				    <br><br> 
					
					  </div>
					  </div>
				  </div>
				</div>
				<div class="tab-pane" id="draw">
          
         
				  <div class="row margTB20 tab-pen-eraser">
					  <div class="colmd-12">
						  <button type="submit" class="btn btn-blank-defulte active_btn"  style="min-width: 110px;" value="">PEN</button>
						   <button type="submit" class="btn btn-blank-defulte"  style="min-width: 110px;" value="">ERASER</button>
					  </div>
				  	
				  </div>
				  <div class="row margB20">
						<div class="col-md-6 col-sm-6 col-xs-12">
							<select>
								  <option value="" disabled selected>Round 1</option>
								  <option value="1">Round</option>
								</select>
								<label>Shape</label>
					
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<select>
								  <option value="" disabled selected>2</option>
								  <option value="1">3</option>
								  <option value="2">4</option>
								  <option value="3">5</option>
								</select>
								<label>Size</label>
						</div>
						
						<div class="col-md-6 col-sm-6 col-xs-12">
								<div class="input-field">
     				<input id="" type="text" class="validate">
							<label for="last_name">Full Name</label>
							</div>
						</div>
				  </div>
				  
				  <div class="row margB20">
					  <div class="col-xs-12 text-right">
						  <a class="text-red" href="#">Reset</a>
						   <a class="text-green" href="#">Save</a>
					  </div>
				  </div>
				  
				  <div class="row margTB20">
					  <div class="col-xs-12">
					  	<div class="pdf_view">
					  <br>
				    <br>
				    <br>
				    <br><br>
				    <br><br>
				    <br><br> 
					
					  </div>
					  </div>
				  </div>
			
          
          
				</div>
        <div class="tab-pane" id="saved">
			<div class="row margTB20">
				
				<div class="col-md-4">
					<div class="save-signature-box selected">
					<a href="#">
						<img src="<%=appUrl %>/images/signature.jpg" class="responsive-img"/>
						<div class="bottom-box">
								<span>Official Signature_01</span>
						</div>
						</a>
					</div>
					
				</div>
				<div class="col-md-4">
					<div class="save-signature-box">
					<a href="#">
						<img src="<%=appUrl %>/images/signature.jpg" class="responsive-img"/>
						<div class="bottom-box">
								<span>Official Signature_01</span>
						</div>
						</a>
					</div>
				</div>
				<div class="col-md-4">
					<div class="save-signature-box">
					<a href="#">
						<img src="<%=appUrl %>/images/signature.jpg" class="responsive-img"/>
						<div class="bottom-box">
								<span>Official Signature_01</span>
						</div>
						</a>
					</div>
				</div><div class="col-md-4">
					<div class="save-signature-box">
					<a href="#">
						<img src="<%=appUrl %>/images/signature.jpg" class="responsive-img"/>
						<div class="bottom-box">
								<span>Official Signature_01</span>
						</div>
						</a>
					</div>
				</div><div class="col-md-4">
					<div class="save-signature-box">
					<a href="#">
						<img src="<%=appUrl %>/images/signature.jpg" class="responsive-img"/>
						<div class="bottom-box">
							<span>Official Signature_01</span>
						</div>
						</a>
					</div>
				</div>
				
			</div>
				</div>
			</div>

 	
 	
 	
	
 	
 </div>
  <div class="Message" id="skippopup">	
   	
	  <div>
	  	<a class="close" href="#"><span class="icon-close"></span></a>
	  </div>
		 <div class="header text-center margTB20 paddLR10">		 	
		 	Do you really want to skip and send later?
					Document would be saved in History > Complete Documents 
					for you to view and send email later.
		 </div>	
	  <div class="text-right">	  
						  <a class="text-red"  style="color: #252f3a" href="#">DECLINE</a>
						   <a class="text-green" onclick="saveSelfsign('skipandsend')" href="#">ACCEPT</a>					
	  </div> 	
 </div>
 
 <div class="Message" id="deleteDocument">	
   	
	  <div>
	  	<a class="close" href="#"><span class="icon-close"></span></a>
	  </div>
		 <div class="header text-center margTB20 paddLR10">		 	
		 	Do you really want to delete document?
		 </div>	
	  <div class="text-center">	  
		<button type="button" class="btn btn-primary" onclick="deleteDocumentPopUp();" >YES</button>
		<button type="button" class="btn btn-danger" style="background: #2c3d4f;border: 1px solid transparent;" onclick="hiderDocumentPopUp();" >NO</button>
	  </div> 	
 </div>
 <div id="myModal" class="modal fade in" role="dialog" style="display:none;">
    <div class="modal-dialog" style=""> 
      
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" onclick="closeSummary();">&times;</button>
          
          <h5 class="modal-title">Preview</h5>
        </div>
        <div class="modal-body">
          <div class="container-fluid">
            <div class="row">
              <div class="col-xs-12">
                <div class="para4">Step 1 - Group Sign:  </div>
              </div>
              <div class="col-xs-12">              	
                
                <table cellpadding="0" cellspacing="0" width="100%;" class=" table table-bordered">
                <tr>
                	
                    <td><strong>Document Name</strong></td>
                    <td id="summaryDocName"></td>
               </tr>
              <tr>
                	
                    <td>R<strong>equested by</strong></td>
                    <td><% if (registration != null) { %>
					 		<%=registration.getFirstName()%> <%=registration.getLastname()%> 
						   <% } %> </td>
                    </tr>
                </table>
               
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12">
                <div class="para4">Step 2  - Signers </div>
              </div>
             <div class="col-xs-12">              	
               <table id="summarySignerList" cellpadding="0" cellspacing="0" width="100%;" class=" table table-bordered">
                <thead>
                <tr>
	                <th id="priorityHeaderSummary">Priority</th>
	                <th>Name</th>
	                <th>Email ID</th>
                </tr>
                </thead>
                <tbody id="showSummarySignerList">
                <!-- <tr>
                	<td>1</td>
                    <td>snaket navale</td>
                    <td>Sanketnavale@gmail.com</td>
                </tr>
             	<tr>
                    <td>2</td>
                    <td>snaket navale</td>
                    <td>Sanketnavale@gmail.com</td>
                    </tr>
                <tr>
                    <td>3</td>
                    <td>snaket navale</td>
                    <td>Sanketnavale@gmail.com</td>
                 </tr> -->
                 </tbody>
                </table>
                
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12">
                <div class="para4">Step 3 -Subject and message for the recipient(s) </div>
              </div>
             <div class="col-xs-12">              	
               
                <table cellpadding="0" cellspacing="0" width="100%;" class=" table table-bordered">
                <tr>
                	
                    <td><strong>Subject</strong></td>
                    <td id="preview_subject"> Text</td>
               </tr>
              <tr>
                	
                    <td><strong>Message</strong></td>
                    <td id="preview_message">Test</td>
                    </tr>
                </table>
               
              </div>
            </div>
            
          </div>
        </div>
        <!-- <div class="modal-footer text-center">
          <button type="button" class="btn btn-primary" data-dismiss="modal">Done</button>
        </div> -->
         <div class="text-right">	  
			<a class="btn btn-red"  onclick="closeSummary();" href="#">CANCEL</a>
			<a class="btn btn-green" onclick="closeSummary();"href="#">CONFIRM</a>					
	  </div> 
      </div>
    </div>
  </div>

<div class="overlay-bg"></div>

<!-- Draw Signature -->
  <div class="signature-sign">
	 <div class="header">	 	
		 <a class="close" href="#"><span class="icon-close"></span></a>
	 </div>
	 <ul class="nav nav-tabs self-sign">
			<li class="active"><a href="#draw" data-toggle="tab">DRAW</a>
			</li>
			<li >
       		 <a  href="#type" data-toggle="tab">TYPE</a>
			</li>
			
	</ul>
	<div class="tab-content self_sing_tab ">
			<div class="tab-pane active" id="draw">
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
					</div>
				</div>
			  <div class="tab-pane" id="type">
				  <div class="row">
						<div class="col-md-6 col-sm-6 col-xs-12">
						<div class="input-field">
							<input id="" type="text" class="validate">
							<label for="last_name">Your Name</label>
						</div>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="input-field">
							 <input id="" type="text" class="validate">
								<label for="file_name">File Name</label>
							</div>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
					</div>
				  </div>
				  <div class="row">
					  <div class="col-xs-12 text-right">
						  <a class="text-red" href="#">Reset</a>
						   <a class="text-green" href="#">Save</a>
					  </div>
				  </div>
				  <div class="row margTB20">
					  <div class="col-xs-12">
					  	<div class="pdf_view">
					  <br>
				    <br>
				    <br>
				    <br><br>
				    <br><br>
				    <br><br> 
					</div>
					  </div>
				  </div>
				</div>	
	</div>
</div>

 <div class="overlay-bg"></div>
<div class="overlaywhite_bg"></div>
<input type="hidden" id="generator" value="1" />
<input type="hidden" id="fieldshtml" value="" />
<input type="hidden" id="flag" value=""/>
<input type="hidden" id="setpriority" value="0"/>
<input type="hidden" id="signature" value="${signature}"/>
<input type="hidden" id="dragList" value=""/>
<input type="hidden" id="signer_list" value=""/>
<input type="hidden" id="viewpagecount" value="0"/>
<input type="hidden" id="draganddropList" value=""/>
<input type="hidden" id="enableButton" value=""/>
<input type="hidden" id="pageHeight" value="0"/>
<input type="hidden" id="numpages" value="0"/>

<script type="text/javascript" language="javascript" src="<%=appUrl %>/js/jquery.mCustomScrollbar.js"></script>
<script src="<%=appUrl %>/js/file_upload.js"></script>
<script src="<%=appUrl %>/js/materialize.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.10.4/typeahead.bundle.min.js"></script>
<script src="<%=appUrl %>/js/materialize-tags.min.js"></script>
<script src="<%=appUrl %>/js/jquery.validate.js"></script>
<!-- ./wrapper --> 


<script>
function loadImage() {
	$("#loader1").fadeOut("slow");
	//$(".loadImage").show();
}

(function($){
	  $(window).on("load",function(){
	$(".content").mCustomScrollbar({
				axis:"xy",

				advanced:{
					autoExpandHorizontalScroll:true
				}
			});
       });
})(jQuery);	

$(window).on("load resize", function() {
 var viewportWidth = $(window).width();
    if (viewportWidth < 768) {
          (function($) {
            $(document).ready(function() {
				//alert('hi');
              $( ".m-view" ).prependTo( ".dropdown-menu li.bottom" );
 $( ".m-view.user" ).prependTo( ".dropdown-menu" );  
            });
         }) (jQuery);
    }
});	
</script>
<script>
	$(document).ready(function () {
		
		$("#myModal").hide();
		$(".loadImage").hide();
	    $("#show-selfsign-success").hide();
			
	   	var docName='${documentName}';
	   	var docId='${docId}';
	   	var draftId='${draftId}';
	   	var dragList='${dragList}';
	   //	alert(dragList);
	   	var flag ='${flag}';
	   	var stepNumber='${stepNumber}';
	   	var increment=1;
		//alert(increment);
	   	if(docName != ''){
	   		$("#docId").val(docId);
	   		$("#draftId").val(draftId);
	   		$("#flag").val(flag);
	   		if(increment !='' ){
	   			$("#generator").val(increment);
	   		}
	   		$(".file-upload-input").val(docName);
	   		if(dragList !=''){
	   			$("#document-reader").append(dragList);
	   		}
		   	$(".icon-upload").hide();
			$("#remove-icon").append('<i class="fa fa-times" aria-hidden="true" onclick="deleteDocument();" style="margin-left: 80px;"></i>');
			$(".progress-bar").css("width", "100%");
			$("#jumpstep2").removeAttr('disabled');
			$("#draganddropList").val(dragList);
			getSignerList();
	   	}
		if(stepNumber == 1){
			$("#steplist1").removeClass('disabled');
	   	    $("#steplist1").addClass('active');
	   	    $("#step1").removeClass('disabled');
	   	    $("#step1").addClass('active');
	   	    
	   	}
		else if(stepNumber == 2){
	   		$("#steplist2").removeClass('disabled');
	   	    $("#steplist2").addClass('active');
	   	    $("#step2").removeClass('disabled');
	   	    $("#step2").addClass('active');
	   	 	
	   	 	
	   	}
		else if(stepNumber == 3){
			$("#steplist3").removeClass('disabled');
	   	    $("#steplist3").addClass('active');
	   	    $("#step3").removeClass('disabled');
	   	    $("#step3").addClass('active');
	     	var count=$("#viewpagecount").val();
	   	    jumpstep3(count);
	   	 	signerEmailList();
	   	    
	   	}else if(stepNumber == 4){
			$("#steplist4").removeClass('disabled');
	   	    $("#steplist4").addClass('active');
	   	    $("#step4").removeClass('disabled');
	   	    $("#step4").addClass('active');
	   	}else{
	   		$("#steplist1").removeClass('disabled');
	   	    $("#steplist1").addClass('active');
	   	    $("#step1").removeClass('disabled');
	   	    $("#step1").addClass('active');
	   	}	
	
	$('.tab-pen-eraser button').click(function(){
		$(this).addClass('active_btn').siblings().removeClass('active_btn');
	});	
    $(".btn-select").each(function (e) {
        var value = $(this).find("ul li.selected").html();
        if (value != undefined) {
            $(this).find(".btn-select-input").val(value);
            $(this).find(".btn-select-value").html(value);
        }
    });
});

//dropdown drag fields
$(document).on('click', '.btn-select', function (e) {
    e.preventDefault();
    var ul = $(this).find("ul");
    if ($(this).hasClass("active")) {
        if (ul.find("li").is(e.target)) {
            var target = $(e.target);
            var signerEmail=e.target.id;
            var signerPriority=$(e.target).attr('data-name');
           // var priority=e.target.data-priority-id;
           // alert(signerEmail);
            //alert(signerPriority);
            //alert(target.html());
            target.addClass("selected").siblings().removeClass("selected");
            var value = target.html();
            
          	$(this).find(".btn-select-priority").val(signerPriority);
            $(this).find(".btn-select-email").val(signerEmail);
            $(this).find(".btn-select-input").val(value);
            $(this).find(".btn-select-value").html(value);
            
            signerEmailList();
            
        }
        ul.hide();
        $(this).removeClass("active");
    }
    else {
        $('.btn-select').not(this).each(function () {
            $(this).removeClass("active").find("ul").hide();
        });
        ul.slideDown(300);
        $(this).addClass("active");
    }
    jumpstep2(3);
});

$(document).on('click', function (e) {
    var target = $(e.target).closest(".btn-select");
    if (!target.length) {
        $(".btn-select").removeClass("active").find("ul").hide();
    }
});

function signerEmailList(){
	
	var generatorLength=$("#generator").val();
	var array1 = [];
	for(var i=0; i<generatorLength ; i++) {
		var fieldType=$("#field"+i).attr("data-signer");
		if(fieldType !=null && fieldType !=undefined){
			array1[i]=$("#fieldemailvalue"+i).val();   
		}
	}
	//alert("array1 "+array1);
	var array2 = [];
	var total_row=$("#total-row").val()
	for (var i = 0; i <= total_row; i++) {
		var signeremail=$("#signeremail"+i).val();
		if(signeremail  != undefined && signeremail !=""){
       	
       	array2[i]=signeremail;   
		}
	}
	//alert("array2 "+array2);
	var foo = [];

	$.grep(array2, function(el) {

		if ($.inArray(el, array1) != -1) {
			foo.push(el);
		}

	});
	
	//alert("FOO" + foo);
	var a1=foo.sort();
	var a2=array2.sort();
	var is_same = a1.length == a2.length && a1.every(function(element, index) {
	    return element === a2[index]; 
	});
	var checkButton=false;
	if(is_same == false){
		checkButton=false;
	}else{
		checkButton=checkArray(array1);	
	}
	//alert(checkButton);
	if(checkButton ==true){
		$("#step3-button").removeAttr('disabled');
	}else{
		 $("#step3-button").attr('disabled','disabled');
	}
	
	/* for (var i = 0; i <array1.length; i++) {
		/* if(array1[i] == ""){
			 $("#step3-button").attr('disabled','disabled');
		// alert("EMPTY ARRAY")	
		}if(array1[i] != ""){
		 //alert("NOT EMPTY ARRAY")
			if(is_same == 'true' || is_same== true){
				$("#step3-button").removeAttr('disabled');
			}else{
				$("#step3-button").attr('disabled','disabled');
			}
		} 
		
		if(array1[i] === "")   
	      return false;
		
		
	}  */
	
	
}
function checkArray(my_arr){
	   for(var i=0;i<my_arr.length;i++){
	       if(my_arr[i] === "")   
	          return false;
	   }
	   return true;
	}
/* function signerEmailList(){
	var jsonArray = [];
	var generatorLength=$("#generator").val();
	for(var i=0; i<generatorLength; i++) {
		var item = {};
		var fieldType=$("#field"+i).attr("data-signer");
		if(fieldType !=null && fieldType !=undefined){
			if(fieldType == "name"){
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['signerEmail'] = $("#fieldemailvalue"+i).val();
			}else if(fieldType == "date"){
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['signerEmail'] = $("#fieldemailvalue"+i).val();		
			}else if(fieldType == "signature"){
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['signerEmail'] = $("#fieldemailvalue"+i).val();
			}else if(fieldType == "textbox"){
				item ['fieldName'] = $("#field"+i).attr("data-signer");
				item ['priority'] = $("#fieldpriorityvalue"+i).val();
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['signerEmail'] = $("#fieldemailvalue"+i).val();
			}else if(fieldType == "checkbox"){
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['signerEmail'] = $("#fieldemailvalue"+i).val();
			}else if(fieldType == "initials"){
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['signerEmail'] = $("#fieldemailvalue"+i).val();
			}
			//alert('Signer Name'+item ['signerName'] +' Signer Email ' +item ['signerEmail'] );
			jsonArray.push(item);
		}
	}
	var total_row=$("#total-row").val()
	var jsonSignerArray = [];
        for (var i = 0; i <= total_row; i++) {
        	var item = {};
        	var signername=$("#signername"+i).val();
        	var signeremail=$("#signeremail"+i).val();
        	if(signername  != undefined && signername !="" && signeremail  != undefined && signeremail !=""){
        		item ['name'] = signername;
				item ['email'] =signeremail;
				jsonSignerArray.push(item);
        	}
     }
	$.each(jsonArray, function(key, value) {
		  if(value.signerName !='' || value.signerEmail != ''){
			 $.each(jsonSignerArray, function(key1, value1) {
					if(value1.email != value.signerEmail ){
						$("#step3-button").attr('disabled','disabled');
					}else{
						$("#step3-button").removeAttr('disabled');
					} 
				})
		 }else if(value.signerName =='' || value.signerEmail == ''){
			 $("#step3-button").attr('disabled','disabled');
		 }else{
			 $("#step3-button").removeAttr('disabled');
		 }
	});
	
     var check=getDifferences(jsonSignerArray,signerEmailList);
}
*/

</script>
<script type="text/javascript">
$(document).ready(function(){
	Materialize.updateTextFields();
		   $('select').material_select();
	
	  $('button.signature-tab').click(function() {
			//$('.wrapper').addClass('overlay-bg')
			$('.overlay-bg').show();
             $('.signature-sign').show();
						var $slider = $('.signature-sign');
						$slider.animate({
						 right: parseInt($slider.css('right'),10) == -350 ? 0 : 0
						});
			});
	$('.close, .overlay-bg').click(function(){
		$('.signature-sign').hide();
		$('.overlay-bg').hide();
	});
	
  $('#pollSlider-button').click(function() {
	   $('#pollSlider-button span').toggleClass("icon-arrow_left icon-arrow_right");
	  //$(this).find($("span")).removeClass('icon-arrow_left').addClass('icon-arrow_right');
	  
	  $('.main-content').css('display','block');
    if($(this).css("margin-right") == "200px")
    {
        $('.pollSlider').animate({"margin-right": '-=200'});
        $('#pollSlider-button').animate({"margin-right": '-=200'});
		$('.main-content').css('display','none');
    }
    else
    {
        $('.pollSlider').animate({"margin-right": '+=200'});
        $('#pollSlider-button').animate({"margin-right": '+=200'});
		$('.main-content').css('display','block');
    }


  });
 }); 	
</script> 
<script type="text/javascript">
     function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('.blah')
                        .attr('src', e.target.result);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
</script> 
<script>
	  $(document).ready(function () {
    //Initialize tooltips
    $('.nav-tabs > li a[title]').tooltip();
    $('[data-toggle="tooltip"]').tooltip(); 
    
    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
        var $target = $(e.target);    
        if(e.currentTarget.hash =="#step1"){
			//alert('Step1');	
	    }if(e.currentTarget.hash =="#step2"){
	    	//alert('Step2');
	    	jumpstep2(2);
	    	
	    	
		}if(e.currentTarget.hash =="#step3"){
			var count=$("#viewpagecount").val();
			jumpstep3(count);
			signerEmailList();
			//jumpstep2(3)
			//jumpstep2(3);
		}if(e.currentTarget.hash =="#step4"){
			//alert('Step3');
			//jumpstep3(3);
		}
		
        if ($target.parent().hasClass('disabled')) {
            return false;
        } 
    });

    $(".next-step").click(function (e) {
        var $active = $('.wizard .nav-tabs li.active');
        $active.next().removeClass('disabled');
        nextTab($active);
    });
    $(".prev-step").click(function (e) {
        var $active = $('.wizard .nav-tabs li.active');
        prevTab($active);
    });
});

function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
    $(elem).prev().find('a[data-toggle="tab"]').click();
}
	$('#example').DataTable( {});
	  
	  $('.square_2').on('click', function(){
    $('.square_2.active').removeClass('active');
    $(this).addClass('active');
	
	$('.row_4').show('.square_2.active#test12');
	//$('.row_4').hide('.square_2 #test12');
	  });
  </script> 
  
  <!-- MOBLE SUPPORT HERE -->

<script src="<%=appUrl %>/js/jquery-ui.min.js"></script>
<script src="<%=appUrl %>/js/jquery.ui.touch-punch.min.js"></script>
<script>$('#widget').draggable();</script>
<script>
function touchHandler(event) {
    var touch = event.changedTouches[0];

    var simulatedEvent = document.createEvent("MouseEvent");
        simulatedEvent.initMouseEvent({
        touchstart: "mousedown",
        touchmove: "mousemove",
        touchend: "mouseup"
    }[event.type], true, true, window, 1,
        touch.screenX, touch.screenY,
        touch.clientX, touch.clientY, false,
        false, false, false, 0, null);

    touch.target.dispatchEvent(simulatedEvent);
    event.preventDefault();
}

function init() {
    document.addEventListener("touchstart", touchHandler, true);
    document.addEventListener("touchmove", touchHandler, true);
    document.addEventListener("touchend", touchHandler, true);
    document.addEventListener("touchcancel", touchHandler, true);
}


/* jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();

jQuery.curCSS = function(element, prop, val) {
    return jQuery(element).css(prop, val);
}; */
</script>

<!-- Re sizable -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

/* $('input.expandeble').css('width',((input.getAttribute('placeholder').length + 1) * 8) + 'px'); */

$( function() {
  $( ".resizable" ).resizable({
    handles: "se"
  });
} );
</script>

<script src="<%=appUrl %>/js/signature.js"></script>
<!-- Loader -->
<script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
<script>
zkSignature.capture();

$('.close').click(function(){
	//$('.save-signature-box').hide();
	$(".signature-sign").hide();
	$('.overlay-bg').hide();
	 //return false;
}); 

//Draw Signature
function openMySignature(id){
	$('.overlay-bg').show();
	$('.signature-sign').show();
		var $slider = $('.signature-sign');
		$slider.animate({
		 right: parseInt($slider.css('right'),10) == -350 ? 0 : 0
	});
		
	$("#drawsignature_no").val(id);	
		
}
$("#saveSignature").click(function(){
	var id=$("#drawsignature_no").val();
	$(".signature-sign").hide();
	$('.overlay-bg').hide();
	var canvas = document.getElementById("newSignature");
	// save canvas image as data url (png format by default)
	var dataURL = canvas.toDataURL("image/png");
	
	 $("#field"+id).attr('type', 'image'); 
	 $("#field"+id).attr('src', dataURL);
	 $("#field"+id).removeClass('form-control');
	 //$("#fieldclose"+id).css("right", "6px");
	//$("#fiel1d"+id).val(dataURL);
});

//End Draw Singature
</script>
<!-- DRAG AND DROP CODE HERE -->

<script>



  //remove the dragsigner when click on close icon
  $(document).on("click", ".closeIt", function(){
    var parent = $(this).parent();
    parent.remove();
  });

  function hideTextbox(id){
	  $("#drop-select" + id).remove();
	  // $("#field"+id).find("a.closeIt").removeClass("hideIt");
	  //jumpstep3(3);
	  //checkFields();
	  signerEmailList();
	  
  }

 
  function enlargeText(id,value){
	 // alert(value.length);
	  $(id).css('width',((value.length + 1) * 8) + 'px');
  }
  
 
</script>
<script src="<%=appUrl %>/js/jquery.ui.widget.js"></script>
<script src="<%=appUrl %>/js/jquery.iframe-transport.js"></script>
<script src="<%=appUrl %>/js/jquery.fileupload.js"></script>
<script src="<%=appUrl %>/js/jquery.fileupload-process.js"></script>
<script src="<%=appUrl %>/js/jquery.fileupload-validate.js"></script>
<script src="<%=appUrl %>/js/jquery.validate.js"></script>



 <script type="text/javascript" src="https://js.live.net/v7.2/OneDrive.js"></script>
 
 <script type="text/javascript">
  function launchOneDrivePicker(){
	  var odOptions = {
			  clientId: "0aa725db-3ba9-486d-8e42-a92554639a6d",
			  action: "download",
			  multiSelect: false,
			  linkType: "webViewLink",
			  advanced: {filter: ".pdf"},
			  success: function(response) { 
				  var downloadurl =  response.value[0]["@microsoft.graph.downloadUrl"];
				  var name = response.value[0]["name"];
				  console.log("done-->"+downloadurl);
				  console.log("done-->"+name);
				  $(".file-upload-input").val(name);
				  var str = name;
				  var res = str.slice(-3);
	                if(res=="pdf"){
				  saveonedriveChooserFile(downloadurl,name)
	                }
	                else{
	                	 $("#show_upload_error").html("only pdf files are accepted");
	                	 $("#dropbox").hide();
		            	  $("#pick").hide();
		            	  $("#onedrive").hide();
		            	  $("#egnyte").hide();
				            $(".icon-upload").hide();
							$("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument1();" style="margin-left: 80px;"></i>');
							 
	                }

			  },
			  cancel: function() { /* cancel handler */ },
			  error: function(e) { /* error handler */ }
			}
    OneDrive.open(odOptions);
  }
  
  
  function saveonedriveChooserFile(downloadedUrl,fileName) {
  	
  	var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		
		$.ajax({
			url: contextPath+"app/saveDropoxChooserFile?signtype=G",
			type: "POST",
			datatype:'json',
			Accept : "application/json",
		    contentType: "application/json",
			data: JSON.stringify({ "downloadedUrl":downloadedUrl , "fileName" :fileName }),
			beforeSend: function (xhr) {
	   			xhr.setRequestHeader(header, token);
	   		//	$("#jumpstep2").buttonLoader('start');
	   			$("#loader2").show();
		    },
		    complete: function () {
			    //	$("#jumpstep2").buttonLoader('stop');
			    	$("#loader2").hide();
			    },
			    
			 success:function(response){
		    	   if(response =="subscriptionend")
		            {
		            	$("#show_upload_error").html('');
		            	$("#show_upload_error").html("You dont have enough credit limit, Kindly subscribe DrySign subscription plan.");
		            		
		            }else if(response !="failed"){
		            	
		            	$.each( response, function( key, value ) {
		            		//alert(key +' '+value );
		            		if(key == 0){
		            			 $("#docId").val(value);
		            		}
		            		if(key == 1){
		           			 	 $("#draftId").val(value);
		           			}
		            	});
		            	 // alert(response)
		            	 $("#dropbox").hide();
		            	  $("#pick").hide();
		            	  $("#onedrive").hide();
                          $("#egnyte").hide();
		            	  $(".icon-upload").hide();
		            	 $("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument();" style="margin-left: 80px;"></i>');
					
		            	$("#jumpstep2").removeAttr('disabled');
		            }else{
		            	$("#show_upload_error").html('');
		            	$("#show_upload_error").html(response);
		            }
		    	
		    },
		    error: function(err){
		    	
		    }
		})
	}
</script>
 

 <script type="text/javascript" src="<%=appUrl %>/js/dropins.js" id="dropboxjs" data-app-key="kktaxdj1402ec7u"></script>
 
 
     <script>
     document.getElementById("dropbox").onclick = function () {
    	 Dropbox.choose({
            success: function(files) {
                var linkTag = document.getElementById('file-upload-input');
             //   linkTag.href = files[0].link;
              //  linkTag.textContent = files[0].link;
                var str = files[0].name;
                $(".file-upload-input").val(files[0].name);
                var res = str.slice(-3);
                if(res=="pdf"){
                saveDropoxChooserFile(files[0].link,files[0].name)
                }
                else{
                	 $("#show_upload_error").html("only pdf files are accepted");
                	 $("#dropbox").hide();
	            	  $("#pick").hide();
	            	  $("#onedrive").hide();
	            	  $("#egnyte").hide();
			            $(".icon-upload").hide();
						$("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument1();" style="margin-left: 80px;"></i>');
						 
                }
            },
            linkType: 'direct',
            multiselect: false,
            extensions: ['.pdf'],
        });
     };
      //  document.getElementById('container').appendChild(button);
        
        function saveDropoxChooserFile(downloadedUrl,fileName) {
        	
        	var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var contextPath=$("#contextPath").val();
			
    		$.ajax({
    			url: contextPath+"app/saveDropoxChooserFile?signtype=G",
    			type: "POST",
    			datatype:'json',
    			Accept : "application/json",
    		    contentType: "application/json",
    			data: JSON.stringify({ "downloadedUrl":downloadedUrl , "fileName" :fileName }),
    			beforeSend: function (xhr) {
		   			xhr.setRequestHeader(header, token);
		   		//	$("#jumpstep2").buttonLoader('start');
		   			$("#loader2").show();
			    },
			    complete: function () {
				    //	$("#jumpstep2").buttonLoader('stop');
				    	$("#loader2").hide();
				    },
				    
				 success:function(response){
			    	   if(response =="subscriptionend")
			            {
			            	$("#show_upload_error").html('');
			            	$("#show_upload_error").html("You dont have enough credit limit, Kindly subscribe DrySign subscription plan.");
			            		
			            }else if(response !="failed"){
			            	
			            	$.each( response, function( key, value ) {
			            		//alert(key +' '+value );
			            		if(key == 0){
			            			 $("#docId").val(value);
			            		}
			            		if(key == 1){
			           			 	 $("#draftId").val(value);
			           			}
			            	});
			            	 // alert(response)
			            	 $("#dropbox").hide();
			            	  $("#pick").hide();
			            	  $("#onedrive").hide();
                              $("#egnyte").hide();
			            	  $(".icon-upload").hide();
			            	 $("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument();" style="margin-left: 80px;"></i>');
						
			            	$("#jumpstep2").removeAttr('disabled');
			            }else{
			            	$("#show_upload_error").html('');
			            	$("#show_upload_error").html(response);
			            }
			    	  
			    },
    		    error: function(err){
    		    	
    		    }
    		})
    	}
        
        
/* start Egnyte javascript code */   
        
        function popitupEgnyte(url) {
            var w=500;
            var h=500;
        var left = (screen.width/2)-(w/2);
        var top = (screen.height/2)-(h/2);
        var title = "Egnyte";
        return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
            
                 /* newwindow=window.open(url,'name','height=400,width=500');
                 if (window.focus) {newwindow.focus()}
                 return false; */
             }
             
         function HandlePopupResult(base64,fileName) {
             /* var div = document.getElementById('output');
            div.innerHTML += result;
            var div = document.getElementById('name');
            div.innerHTML += name; */
            $(".file-upload-input").val(fileName);
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            var contextPath=$("#contextPath").val();
            
            $.ajax({
                  url: contextPath+"app/saveFileByEgnyte?signtype=S",
                  type: "POST",
                  datatype:'json',
                  Accept : "application/json",
                contentType: "application/json",
                  data: JSON.stringify({ "downloadedUrl":base64 , "fileName" :fileName }),
                  beforeSend: function (xhr) {
                       xhr.setRequestHeader(header, token);
                 //    $("#jumpstep2").buttonLoader('start');
                       $("#loader2").show();
                },
                complete: function () {
                      //      $("#jumpstep2").buttonLoader('stop');
                       $("#loader2").hide();
                      },
                      
                   success:function(response){
                     if(response =="subscriptionend")
                        {
                              $("#show_upload_error").html('');
                              $("#show_upload_error").html("You dont have enough credit limit, Kindly subscribe DrySign subscription plan.");
                                    
                        }else if(response !="failed"){
                              
                              $.each( response, function( key, value ) {
                                    //alert(key +' '+value );
                                    if(key == 0){
                                           $("#docId").val(value);
                                    }
                                    if(key == 1){
                                           $("#draftId").val(value);
                                    }
                              });
                               // alert(response)
                               $("#dropbox").hide();
                                $("#pick").hide(); 
                                $("#onedrive").hide();
                                $("#egnyte").hide();
                                
                                
                                $(".icon-upload").hide();
                               $("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument();" style="margin-left: 80px;"></i>');
                              
                              $("#jumpstep2").removeAttr('disabled');
                        }else{
                              $("#show_upload_error").html('');
                              $("#show_upload_error").html(response);
                        }
                  
                },
                error: function(err){
                  
                }
            })
            
            
         }   
         /* end Egnyte javascript code */   


    </script>
  <script type="text/javascript" src="<%=appUrl %>/js/filepicker.js"></script>
	<script>
	 var file = null;
		function initPicker() {
			var picker = new FilePicker({
				apiKey: 'AIzaSyBOIfItfyHfT9DM2vYIPN_XwuD8B2HhLyc',
				clientId:'927346535684-gkrnjl6o6akimdjse81gp3lb1j79n957.apps.googleusercontent.com',
				buttonEl: document.getElementById('pick'),
				onSelect: function(file) {
					
					$("#filename").val(file.title);
					$(".file-upload-input").val(file.title);
					$("#fileId").val(file.id);
					console.log(file);
					document.getElementById("save").click();
					//alert('Selected File ' + file.title);
					//alert('Selected file Id ' + file.id);
				}
			});	
		}
		
		function download() {
			var fileId = $("#fileId").val();
			var fileName = $("#filename").val();
			var byteArray = [];
			if (fileId) {
				console.log("fileId: ::" + fileId);
				var accessToken = gapi.auth.getToken().access_token;
				callToajax(fileId,"",fileName,accessToken);
			/* 	var xhr = new XMLHttpRequest();
				xhr.open('GET', filedownloadUrl);
				xhr.setRequestHeader('Authorization', 'Bearer ' + accessToken);
				xhr.onload = function() {
				var fileContent = xhr.responseText;
				var contentType= xhr.getResponseHeader ("Content-Type");
				 var contLength = xhr.getResponseHeader ("Content-Length");
				 var encodedfileContent = Base64.encode(fileContent);
				alert(fileContent);
				callToajax(filedId,contentType,fileName,accessToken);
			//	do_something_with_file_content(file.title, content);
				};
				xhr.onerror = function() {
				alert('Download failure.');
				};
				xhr.send(); */
				}
		  
				else {
				alert('Unable to download file.');
				}
			  
			}
		function callToajax(fileId,contentType,fileName,accessToken) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var contextPath=$("#contextPath").val();
			//alert("Hai");
			$.ajax({
				url: contextPath+"cloud/downloadFieByFileId?signtype=G",
				type: "POST",
				dataType: 'json',
			    contentType: "application/json; charset=utf-8",
			    data: JSON.stringify({ "fileId":fileId , "fileMimeType": contentType , "fileName" :fileName ,"accessToken":accessToken}),
			    beforeSend: function (xhr) {
		   			xhr.setRequestHeader(header, token);
		   			$("#loader2").show();
			    },
			    complete: function () {
			    //	$("#jumpstep2").buttonLoader('stop');
			    	$("#loader2").hide();
			    },
			    
			    success:function(response){
			    	   if(response =="subscriptionend")
			            {
			            	$("#show_upload_error").html('');
			            	$("#show_upload_error").html("You dont have enough credit limit, Kindly subscribe DrySign subscription plan.");
			            		
			            }else if(response !="failed"){
			            	
			            	$.each( response, function( key, value ) {
			            		//alert(key +' '+value );
			            		if(key == 0){
			            			 $("#docId").val(value);
			            		}
			            		if(key == 1){
			           			 	 $("#draftId").val(value);
			           			}
			            	});
			            	 // alert(response)
			            	 $("#pick").hide();
			            	 $("#dropbox").hide();
			            	 $("#onedrive").hide();
                             $("#egnyte").hide();
			            	  $(".icon-upload").hide();
			            	 $("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument();" style="margin-left: 80px;"></i>');
						
			            	$("#jumpstep2").removeAttr('disabled');
			            }else{
			            	$("#show_upload_error").html('');
			            	$("#show_upload_error").html(response);
			            }
			    },
			    error: function(err){
			    	
			    }
			})
		}
	
	</script>
	
	<script src="https://www.google.com/jsapi?key=AIzaSyC4z1UzNEEZXpOGf547C0XifZ0HagRx64w"></script>
	<script src="https://apis.google.com/js/client.js?onload=initPicker"></script>
<script>
/*global window, $ */
$(function () {
    'use strict';
    // Change this to the location of your server-side upload handler:
    var contextPath=$("#contextPath").val();
    var url = "app/fileUpload?signtype=G";
    var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
    $('#fileupload').fileupload({
        url: contextPath+url,
        type : 'POST',
        dataType: 'json',
        autoUpload: false,
        disableImageResize: /Android(?!.*Chrome)|Opera/
            .test(window.navigator.userAgent),
        previewMaxWidth: 100,
        previewMaxHeight: 100,
        previewCrop: true,
    	beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		add: function(e, data) {
	        var uploadErrors = [];
			        var acceptFileTypes = /^application\/(pdf)$/i;
			        if(data.originalFiles[0]['type'].length == 0){
			        	 uploadErrors.push('Only pdf file accepted');
			        }
			        if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
			            uploadErrors.push('Only pdf file accepted');
			        }
			        if(data.originalFiles[0]['size'].length && data.originalFiles[0]['size'] > 5000000) {
			            uploadErrors.push('Max file 100 mb');
			        }
			        if(uploadErrors.length > 0) {
			        	$("#show_upload_error").html('');
			            $("#show_upload_error").html(uploadErrors.join("\n"))
			            
			            $(".icon-upload").hide();
			            $("#pick").hide();
		            	 $("#dropbox").hide();
		            	 $("#onedrive").hide();
                        $("#egnyte").hide();
						$("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument1();" style="margin-left: 80px;"></i>');
						 
			        } else {
			        	 $(".icon-upload").hide();
			        	 $("#pick").hide();
		            	 $("#dropbox").hide();
		            	 $("#onedrive").hide();
                         $("#egnyte").hide();
						 $("#remove-icon").append('<i class="fa fa-times pull-right" aria-hidden="true" onclick="deleteDocument();" style="margin-left: 80px;"></i>');
						   
			        	 data.submit();
			        }
			       
			},
			
			
        done: function (e, data) {
        	//alert('DONE')
        	 /* $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo('#fileupload');
            }); */
        	
        },
        fail: function (e, data) {
        	alert('FAILED')
            $.each(data.messages, function (index, error) {
                $('<p style="color: red;">Upload file error: ' + error + '<i class="elusive-remove" style="padding-left:10px;"/></p>')
                .appendTo('#div_files');
            });
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );
        },
        success : function(response) {
            //alert(response)
             if(response =="subscriptionend")
            {
            	$("#show_upload_error").html('');
            	$("#show_upload_error").html("You dont have enough credit limit, Kindly subscribe DrySign subscription plan.");
            		
            }else if(response !="failed"){
            	
            	$.each( response, function( key, value ) {
            		//alert(key +' '+value );
            		if(key == 0){
            			 $("#docId").val(value);
            		}
            		if(key == 1){
           			 	 $("#draftId").val(value);
           			}
            	});
            	 // alert(response)
            	$("#pick").hide();
            	// $("#pick").hide();
            	 $("#dropbox").hide();
            	 $("#onedrive").hide();
                 $("#egnyte").hide();
            	$("#jumpstep2").removeAttr('disabled');
            }else{
            	$("#show_upload_error").html('');
            	$("#show_upload_error").html(response);
            }
        },
        complete : function(response) {
        	//alert("File Upload success");
        },
        error : function() {
        	alert('Error')
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
});

$('.close, .overlay-bg, .overlaywhite_bg').click(function(){
	$('.signature-sign').hide();
	$('.overlay-bg').hide();
	$('.Message').hide();
	$('.overlaywhite_bg').hide();
	
});

function deleteDocument(){
	//alert('HII');
	$('#deleteDocument').show();
	$('.overlaywhite_bg').show();
}
function deleteDocument1(){
	//alert('HII');
	location.reload();
}

function hiderDocumentPopUp(){
	$('#deleteDocument').hide();
	$('.overlaywhite_bg').hide();
}

function saveDocumentPopUp(){
	
	$('#skippopup').show();
	$('.overlaywhite_bg').show();
}

function getfieldValue(currentValue,id){
	//alert('CurrentValue'+currentValue+id);
	$("#field"+id).attr("value", currentValue);
	 //jumpstep3(2);
	 //checkFields();
}


function deleteDocumentPopUp(){
	
	var flag=$("#flag").val();
	var docId=$("#docId").val();
	if(docId != ''){
	
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		$.ajax({
			//contentType : 'application/json; charset=utf-8',
			type : "GET",
			url : contextPath+"app/deleteDocument?docId="+docId,
			beforeSend : function(xhr) {
				//$('#signupbtn').buttonLoader('start');
				xhr.setRequestHeader(header, token);
			},
			complete : function() {
				//$("#signupbtn").buttonLoader('stop');
			},success : function(response) {
				//alert(response);
				if(response == "103"){
					$("#deleteDocument").hide();
					$('.overlaywhite_bg').hide();	
					$("#show-selfsign-steps").hide();
	        		$("#skippopup").hide();
	        		$("#show-selfsign-error").show();
	        		$("#error-messgae").empty();
	        		$("#error-messgae").append('The document has signed previously.');
				}else if(response == "invalid"){
					$("#deleteDocument").hide();
					$('.overlaywhite_bg').hide();	
					$("#show-selfsign-steps").hide();
	        		$("#skippopup").hide();
	        		$("#show-selfsign-error").show();
	        		$("#error-messgae").empty();
	        		$("#error-messgae").append('Invalid Link');
				}
				else if(response == "success"){
					if(flag == "draft"){
						$("#deleteDocument").hide();
						$('.overlaywhite_bg').hide();	
						 window.location.href=contextPath+"app/document/selfsign" 
					}else{
						location.reload();	
					}
					
					
				}else{
					alert('loading error.');
				}
			},
			error: function(xhr, textStatus, errorThrown)
			 {
			 	alert('ajax loading error... ... ');
			 	return false;
			}
		});	
	}else{
		location.reload();
	}
	
}
</script>
  
  
  <!--Validation -->
<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script> -->
 <input type="hidden" id="count_row" value="1"/> 
<script>
 $(document).ready(function(){
	     
	     $(".priority_header").hide();
	     $(".priority").hide();
	     var i=parseInt($("#count_row").val());
		 $("#add_row").click(function(){
			 
			 
			 var j=parseInt($("#add-row").val());
			 var setpriority=$("#setpriority").val();
			 if(setpriority == 1){
				 $('#addr'+i).html("<td class='priority' id='priority"+(i)+"'>"+ (j+1) +"</td><td><input name='signername' id='signername"+(i)+"' type='text' placeholder='Signee Name' class='form-control input-md' onchange='validateSigners();'/><span class='required' id='signervalidname"+(i)+"' style='display:none'>Please enter signee name</span> </td><td><input  name='signeremail' id='signeremail"+(i)+"'  type='text' placeholder='Email Address' class='form-control input-md' onchange='validateSigners();'><span class='required' id='signervalidemail"+(i)+"' style='display:none'>Please enter valid email address </span></td><td><a class='btn btn-red' style='style='background: #f44336;'>Remove</a></td>");	 
			 }else{
				 $(".priority_header").hide();
				 $('#addr'+i).html("<td class='priority' id='priority"+(i)+"' style='display:none'>"+ (j+1) +"</td><td><input name='signername' id='signername"+(i)+"' type='text' placeholder='Signee Name' class='form-control input-md' onchange='validateSigners();'/><span class='required' id='signervalidname"+(i)+"' style='display:none'>Please enter signee name</span> </td><td><input  name='signeremail' id='signeremail"+(i)+"'  type='text' placeholder='Email Address' class='form-control input-md' onchange='validateSigners();'><span class='required' id='signervalidemail"+(i)+"' style='display:none'>Please enter valid email address </span></td><td><a class='btn btn-red' style='style='background: #f44336;'>Remove</a></td>");
			 }
		 	 $('#diagnosis_list').append('<tr id="addr'+(i+1)+'"></tr>');
		  	 i++; 
		     $("#add-row").val(j+parseInt(1));
		     $("#total-row").val(i+parseInt(1));
		     $("#save_next_2").attr('disabled','disabled');
		  saveSignerList();
		});
		
		$("#save_next_2").click(function(){
			saveSignerList()
		});
		
		$("#step3-button").click(function(){
			//saveSignerList()
		});
	  
 });
 
 function getSignerList(){
	    var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
        var docId=$("#docId").val();   
 		$.ajax({
		type : "GET",
		url : contextPath+"app/getSignerList?docId="+docId,
	    beforeSend: function (xhr) {
   			xhr.setRequestHeader(header, token);
	    },
	    complete: function () {
	    },
        success : function(response) {
         	if(response != 'failed'){
        	 var i=1;
       		 $(".priority_header").hide();
       		 $(".priority").hide();
       		var ckbox = $('#checkbox2');
	       	 
       		 
       		  $.each(response, function( key, value ) {
       		   	 var j=parseInt($("#add-row").val());
       			 var setpriority=$("#setpriority").val();
       			 
	       			if (value.flag =="1") {
	       				//alert('checked');
	       			    $("#checkbox2").attr('checked','checked')
	 	             	$(".priority_header").show();
	 	       	 	 	$(".priority").show();
	 	       	 	 	$("#setpriority").val(1);
	 	       	 	} else {
	 	       	 		$(".priority_header").hide();
		 	        	$(".priority").hide();
		 	        	$("#setpriority").val(0);
	 	            }
       			 if(key == 0){
       				 	$("#signername0").val(value.signerName);
       				 	$("#signeremail0").val(value.signerEmail);
       			 }else{
       				if(setpriority == 1){
       				 	$('#addr'+i).html("<td class='priority' id='priority"+(i)+"'>"+ (j+1) +"</td><td><input name='signername' id='signername"+(i)+"' value="+value.signerName+" type='text' placeholder='Signee Name' class='form-control input-md' onchange='validateSigners();'/><span class='required' id='signervalidname"+(i)+"' style='display:none'>Please enter signee name </span> </td><td><input  name='signeremail' id='signeremail"+(i)+"'  type='text' placeholder='Email Address' value="+value.signerEmail+" class='form-control input-md' onchange='validateSigners();'><span class='required' id='signervalidemail"+(i)+"' style='display:none'>Please enter valid email address </span></td><td><a class='btn btn-red' style='style='background: #f44336;'>Remove</a></td>");	 
       				 }else{
       				 	$(".priority_header").hide();
       				 	$('#addr'+i).html("<td class='priority' id='priority"+(i)+"' style='display:none'>"+ (j+1) +"</td><td><input name='signername' id='signername"+(i)+"'  value="+value.signerName+" type='text' placeholder='Signee Name' class='form-control input-md' onchange='validateSigners();'/><span class='required' id='signervalidname"+(i)+"' style='display:none'>Please enter signee name </span></td><td><input  name='signeremail' id='signeremail"+(i)+"'  type='text' placeholder='Email Address' value="+value.signerEmail+"  class='form-control input-md' onchange='validateSigners();'><span class='required' id='signervalidemail"+(i)+"' style='display:none'>Please enter valid email address </span></td><td><a class='btn btn-red' style='style='background: #f44336;'>Remove</a></td>");
       				 }
       				 	$('#diagnosis_list').append('<tr id="addr'+(i+1)+'"></tr>');
       				 	$("#add-row").val(j+parseInt(1));
  				     	$("#total-row").val(i+parseInt(1));
  				  i++; 
       			 }
       		 });	
         	
       		validateSigners();
       		//findDuplicates();
         	}else{
            	alert('failed');
            }
		},
		 error : function(e) {  
		    alert('Error: ' + e);   
		}  
	 });
	   
	  
 }

 //save signer name and signer email in tempSigner table(step2)
 function saveSignerList(){
	    var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		var totalRows=parseInt($("#total-row").val());
		var draftId=$("#draftId").val();
		var stepNumber=3;
		var docId=$("#docId").val();
		var jsonArray = [];
		var ckbox = $('#checkbox2');
		var flag="1";
		if (ckbox.is(':checked')) {
			var flag="1";	 
		}else{
			var flag="0";
		}
		
	   for(var i=0; i<totalRows; i++) {
			 var item = {};
		 	 if($("#priority"+i).text()!=undefined && $("#priority"+i).text()!="" && $("#signername"+i).val()!=undefined && $("#signername"+i).val()!="" && $("#signeremail"+i).val()!=undefined && $("#signeremail"+i).val()!="" ){
				item ['docId'] = docId;
				item ['draftId'] = draftId;
			    item ['stepNumber'] = stepNumber;
				item ["priority"] =$("#priority"+i).text();
				item ["signerName"] =$("#signername"+i).val();
				item ["signerEmail"] =$("#signeremail"+i).val();
				item ["signType"] ="G"; 
				item ["flag"] =flag; 
			  jsonArray.push(item); 
			
		  }  
		} 
		$.ajax({
			type : "POST",
			url : contextPath+"app/saveSignerList",
			dataType: 'json',
		    contentType: "application/json; charset=utf-8",
		    data: JSON.stringify(jsonArray),
		    beforeSend: function (xhr) {
	   			xhr.setRequestHeader(header, token);
		    },
		    complete: function () {
		    },
	        success : function(response) {
	         	if(response != 'failed'){
	        			//alert("success");
	        			$("#stepNumber").val(3);
	            }else{
	            	//alert('failed');
	            }
			},
			 error : function(e) {  
			    alert('Error: ' + e);   
			}  
		 });
		//$("#signer_list").val(jsonArray);
 }
 function enable_disable_proirity(){
	 var ckbox = $('#checkbox2');
	 if (ckbox.is(':checked')) {
        // alert('You have Checked it');
		 $(".priority_header").show();
	 	 $(".priority").show();
	 	 $("#setpriority").val(1);
	 	 
     } else {
        // alert('You Un-Checked it');
    	$(".priority_header").hide();
 	    $(".priority").hide();
 	    $("#setpriority").val(0);
     }
	 saveSignerList();
 }
</script>
<script type="text/javascript">

$(document).ready(function() {
	//Helper function to keep table row from collapsing when being sorted
	var fixHelperModified = function(e, tr) {
		var $originals = tr.children();
		var $helper = tr.clone();
		$helper.children().each(function(index)
		{
		  $(this).width($originals.eq(index).width())
		});
		return $helper;
	};

	//Make diagnosis table sortable
	$("#diagnosis_list tbody").sortable({
		helper: fixHelperModified,
		stop: function(event,ui) {renumber_table('#diagnosis_list')}
	}).disableSelection();


	//Delete button in table rows
	$('table').on('click','.btn-red',function() {
		tableID = '#' + $(this).closest('table').attr('id');
		var flag=$("#flag").val();
		var dragList=$("#draganddropList").val();
		//alert('dragList'+dragList);
		if(flag == "draft" && dragList !=""){
			r = confirm('You will lost step 3 prepare and sign positions data. Do you really want to continue?');
			draganddrop(2,"signerRemove");
			var increment=$("#generator").val();
			for(var i=0;i<=increment;i++){
				$("#fieldPosition"+i).remove();
			}
		}else{
			r = confirm('Are you sure want to delete signee name?');
		} 
		
		if(r) {
			
			$(this).closest('tr').remove();
			 var j=parseInt($("#add-row").val());
			 $("#add-row").val(j-1);
			renumber_table(tableID);
			saveSignerList();
			validateSigners();
		}
		
		
	});
	
	$("#preview").click(function(){
		
		var fileName=$(".file-upload-input").val();
		var subject=$("#subject").val();
		var message=$("#message").val();
		$("#preview_subject").html(subject);
		$("#preview_message").html(message);
		$(".overlay-bg").show();
		
		$("#myModal").show();
		    
		var totalRows=parseInt($("#total-row").val());
		var jsonArray = [];
		var ckbox = $('#checkbox2');
		var flag="1";
		if (ckbox.is(':checked')) {
			var flag="1";	 
		}else{
			var flag="0";
		}
		$('#showSummarySignerList').empty();
       var str =""; 
	   for(var i=0; i<=totalRows; i++) {
			
		 	 if($("#priority"+i).text()!=undefined && $("#priority"+i).text()!="" && $("#signername"+i).val()!=undefined && $("#signername"+i).val()!="" && $("#signeremail"+i).val()!=undefined && $("#signeremail"+i).val()!="" ){
				str+="<tr>";
		 		str+="<td class='prioritySummary'>"+$("#priority"+i).text()+"</td>";
		 		str+="<td>"+$("#signername"+i).val()+"</td>";
		 		str+="<td>"+$("#signeremail"+i).val()+"</td>";
		        str+="</tr>";
		  }  
		} 
	   
	   
	    $('#showSummarySignerList').append(str);
	    if(flag == 0){
			   $("#priorityHeaderSummary").hide();
			   $(".prioritySummary").hide();
		   }
		$("#summaryDocName").html(fileName);
		$('body').css('overflow','hidden');
	    //alert("The paragraph was clicked.");
	});

});

function closeSummary(){
	$(".overlay-bg").hide();
	$("#myModal").hide();
	$('body').css('overflow','scroll');
	
}

//Renumber table rows
function renumber_table(tableID) {
	$(tableID + " tr").each(function() {
		count = $(this).parent().children().index($(this)) + 1;
		$(this).find('.priority').html(count);
		
		
	});
}

//Renumber table rows
function renumber(tableID) {
	$(tableID + " tr").each(function() {
		count = $(this).parent().children().index($(this)) + 1;
		$(this).find('.addr-row').val(count);
		
		
	});
}

//email validation expression
function validateEmail(email) {
  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}


//Validation Table
function validateSignes(){
	var isValid = true;
	$('input[name^="signername').each(function() {
		if ($.trim($(this).val()) == '') {
			isValid = false;
			$(this).css({
				"border": "1px solid red",
				"background": "#FFCECE"
			});
		}else if(!$.trim($(this).val()).match('^[a-zA-Z]{3,16}$')){
			isValid = false;
			$(this).css({
				"border": "1px solid red",
				"background": "#FFCECE"
			});
		}
		else {
			$(this).css({
				"border": "",
				"background": ""
			});
		}
	});
	$('input[name^="signeremail').each(function() {
		if ($.trim($(this).val()) == '') {
			isValid = false;
			$(this).css({
				"border": "1px solid red",
				"background": "#FFCECE"
			});
		}else if(!validateEmail($.trim($(this).val()))){
			isValid = false;
			$(this).css({
				"border": "1px solid red",
				"background": "#FFCECE"
			});
		}
		else {
			$(this).css({
				"border": "",
				"background": ""
			});
		}

		
	});
	if (isValid == false) 
		e.preventDefault();
	else 
		document.getElementById('save_next_2').removeAttribute('disabled');

}

function draganddrop(stepNumber,checkFields){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	if(checkFields == "signerRemove"){
		$("#fieldshtml").val("");
		var fieldsHTML = "";
	}else{
		$("#fieldshtml").val("");
		var fieldsHTML = "";
		/* $("#document-reader > .dragMe").each(function() {
			fieldsHTML += $(this).prop("outerHTML");
		}); */
	}
	//alert('fieldsHTML'+fieldsHTML);
	//$("#fieldshtml").val(fieldsHTML);
	var docId=$("#docId").val();
	var draftId=$("#draftId").val();
	var increment=$("#generator").val();
	var data = {
			 "docId": docId,
			 "draftId" : draftId,
			 "fieldHtml" : fieldsHTML,
			 "stepNumber":stepNumber,
			 "increment":1,
			 "signType":"G"
	}
	$.ajax({
		type : "POST",
		url : contextPath+"app/step2SelfSign",
		dataType: 'json',
	    contentType: "application/json; charset=utf-8",
	    data: JSON.stringify(data),
	    beforeSend: function (xhr) {
   			xhr.setRequestHeader(header, token);
	    },
	    complete: function () {
	    },
        success : function(response) {
        	//alert(response);
          if(response != 'failed'){
      			//alert("success");
      			$("#stepNumber").val(3);
          }else{
          	alert('failed');
          }

		},
		 error : function(e) {  
		    alert('Error: ' + e);   
		}  
	 });
}
 
function jumpstep2(stepNumber){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	$("#fieldshtml").val("");
	var fieldsHTML = "";
	$(".drop > .dragMe").each(function() {
		fieldsHTML += $(this).prop("outerHTML");
	});
	var signType="G";
	//alert('fieldsHTML'+fieldsHTML);
	//$("#fieldshtml").val(fieldsHTML);
	var docId=$("#docId").val();
	var draftId=$("#draftId").val();
	var increment=$("#generator").val();
	var data = {
			 "docId": docId,
			 "draftId" : draftId,
			 "fieldHtml" : "",
			 "stepNumber":stepNumber,
			 "increment":1,
			 "signType":signType
	}
	$.ajax({
		type : "POST",
		url : contextPath+"app/step2SelfSign",
		dataType: 'json',
	    contentType: "application/json; charset=utf-8",
	    data: JSON.stringify(data),
	    beforeSend: function (xhr) {
   			xhr.setRequestHeader(header, token);
	    },
	    complete: function () {
	    },
        success : function(response) {
         	if(response != 'failed'){
        			//alert("success");
        			$("#stepNumber").val(2);
            }else{
            	alert('failed');
            }
		},
		 error : function(e) {  
		    alert('Error: ' + e);   
		}  
	 });
}
function jumpstep3(count){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	//alert($(".file-upload-input").attr('title'));
	if(count == 0){
		$("#viewpagecount").val(1);	
	}
	
	if(count != 1){
	var docId=$("#docId").val();
	var fileName=$(".file-upload-input").val();
	var draftId=$("#draftId").val();
	var flag=$("#flag").val();
	var info = "?docId="+docId+"&fileName="+fileName+"&draftId="+draftId+"&flag="+flag+"&step=3";
	$.ajax({
		//contentType : 'application/json; charset=utf-8',
		type : "GET",
		url : contextPath+"app/getDocument"+info,
		async: false,
		//dataType : 'json',
		//data : JSON.stringify(data),
		beforeSend : function(xhr) {
			//$('#signupbtn').buttonLoader('start');
			xhr.setRequestHeader(header, token);
		},
		complete : function() {
			//$("#signupbtn").buttonLoader('stop');
		},
		success : function(response) {
			var numpages="";
			var filename="";
			var fileid="";
			var width="";
			var height="";
			if(response != 'failed'){
				var i=1;
				$.each( response, function( key, value ) {
						//  alert( key + ": " + value );
					if(key == "numpages" ){
						numpages=value;
						$("#numpages").val(numpages)
					}
					
					if(key =="filename"){
						filename=value;
						//alert(filename);
					}
					
					if(key =="fileid"){
						fileid=value;
					}
					
					if(key =="pwidth"){
						width=value;
						
					}
					
					if(key =="pheight"){
						height=value;
						$("#pageHeight").val(height)
					}
				});
				for (var i = 1; i <= numpages; i++) {
			  		//$("#document-reader").append('<div class="drop" id="'+i+'"><img width="'+width+'px" height="'+height+'px" class="render-image" onload="loadImage()" src="'+contextPath+'getImgDocument?fileid='+fileid+'&filename='+filename+'&page='+i+'&userId='+userId+'"></div>');
					$.ajax({
						//contentType : 'application/json; charset=utf-8',
						type : "GET",
						url : contextPath+'app/img?fileid='+fileid+'&filename='+filename+'&page='+i+'&numpages='+numpages,
						async: false,
						//dataType : 'json',
						//data : JSON.stringify(data),
						beforeSend : function(xhr) {
							//$('#signupbtn').buttonLoader('start');
							$("#loader2").show();
							xhr.setRequestHeader(header, token);
						},
						complete : function() {
							//$("#signupbtn").buttonLoader('stop');
						},
						success : function(response) {
							//alert(response);
							//alert(response);
						
							$("#document-reader").append('<div class="drop" id="'+i+'"><img width="'+width+'px" height="'+height+'px" class="render-image" onload="loadImage()" src="data:image/png;base64,'+response+'"></div>');
							/* if(response =="base64error"){
								alert('base64error');
							} */
							//alert(response);
							
						},
						error : function(response) {
							$("#document-reader").append('<div class="drop" id="'+i+'"><img width="'+width+'px" height="'+height+'px" class="render-image" onload="loadImage()" src="data:image/png;base64,'+response+'"></div>');
						},
					});
			  		
				}
				$("#loader2").hide();
				$("#stepNumber").val(3);
				//var test1='<div class="dragMe drgfields ui-draggable ui-draggable-dragging ui-draggable-handle" style="padding: 0px; position: absolute; left: 154.25px; top: 60px;" data-signer-id="1" data-document-id="1" id="fieldPosition1"><span>Name</span><span class="closeIt">x</span><input type="text" id="field1" class="selfsign-control" onchange="getfieldValue(this.value,1)" value="asdasd" name="name" required=""></div><div class="dragMe ui-draggable ui-draggable-handle ui-draggable-dragging" data-signer-id="1" data-document-id="1" style="position: absolute; left: 422px; top: 31.4844px;" id="fieldPosition1"><span>Name</span><span class="closeIt">x</span><input type="text" id="field1" class="selfsign-control" onchange="getfieldValue(this.value,1)" value="" name="name" required=""></div>';
				
				
				
				jumpstep2(3);
				 
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
	}
	
	DragSigner();
    DragMe();
}


function DragSigner(){

    $(".dragSigners").draggable({
      helper: 'clone',
      cursor: 'move',
      tolerance: 'fit',
      revert: true 
    });

    $(".drop").droppable({
      accept: '.dragSigners',
      activeClass: "drop-area",

      drop: function(e, ui) {
        dragEl = ui.helper.clone();
        ui.helper.remove();

        document_id   = dragEl.data("document-id");
        signer_id     = dragEl.data("signer-id");
        leftPosition  = ui.offset.left - $(this).offset().left;
        topPosition   = ui.offset.top - $(this).offset().top;
        
        var droppableId = $(this).attr("id");
        var uniqueGenerator = $("#generator").val();
        if (document_id == 1 && signer_id == 1) {
        	var fullname=$("#fullName").val();
        	//dragEl = ui.helper.clone().html('<span>Name</span><span class="closeIt hideIt">x</span><input type="text" id="field'+uniqueGenerator+'" class="selfsign-control"  onchange="getfieldValue(this.value,'+uniqueGenerator+')" value="" name="name" required />');
			//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group name"> <span style="position:relative;" class="add-clear-span"><input name="name" type="text" class="form-control" id="field'+uniqueGenerator+'" onchange="getfieldValue(this.value,'+uniqueGenerator+')" placeholder="Name" value="'+fullname+'" type="text"></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none;" id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></span></div></div>');
			//dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="name" class="btn btn-default btn-select name" id="field'+uniqueGenerator+'"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Name</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>');
			//dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
        	
               //dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group name"> <span style="position:relative;" class="add-clear-span"><input name="name" type="text" class="form-control" id="field'+uniqueGenerator+'" onchange="getfieldValue(this.value,'+uniqueGenerator+')" placeholder="Name" value="'+fullname+'" type="text"></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none;" id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></span></div></div>');
   			$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a class="closeIt hideIt" style=" text-decoration: none;"  onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="name" class="btn btn-default btn-select name" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Name</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>'));
   			$(".dragMe").removeClass("btn btn-light-oragne margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
   			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
			
			
		}else if (document_id == 1 && signer_id == 2) {
			Date.prototype.monthNames = [
                "January", "February", "March",
                "April", "May", "June",
                "July", "August", "September",
                "October", "November", "December"
            ];

            Date.prototype.getMonthName = function() {
                return this.monthNames[this.getMonth()];
            };
            Date.prototype.getShortMonthName = function () {
                return this.getMonthName().substr(0, 3);
            };

			var today = new Date();
			var dd = today.getDate();
			var mm = today.getShortMonthName(); //January is 0!
			var yyyy = today.getFullYear();

			if(dd<10) {
			    dd='0'+dd
			} 

			if(mm<10) {
			    mm='0'+mm
			} 

			today = dd+'-'+mm+'-'+yyyy;
			//dragEl = ui.helper.clone().html('<span>Date</span><span class="closeIt hideIt">x</span><input type="text" id="field'+uniqueGenerator+'" class="selfsign-control" value="'+today+'" name="date" onchange="getfieldValue(this.value,'+uniqueGenerator+')"  required readonly/>');
			//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group date"> <span style="position:relative;" class="add-clear-span"><input name="date" type="text" class="form-control " onchange="getfieldValue(this.value,'+uniqueGenerator+')" id="field'+uniqueGenerator+'" placeholder="Date.." value="'+today+'"  type="text" readonly></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none; " id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close" ></span></a></span></div></div>');
			//dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="date" class="btn btn-default btn-select date" id="field'+uniqueGenerator+'"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Date</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>');
			//dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
			$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a class="closeIt hideIt" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="date" class="btn btn-default btn-select date" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Date</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>'));
  			$(".dragMe").removeClass("btn btn-light-yellow margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
  			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
			
		}else if (document_id == 1 && signer_id == 3) {
			/* var signature=$("#signature").val();
			if(signature !=null){
				dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group signatureb"> <span style="position:relative;" class="add-clear-span"><input name="signature" type="image"  id="field'+uniqueGenerator+'" onclick="openMySignature('+uniqueGenerator+')" class="" placeholder="Signature here" src="'+signature+'" readonly></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none; " onclick="hideTextbox('+uniqueGenerator+')"  id="fieldclose'+uniqueGenerator+'" href="#clear"><span class="icon-close" ></span></a></span></div></div>');
			}else{
				dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group signatureb"> <span style="position:relative;" class="add-clear-span"><input name="signature" type="text"  id="field'+uniqueGenerator+'" onclick="openMySignature('+uniqueGenerator+')" class="form-control" placeholder="Signature here" src="" readonly></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none; " onclick="hideTextbox('+uniqueGenerator+')"  id="fieldclose'+uniqueGenerator+'" href="#clear"><span class="icon-close" ></span></a></span></div></div>');
			} */
			//dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="signature" class="btn btn-default btn-select signature1" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Signature</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>');
	     	//	dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
	     	$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a class="closeIt hideIt" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="signature" class="btn btn-default btn-select signature1" id="field'+uniqueGenerator+'"  data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Signature</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>'));
  			$(".dragMe").removeClass("btn btn-light-Bermuda margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
  			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
	     	
		}else  if (document_id == 1 && signer_id == 4) {
        	//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group text"> <span style="position:relative;" class="add-clear-span"><input name="text" type="text" class="form-control expandeble" onchange="getfieldValue(this.value,'+uniqueGenerator+')" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);"  id="field'+uniqueGenerator+'" placeholder="Text" value="" ></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none;" id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></span></div></div>');
			//dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="textbox" class="btn btn-default btn-select textbox" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Textbox</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>');
        	//dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
			$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a class="closeIt hideIt" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="textbox" class="btn btn-default btn-select textbox" id="field'+uniqueGenerator+'"  data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+' ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Textbox</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>'));
  			$(".dragMe").removeClass("btn btn-light-purple margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
  			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
        	
		}else  if (document_id == 1 && signer_id == 5) {
    		//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-field"><input name="checkbox" id="field'+uniqueGenerator+'" type="checkbox"  class="filled-in" checked><label for="single" ></label><span class="icon-close" onclick="hideTextbox('+uniqueGenerator+')"></span></div></div>');
			dragEl = ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a class="close" style=" text-decoration: none;"  onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="checkbox" class="btn btn-default btn-select checkbox" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Checkbox</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>');
    		dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
		}else  if (document_id == 1 && signer_id == 6) {
    		var firstname=$("#firstName").val();
			//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group initials"> <span style="position:relative;" class="add-clear-span"><input name="initials" type="text" class="form-control expandeble" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);" onchange="getfieldValue(this.value,'+uniqueGenerator+')"  id="field'+uniqueGenerator+'" placeholder="Text" value="'+firstname+'" ></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none;" id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></span></div></div>');
		//	dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="initials" class="btn btn-default btn-select initials" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Initails</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>');
		//	dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
    		$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a class="closeIt hideIt" style=" text-decoration: none;"  onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="initials" class="btn btn-default btn-select initials" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Initials</span><span class="btn-select-arrow fa fa-angle-down"></span></a></div>'));
  			$(".dragMe").removeClass("btn btn-light-brown margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
  			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
		
		}
        var incremented = parseInt(uniqueGenerator)+1;
        $("#generator").val(incremented);
        
        //var total_row=$("#total-row").val();
        
       
        // debug current dropped position
        //alert("top: " + topPosition + ", left: " + leftPosition); 
        //dragEl.data("signer-id", signer_id);

        dragEl.draggable({
          helper: 'original',
          cursor: 'move',
          tolerance: 'fit',
          drop: function (event, ui) {
            $(ui.draggable).remove();
          }
        });

        // append element to #document-reader
        dragEl.addClass("dragMe");
        if (document_id == 1 && signer_id == 1) {
        	dragEl.removeClass("btn btn-light-oragne margB20");
        }else if (document_id == 1 && signer_id == 2) {
        	dragEl.removeClass("btn btn-light-yellow margB20");
        }else if (document_id == 1 && signer_id == 3) {
        	dragEl.removeClass("btn btn-light-Bermuda margB20");
        }else if (document_id == 1 && signer_id == 4) {
        	dragEl.removeClass("btn btn-light-purple margB20");
        }else if (document_id == 1 && signer_id == 5) {
        	dragEl.removeClass("btn btn-light-blue margB20");
        }else if (document_id == 1 && signer_id == 6) {
        	dragEl.removeClass("btn btn-light-brown margB20");
        }
      //  dragEl.removeClass("dragSigners col-sm-6 parent");
       // dragEl.find("span.closeIt").removeClass("hideIt");
       // dragEl.appendTo('#document-reader');
        
        var total_row=$("#total-row").val()
        var html = '<ul>';
	        for (var i = 0; i <= total_row; i++) {
	        	var signername=$("#signername"+i).val();
	        	var signeremail=$("#signeremail"+i).val();
	        	
	        	var ckbox = $('#checkbox2');
	       		if (ckbox.is(':checked')) {
	       			var priority=$("#priority"+i).html();
		        	
	       		} else {
	       			var priority=$("#priority"+i).html();
	           }
	        	if(signername  != undefined && signername !=""){
	        		//alert($("#signername"+i).val());
	        		html += '<li data-name="'+priority+'" id="'+signeremail+'">'+$("#signername"+i).val()+'</li>';
	        	}
	        }
        html += '</ul>';
        if (document_id == 1 && signer_id == 1) {
	    	$('#field'+uniqueGenerator).append(html);
        }else if (document_id == 1 && signer_id == 2) {
        	$('#field'+uniqueGenerator).append(html);
        }else if (document_id == 1 && signer_id == 3) {
        	$('#field'+uniqueGenerator).append(html);
        }else if (document_id == 1 && signer_id == 4) {
        	$('#field'+uniqueGenerator).append(html);
        }else if (document_id == 1 && signer_id == 5) {
        	$('#field'+uniqueGenerator).append(html);
        }else if (document_id == 1 && signer_id == 6) {
        	$('#field'+uniqueGenerator).append(html);
        }
        
        
       draganddrop(3,"");
       
       signerEmailList();
        // update draged element position to database
        // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)
		//checkFields()
        // activate dragging for cloned element
        DragMe();
      }
    });
  }



  function DragMe(){
    var document_id;
    $(".dragMe").draggable({
      containment: "#document-reader",
      cursor: 'move',
      // opacity: 0.35,
      stack: $('#document-reader'),
      scroll: false,
      appendTo: $("#document-reader"),
      start: function(event, ui) {
        startPosition = $(this).position();
      },
      stop: function(event, ui) {
        dragEl        = $(this);
        stopPosition  = dragEl.position();
        document_id   = dragEl.data("document-id");
        signer_id     = dragEl.data("signer-id");
        
        // debug current dropped position
        // this position is working perfectly fine.
        // above drag, drop and clone position should behave like this
      //  alert("top: " + stopPosition.top + ", left: " + stopPosition.left); 
           //jumpstep3(2);
        console.log(dragEl.hasClass("parent"))
        if(!dragEl.hasClass("parent")){
         // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)
        }
      }
    });
  }

  // this function is simply for updating required fields to database
  // please ignore this for now
  function updateDraggedPosition(dragEl, stopPosition, document_id, signer_id){
    $.ajax({
      url: '/signers/drag_signer',
      data: {
        drag_signer: {
          top: stopPosition.top,
          left: stopPosition.left,
          signer_id: signer_id,
          document_id: document_id,
          id: dragEl.data("id")
        }
      },
      type: "POST",
      dataType: "script",
      success: function(data) {
        console.log(dragged_signer_id);
        console.log(dragEl);
        dragEl.data("id", dragged_signer_id);
      }
    })
  }
  

jQuery.validator.addMethod("multiemail", function (value, element) {
    if (this.optional(element)) {
        return true;
    }
    var emails = value.split(','),
        valid = true;
    for (var i = 0, limit = emails.length; i < limit; i++) {
        value = emails[i];
        valid = valid && jQuery.validator.methods.email.call(this, value, element);
    }
    return valid;
}, "Please separate email addresses with a comma and do not use spaces.");

var step4Form=$("#step3-form").validate({
	//specify the validation rules
	errorElement: 'p',
    errorClass: 'error',
	rules: {
		subject:"required",
		message:"required",
		cc:{
    		 multiemail:true
		}
	},
	//specify validation error messages
	messages: {
		subject: "Please enter a subject",
		message: "Please enter a message",
		cc:{
   		 required: "Please enter a valid email address"
   	}
	}
});


/* function validateSigners(){
	var jsonArray = [];
	var totalRows=parseInt($("#total-row").val());
	for(var i=0; i<totalRows; i++) {
	  	var item = {};
	    if($("#signername"+i).val() !=undefined && $("#signeremail"+i).val() !=undefined  ){
		    item ["signerValidName"] = $("#signervalidname"+i).attr('id');
		    item ["signerValidEmail"] =$("#signervalidemail"+i).attr('id');
	 	 	item ["signerName"] =$("#signername"+i).val();
			item ["signerEmail"] =$("#signeremail"+i).val();
		jsonArray.push(item);
	    }
	 } 
	

	 $.each(jsonArray, function( key, value ) {
		 
		 if(value.signerName == ""){
			 $("#"+value.signerValidName).show();
		 }else{
			 $("#"+value.signerValidName).hide();
		 }
	     if (validateEmail(value.signerEmail)) {
	    	 $("#"+value.signerValidEmail).hide();
		 } else {
			 $("#"+value.signerValidEmail).show();
		 }
	     
	     if(value.signerName !="" && validateEmail(value.signerEmail)){
	    	 enableButton=1;
	     }else{
	    	 enableButton=0;
	     }
	     $("#enableButton").val(enableButton);
	 });
	 if($("#enableButton").val() == 1){
		 $("#save_next_2").removeAttr('disabled');	 
	 }else{
		 $("#save_next_2").attr('disabled','disabled');
	 }
	 
	 saveSignerList();
	 
} */

function validateSigners(){
	
	var isValid = true;
	$('input[name^="signername').each(function() {
		if ($.trim($(this).val()) == '') {
			isValid = false;
			$(this).css({
				"border": "0",
				"outline": "#0",
				"background": "transparent",
				"border-bottom": "1px solid #e81818"
			});
		} else if(!$.trim($(this).val()).match("^[A-Za-z ,.'-]+$")){
			isValid = false;
			$(this).css({
				"border": "0",
				"outline": "#0",
				"background": "transparent",
				"border-bottom": "1px solid #e81818"
			});
		} 
		else {
			$(this).css({
				"border": "",
				"outline": "",
				"background": "",
			    "border-bottom": ""
			});
		}
	});
	$('input[name^="signeremail').each(function() {
		if ($.trim($(this).val()) == '') {
			isValid = false;
			$(this).css({
				"border": "0",
				"outline": "#0",
				"background": "transparent",
				"border-bottom": "1px solid #e81818"
			});
		}else if(!validateEmail($.trim($(this).val()))){
			isValid = false;
			$(this).css({
				"border": "0",
				"outline": "#0",
				"background": "transparent",
				"border-bottom": "1px solid #e81818"
			});
		}else if(findDuplicates()== false){
			
			isValid = false;
			$(this).css({
				"border": "0",
				"outline": "#0",
				"background": "transparent",
				"border-bottom": "1px solid #e81818"
			});
		}
		else {
			$(this).css({
				"border": "",
				"outline": "",
				"background": "",
			    "border-bottom": ""
			});
		}
	});
	 saveSignerList();
	if (isValid == false){ 
	 	$("#save_next_2").attr('disabled','disabled');
	}
	else{ 
		$("#save_next_2").removeAttr('disabled');
	}
}
/* function checkExistEmail(value){
	var unique_values = {};
	var list_of_values = [];
	$('input[name$="signeremail"]').
	    each(function(item) { 
	        if ( ! unique_values[value] ) {
	            unique_values[value] = true;
	            list_of_values.push(value);
	        } else {
	            return false;
	        }
	    });
} */
function findDuplicates() {
    var isDuplicate = false;
    $("input[name^='signeremail']").each(function (i,el1) {
    	 var current_val = $(el1).val();
	    $('[name="signeremail"]').not(this).each(function(i,el2){
			 if($(el2).val().toLowerCase() == current_val.toLowerCase()) {
				 isDuplicate = true;
	             return;
			 }
		  }) 
    });
    if (isDuplicate) {
        //alert ("Duplicate values found.");
        return false;
    } else {
        return true;
    }
}
function validateEmail(email) {
	  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	  return re.test(email);
	}
	
function saveGroupSign(){
	 var valid = $("#step3-form").valid();
	 if(valid == true){
		    var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var contextPath=$("#contextPath").val();
			var generatorLength=$("#generator").val();
			var docId=$("#docId").val();
			var draftId=$("#draftId").val();
			var fileName=$(".file-upload-input").val();
			var subject=$("#subject").val();
			var message=$("#message").val();
			var cc=$("#cc").val();
			var ckbox = $('#checkbox2');
			var pageHeight=$("#pageHeight").val();
			var numpages=$("#numpages").val();
			var isActivePriority;
			 if (ckbox.is(':checked')) {
		        // alert('You have Checked it');
				 isActivePriority="active";
			 } else {
		        // alert('You Un-Checked it');
		    	 isActivePriority="inactive";
		     }
			var jsonArray = [];
			for(var i=1; i<generatorLength; i++) {
				var item = {};
				var fieldType=$("#field"+i).attr("data-signer");
				if(fieldType !=null && fieldType !=undefined){
					if(fieldType == "name"){
						item ['docId'] = docId;
						item ['draftId'] = draftId;
						item ['documentName'] = fileName;
						item ['top'] =$("#field"+i).attr("data-top");
						item ['left'] = $("#field"+i).attr("data-left");
						item ['fieldType'] = "text";
						item ['fieldName'] = $("#field"+i).attr("data-signer");
						item ['priority'] = $("#fieldpriorityvalue"+i).val();
						item ['signerName'] = $("#fieldvalue"+i).val();
						item ['signerEmail'] = $("#fieldemailvalue"+i).val();
						item ['fieldWidth']= "150";
						item ['fieldHeight']= "50";
						item ['pageHeight']= pageHeight;
						item ['numpages']= numpages;
						item ['subject'] = subject;  
						item ['message'] = message;	
						item ['cc'] = cc;
						item ['isActivePriority'] = isActivePriority;
						item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
						item ['fieldValue'] = $("#fieldvalue"+i).val();
					}else if(fieldType == "date"){
						item ['docId'] = docId;
						item ['draftId'] = draftId;
						item ['documentName'] = fileName;
						item ['top'] =$("#field"+i).attr("data-top");
						item ['left'] = $("#field"+i).attr("data-left");
						item ['fieldType'] = "date";
						item ['fieldName'] = $("#field"+i).attr("data-signer");
						item ['priority'] = $("#fieldpriorityvalue"+i).val();
						item ['signerName'] = $("#fieldvalue"+i).val();
						item ['signerEmail'] = $("#fieldemailvalue"+i).val();
						item ['fieldWidth']= "150";
						item ['fieldHeight']= "50";
						item ['pageHeight']= pageHeight;
						item ['numpages']= numpages;
						item ['subject'] = subject;  
						item ['message'] = message;
						item ['cc'] = cc;	
						item ['isActivePriority'] = isActivePriority;
						item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					}else if(fieldType == "signature"){
						item ['docId'] = docId;
						item ['draftId'] = draftId;
						item ['documentName'] = fileName;
						item ['top'] =$("#field"+i).attr("data-top");
						item ['left'] = $("#field"+i).attr("data-left");
						item ['fieldType'] = "image";
						item ['fieldName'] = $("#field"+i).attr("data-signer");
						item ['priority'] = $("#fieldpriorityvalue"+i).val();
						item ['signerName'] = $("#fieldvalue"+i).val();
						item ['signerEmail'] = $("#fieldemailvalue"+i).val();
						item ['fieldWidth']= "150";
						item ['fieldHeight']= "50";
						item ['pageHeight']= pageHeight;
						item ['numpages']= numpages;
						item ['subject'] = subject;  
						item ['message'] = message;
						item ['cc'] = cc;
						item ['isActivePriority'] = isActivePriority;
						item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					}else if(fieldType == "textbox"){
						item ['docId'] = docId;
						item ['draftId'] = draftId;
						item ['documentName'] = fileName;
						item ['top'] =$("#field"+i).attr("data-top");
						item ['left'] = $("#field"+i).attr("data-left");
						item ['fieldType'] = "text";
						item ['fieldName'] = $("#field"+i).attr("data-signer");
						item ['priority'] = $("#fieldpriorityvalue"+i).val();
						item ['signerName'] = $("#fieldvalue"+i).val();
						item ['signerEmail'] = $("#fieldemailvalue"+i).val();
						item ['fieldWidth']= "150";
						item ['fieldHeight']= "50";
						item ['pageHeight']= pageHeight;
						item ['numpages']= numpages;
						item ['subject'] = subject;  
						item ['message'] = message;
						item ['cc'] = cc;	
						item ['isActivePriority'] = isActivePriority;
						item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					}else if(fieldType == "checkbox"){
						item ['docId'] = docId;
						item ['draftId'] = draftId;
						item ['documentName'] = fileName;
						item ['top'] =$("#field"+i).attr("data-top");
						item ['left'] = $("#field"+i).attr("data-left");
						item ['fieldType'] = "image";
						item ['fieldName'] = $("#field"+i).attr("data-signer");
						item ['priority'] = $("#fieldpriorityvalue"+i).val();
						item ['signerName'] = $("#fieldvalue"+i).val();
						item ['signerEmail'] = $("#fieldemailvalue"+i).val();
						item ['fieldWidth']= "150";
						item ['fieldHeight']= "50";
						item ['pageHeight']= pageHeight;
						item ['numpages']= numpages;
						item ['subject'] = subject;  
						item ['message'] = message;
						item ['cc'] = cc;
						item ['isActivePriority'] = isActivePriority;
						item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					}else if(fieldType == "initials"){
						item ['docId'] = docId;
						item ['draftId'] = draftId;
						item ['documentName'] = fileName;
						item ['top'] =$("#field"+i).attr("data-top");
						item ['left'] = $("#field"+i).attr("data-left");
						item ['fieldType'] = "text";
						item ['fieldName'] = $("#field"+i).attr("data-signer");
						item ['priority'] = $("#fieldpriorityvalue"+i).val();
						item ['signerName'] = $("#fieldvalue"+i).val();
						item ['signerEmail'] = $("#fieldemailvalue"+i).val();
						item ['fieldWidth']= "150";
						item ['fieldHeight']= "50";
						item ['pageHeight']= pageHeight;
						item ['numpages']= numpages;
						item ['subject'] = subject;  
						item ['message'] = message;
						item ['cc'] = cc;
						item ['isActivePriority'] = isActivePriority;
						item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					}
					jsonArray.push(item);
				}
			}
			var btn='#send';
				$.ajax({
					type : "POST",
					url : contextPath+"app/saveGroupSign",
					dataType: 'json',
				    contentType: "application/json; charset=utf-8",
				    data: JSON.stringify(jsonArray),
				    beforeSend: function (xhr) {
				    	$(btn).buttonLoader('start');
				    	$("#loader2").show();
			   			xhr.setRequestHeader(header, token);
			   	    },
				    complete: function () {
				    	$(btn).buttonLoader('stop');
				    	$("#loader2").hide();
				    },
			        success : function(response) {
			        	if(response == 'success'){
			        		//alert("success");
			        		$("#show-groupsign-steps").hide();
			        		$("#success-group-messgae").show();
			        	}else{
			            	alert('failed');
			            }
					},
					 error : function(e) {  
					    alert('Error: ' + e);   
					}  
				 });
			}
	 }
	
	
</script>
