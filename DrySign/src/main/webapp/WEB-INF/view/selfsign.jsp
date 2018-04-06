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
<link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
<style>
.red-tooltip  {background-color: #000; color:#fff: display: block !important }
.red-tooltip > .tooltip-arrow {
  border-top-color: red;
}
.Message {
      box-shadow: 0px 0px 10px 1px #d4d4d4 !important;
}
	.selected {
    box-shadow: 9px 11px 28px -12px #080808;
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


 input[type=image]{
 height: 54px;
 width:185px;
 background: #eee;
 }

.loader {
   position: absolute;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=appUrl %>/images/spin.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
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

.input-group .closeIt {
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
    right: -6px;
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
		<li class="active">Self Sign</li>
	</ol>
	  </div>
        <!-- breadcrumb -->
        
        <!-- Main content -->
        
    <div class="container-fluid">   
    <div id="show-selfsign-steps">
    <div class="wizard">
      <div class="wizard-inner">
        <div class="connecting-line"></div>
        <ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" id="steplist1" class="disabled"> <a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" > <span class="round-tab" style="left: 0"></span> </a> </li>
          <li role="presentation" id="steplist2" class="disabled"> <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" > <span class="round-tab" style=" margin: 0 auto; "></span></a> </li>
          <!-- <li role="presentation" class="disabled"> <a href="#step3" data-toggle="tab" aria-controls="step3" role="tab" > <span class="round-tab"> <i class="fa fa-newspaper-o" aria-hidden="true"></i> </span> <b>Prepare Document</b> </a> </li> -->
          <li role="presentation" id="steplist3" class="disabled"> <a href="#step3" data-toggle="tab" aria-controls="complete" role="tab" > <span class="round-tab" style="right: -15px"></span> </a> </li>
        </ul>
      </div>
      <!-- <form role="form"> -->
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
                      <!--  <button type="submit" id="pick"style="border: 0; background: transparent">
								<img src="<%=appUrl %>/images/photo.jpg" width="70" height="70" alt="submit" />
						</button> -->                  
                        <div class="upload-fild">
                          <div class="custom-file-upload">
							<!--<label for="file">File: </label>--> 
							<!-- <input type="file" id="fileupload" placeholder="Please select uploaded file" name="files[]" /> -->
							  <input id="fileupload" placeholder="Please select uploaded file" type="file" name="files">
							  <button data-toggle="tooltip" class="red-tooltip" data-placement="top" title="Google Drive" type="submit" class="" id="pick"style="border: 0;background: transparent;float: right;position: absolute;right: -20px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/photo.jpg" width="30" height="30" alt="submit" />
								</button>
								<button data-toggle="tooltip" class="red-tooltip" data-placement="top" title="Dropbox" type="submit" class="" id="dropbox"style="border: 0;background: transparent;float: right;position: absolute;right: -50px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/dropbox.png" width="25" height="25" alt="submit" />
								</button>
								<button data-toggle="tooltip" class="red-tooltip" data-placement="top" title="OneDrive" type="submit" class="" id="onedrive" onclick="launchOneDrivePicker()" style="border: 0;background: transparent;float: right;position: absolute;right: -90px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/onedrive.png" width="30" height="30" alt="submit" />
								</button>
								<!-- Egnyte -->
								<%-- <button onclick="return popitupEgnyte('egnyte')" data-toggle="tooltip" class="red-tooltip" data-placement="top" title="egnyte" type="submit" class="" id="egnyte" style="border: 0;background: transparent;float: right;position: absolute;right: -128px; padding: 0; margin: 0;height: 36px;top: 8px;">
								<img src="<%=appUrl %>/images/egnyte.png" width="20" height="20" alt="submit" />
								</button> --%>
								<div id="container"></div>		
						</div>
						
						 <div id="progress" class="progress">
							<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">  
							</div>
 						  </div>
					     <span id="show_upload_error" style="color:#ff0000"></span>
                         <!-- <div class="progress">
							<div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:10%"> </div>
 						 </div> -->
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
          
        </div>
        
        <!-- Profestional Information -->
        <div class="tab-pane" role="tabpanel" id="step2">
          <div class="step2">
            <section>
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature" style="width: 95%; float: left">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <h3 class="head3_1">Step 2: Prepare and sign</h3>
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
                    </div>
				  	 <!--NEW Design -->
					 <!-- <div class="force-overflow">
					 	 <div class="pdf-inner mCustomScrollbar" >
					  		<img src="img/PDF_view.jpg">
				    			<div class="input-drop-fild">
									<div class="input-group name">
                             		<span style="position:relative;" class="add-clear-span">
                              			<input name="q" class="form-control " placeholder="Search by ID..." type="text">
                          			</span>                           
                            		<span class="input-group-btn">
                                		<a class="btn" style=" text-decoration: none; " href="#clear"><span class="icon-close"></span></a>
                               		 </span>
                      			  </div>
								</div>
					      		<div class="input-drop-fild">
									<div class="input-group date">
                             		<span style="position:relative;" class="add-clear-span">
                              			<input name="q" class="form-control " placeholder="10/12/2017" type="text">
                          			</span>                           
                            		<span class="input-group-btn">
                               		 <a class="btn" style=" text-decoration: none; " href="#clear"><span class="icon-close"></span></a>
                               		</span>
                        			</div>
								</div>
					     		<div class="input-drop-fild">
									<div class="input-group signatureb">
                             		<span style="position:relative;" class="add-clear-span">
                              			<input name="q" class="form-control " placeholder="Signature here" type="text">
                        			  </span>                           
                                    </div>
								</div>
					   			 <button type="button" class="btn btn-light-Bermuda signature-tab"><span class="icon-menu pull-left"></span>Signature here<span class="icon-menu pull-right"></span></button>
					  		</div>
						  </div> -->
						<!--     <div class="input-drop-fild">
							<div class="input-group signatureb">
								 <span style="position:relative;" class="add-clear-span">
								  <input name="q" class="form-control expandeble"  onkeypress="this.style.width = ((this.value.length + 1) * 8) + 'px';" id="input3"  placeholder="Signature here" type="text"/>
								</span>                           
							   
							</div>
							
							<div class="input-field">
							 <input id="single" type="checkbox" class="filled-in" >
							 <label for="single">Check box</label>
					  
							</div>
						</div> -->
					  </div>
                  
                    <ul class="list-inline text-right">                     
                      <li>
                        <button type="button" id="jumpstep3" class="btn btn-primary next-step" disabled>Save and Next</button>
                      </li>
                    </ul>
                  </div>
                <div class="self-slide">  
                 <div class="pollSlider">
                 
                 <div class="main-content">
                 	
					 <div class="header-text text-center">
						 <i>Drag-Drop the fields on the PDF</i>
					 </div>
					 
					 <div class="text-center margTB20" id="draggable1">
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
        
        <!-- Profestional Information -->
        <div class="tab-pane" role="tabpanel" id="step3">
          <div class="step3">
            <section>
              <form id="step3-form">
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <h3 class="head3_1">Step 3: Enter recipient's email address</h3>
                      </div>
                    </div>
                    
					  <div class="row ">
					  
					   
					  	
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="input-field disabled">
					     		<input id="" type="text" class="validate" value="<%=registration.getEmail()%>" readonly>
								<label for="last_name">From Email Address</label>
							</div>
						</div> 
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="input-field">
						  	  <label for="file_name">Recipient Email Address<span class="redstar">*</span></label>
							  <input id="recipients" name="recipients" type="text" class="validate">
        					</div>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="input-field">
							<label for="file_name">Add CC</label>
								<input id="cc" name="cc" type="text" class="validate">
								</div>
							</div>
					 
					  
			<%-- 		 <div class="col-md-4 col-sm-4 col-xs-12">
						<div class="input-field disabled">
     					<input id="" type="text" class="validate" value="<%=registration.getEmail()%> " readonly/>
							<label for="last_name">From Email Address</label>
							</div>
							
						</div>
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="input-field" id="addrecipents">
							<label for="file_name">Recipient Email Address<span class="redstar">*</span></label>
							 <input id="recipents" name="reciepnts" onchange="checkEmailRecipentsValid();" type="text" data-role="materialtags">
           					 <span class="required" id="error_recipents" style="display:none;  color: #ff0000 !important;">Please enter valid email address </span>
							</div>
						</div>
						
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="input-field" id="addcc">
							<label for="file_name">Add CC</label>
							<input id="cc" name="cc" type="text" onchange="checkEmailCCValid();"  data-role="materialtags" />
							<span class="required" id="error_cc" style="display:none;  color: #ff0000 !important;">Please enter valid email address </span>
							<!--  <input id="cc" name="cc" type="text" class="validate"> -->
     					    <!--  <input type="text" name="tags" id="tags" value="" data-role="materialtags"/> -->
							</div>
						</div> --%>
					  </div> 
                   
					  <div class="row">
						  <div class="col-md-8 col-sm-8 col-xs-12">						  	
						  	<div class="input-field">
						  	  <label for="file_name">Subject<span class="redstar">*</span></label>
							 <input id="subject" name="subject" type="text" class="validate">
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
                       <!-- <button type="button"  class="btn btn-red font-16" onclick="checkEmailValid();">TEST</button> -->
                       <!-- <button class="btn has-spinner btn-default" type="submit">Button</button> -->
                        <button type="button"  id="skipandsend" class="btn has-spinner btn-danger" style="background: #2c3d4f;border: 1px solid transparent;text-transform: UPPERCASE;" onclick="saveDocumentPopUp('skipandsend');">Skip, Send Later!</button>
                         <!-- <button type="button"  onClick="window.location.href = 'selfSign_message.html';"  class="btn btn-primary next-step">Send</button> -->
                         <button type="button" id="send" onclick="saveSelfsign('send');" class="btn has-spinner btn-danger next-step" style="background: #00bc9c;border: 1px solid transparent;text-transform: UPPERCASE;">Send</button>
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
<!--       </form> -->
    </div></div>
    <div>

	<input  type="text" id="filename" type="text" style="display: none;" >
	<input  type="button" id="save" value="save" onclick="download()" style="display: none;"></button>
	<input type="hidden" id="fileId">

</div>
<div id="">
</div>
    <div id="show-selfsign-success" style="display:none">
    	   <div class="Content-wh-module text-center" id="success_doocument">
		   			<img src="<%=appUrl %>/images/message-bg.png"/>		   	
			  		 <h4 class="message-text text-color-burmoda" id="success-messgae"></h4>
					  <p class="font-16" style="margin-top: 50px; width: 600px; max-width: 90%;margin: 0 auto; "><span id="success-messgae-email"></span>
						   You can now check yours signed document in History > <a href="<%=appUrl %>/app/history/completedDocuments"> Completed Documents</a>.</p>
					 <a style="margin-top: 50px;" type="submit" value="GO to dashboard" href="<%=appUrl %>/app/dashboard" class="btn btn-primary font-24">Go To Dashboard</a>
		   </div>
		      
    </div>
    <div id="show-selfsign-error" style="display:none">
    	   <div class="Content-wh-module text-center" id="error_doocument">
		   			<img src="<%=appUrl %>/images/fail.png"/>		   	
			  		 <h4 class="message-text text-color-burmoda" id="error-messgae" style="color:#e83123"></h4>
					  <p class="font-16" style="margin-top: 50px; width: 600px; max-width: 90%;margin: 0 auto; "><span id="success-messgae-email"></span>
						   You can now check yours signed document in History > <a href="<%=appUrl %>/app/history/completedDocuments"> Completed Documents</a>.</p>
					 <a style="margin-top: 50px;" type="submit" value="GO to dashboard" href="<%=appUrl %>/app/dashboard" class="btn btn-primary font-24">Go To Dashboard</a>
		   </div>
		      
    </div>
</div>
    
    
    <!-- /.content --> 
  </div>
  
<jsp:include page="footer.jsp"></jsp:include>
<input type="hidden" id="docId" value=""/>
<input type="hidden" id="draftId" value=""/>
<input type="hidden" id="stepNumber" value=""/>
<input type="hidden" id="myType" value=""/>
<input type="hidden" id="drawBase64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQ0lEQVR4Xu3W0QkAIAxDQV3W/Teo4BQ+uE4QLv3InpmzHAECBAgQIECAAAECXwtsw/3rfoQjQIAAAQIECBAg8AQMd49AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDgAqC3dsd5CiH1AAAAAElFTkSuQmCC"/>
<input type="hidden" id="drawBaseIE64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAPbSURBVHhe7dZBEcAwDMCwbmDLn0H2GYj4TvqYgp+ZuQcAAFjt/QsAACxm3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAACw3jkfMvcE1ytbuLQAAAAASUVORK5CYII="/>
<input type="hidden" id="drawBaseMozilla64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAD2UlEQVR4nO3WMREAIBDAMNTi38EjgRF6lyF7x66Z2QAAwN/W6wAAAODOuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAg4AAckOtgbGrrvgAAAABJRU5ErkJggg=="/>
<
 <!--  Signatucher Tab -->
 <input type="hidden" id="drawsignature_no" value=""/>
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
						  <a class="" style="color: #252f3a" id="decline" href="#">DECLINE</a>
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

<div class="overlay-bg"></div>

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
<div class="overlaywhite_bg"></div>
<input type="hidden" id="generator" value="1" />
<input type="hidden" id="fieldshtml" value="" />
<input type="hidden" id="flag" value=""/>
<input type="hidden" id="signature" value="${signature}"/>
<input type="hidden" id="dragList" value=""/>
<input type="hidden" id="viewpagecount" value="0"/>
<input type="hidden" id="pageHeight" value="0"/>
<input type="hidden" id="numpages" value="0"/>
<input type="hidden" id="drawBase64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQ0lEQVR4Xu3W0QkAIAxDQV3W/Teo4BQ+uE4QLv3InpmzHAECBAgQIECAAAECXwtsw/3rfoQjQIAAAQIECBAg8AQMd49AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDgAqC3dsd5CiH1AAAAAElFTkSuQmCC"/>
<script type="text/javascript" language="javascript" src="<%=appUrl %>/js/jquery.mCustomScrollbar.js"></script>
<script src="<%=appUrl %>/js/file_upload.js"></script>
<script src="<%=appUrl %>/js/materialize.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.10.4/typeahead.bundle.min.js"></script>
<script src="<%=appUrl %>/js/materialize-tags.min.js"></script>
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
			url: contextPath+"app/saveDropoxChooserFile?signtype=S",
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
              console.log(files);
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
    			url: contextPath+"app/saveDropoxChooserFile?signtype=S",
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
		//	$("#jumpstep2").removeAttr('disabled');
			//alert("Hai");
			$.ajax({
				url: contextPath+"cloud/downloadFieByFileId?signtype=S",
				type: "POST",
				dataType: 'json',
			    contentType: "application/json; charset=utf-8",
			    data: JSON.stringify({ "fileId":fileId , "fileMimeType": contentType , "fileName" :fileName ,"accessToken":accessToken}),
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

//recipents email validation
function checkEmailRecipentsValid(){
	var str = $("#recipents").val();
	var str_array = str.split(',');
	 var emailErrors = [];
	 
	for(var i = 0; i < str_array.length; i++) {
	   // Trim the excess whitespace.
	   str_array[i] = str_array[i].replace(/^\s*/, "").replace(/\s*$/, "");
	   // Add additional code here, such as:
	   
	   if( !validateEmail(str_array[i])){
		   //alert('Email is not valid!'+str_array[i]);
		   emailErrors.push(str_array[i]);
		   
	   } 
	}
	if (emailErrors.length != 0) {
		$('#error_recipents').show();
	}else{
		$('#error_recipents').hide();
	}
}

function checkEmailCCValid(){
	var str = $("#cc").val();
	var str_array = str.split(',');
	 var emailErrors = [];
	 
	for(var i = 0; i < str_array.length; i++) {
	   // Trim the excess whitespace.
	   str_array[i] = str_array[i].replace(/^\s*/, "").replace(/\s*$/, "");
	   // Add additional code here, such as:
	   
	   if( !validateEmail(str_array[i])){
		   //alert('Email is not valid!'+str_array[i]);
		   emailErrors.push(str_array[i]);
		   
	   } 
	}
	if (emailErrors.length != 0) {
		$('#error_cc').show();
	}else{
		$('#error_cc').hide();
	}
}
function validateEmail($email) {
	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	  return emailReg.test( $email );
}
function loadImage() {
	$("#loader1").fadeOut("slow");
	//$(".loadImage").show();
}


function signatureopen(){
	  
	  $('.overlay-bg').show();
    $('.signature-sign').show();
	  var $slider = $('.signature-sign');
	  $slider.animate({
	   right: parseInt($slider.css('right'),10) == -350 ? 0 : 0
	  });
}
	(function($){
		  $(window).on("load",function(){
		$(".content").mCustomScrollbar({
					axis:"xy",
	
					advanced:{
						autoExpandHorizontalScroll:true
					}
				});
				
      
            //$(".content").mCustomScrollbar();
			//$(".content").resizable();
			
        });
    })(jQuery);
	
	
$(window).on("load resize", function() {
    var viewportWidth = $(window).width();
    if (viewportWidth < 768) {
		//alert('hi')
		
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
$(document).ready(function(){
	getSigntype();	
	$('.tab-pen-eraser button').click(function(){
		$(this).addClass('active_btn').siblings().removeClass('active_btn');
	});	
	
 // swal("Deleted!", "Your imaginary file has been deleted.", "success");

	
	Materialize.updateTextFields();
		   $('select').material_select();
	
	$('button.Message_popup').click(function(){
		$('.Message').show();
		$('.overlaywhite_bg').show();
	})
	
	  $('button.signature-tab').click(function() {
		  
		  
			//$('.wrapper').addClass('overlay-bg')
			$('.overlay-bg').show();
             $('.signature-sign').show();
						var $slider = $('.signature-sign');
						$slider.animate({
						 right: parseInt($slider.css('right'),10) == -350 ? 0 : 0
						});
			});
	$('.close, .overlay-bg, .overlaywhite_bg').click(function(){
		$('.signature-sign').hide();
		$('.overlay-bg').hide();
		$('.Message').hide();
		$('.overlaywhite_bg').hide();
		
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

<script>
$(document).ready(function () {
    //Initialize tooltips
    
    $('.nav-tabs > li a[title]').tooltip();
   $('[data-toggle="tooltip"]').tooltip(); 
    //step1 active
    
   	$(".loadImage").hide();
    $("#show-selfsign-success").hide();
		
   	var docName='${documentName}';
   	var docId='${docId}';
   	var draftId='${draftId}';
   	var dragList='${dragList}';
   //	alert(dragList);
   	var flag ='${flag}';
   	var stepNumber='${stepNumber}';
   	var increment='${increment}';
   	if(flag == "103"){
   		$("#show-selfsign-steps").hide();
		$("#skippopup").hide();
		$("#show-selfsign-error").show();
		$("#error-messgae").empty();
		$("#error-messgae").append('The document has signed previously.');
   	}else if(flag == 'invalid'){
   		$("#show-selfsign-steps").hide();
		$("#skippopup").hide();
		$("#show-selfsign-error").show();
		$("#error-messgae").empty();
		$("#error-messgae").append('Invalid Link');
   	}else{
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
			
	   	}
		if(stepNumber == 1){
			$("#steplist1").removeClass('disabled');
	   	    $("#steplist1").addClass('active');
	   	    $("#step1").removeClass('disabled');
	   	    $("#step1").addClass('active');
	   	 	$("#jumpstep2").removeAttr('disabled');
	   	    $(".progress-bar").css("width", "100%");
	   	}
		else if(stepNumber == 2){
	   		$("#steplist2").removeClass('disabled');
	   	    $("#steplist2").addClass('active');
	   	    $("#step2").removeClass('disabled');
	   	    $("#step2").addClass('active');
	   		var count=$("#viewpagecount").val();
	   	    jumpstep2(count);
	   		jumpstep3(2);
	   		checkFields();
	   	}
		else if(stepNumber == 3){
			$("#steplist3").removeClass('disabled');
	   	    $("#steplist3").addClass('active');
	   	    $("#step3").removeClass('disabled');
	   	    $("#step3").addClass('active');
	   	}else{
	   		$("#steplist1").removeClass('disabled');
	   	    $("#steplist1").addClass('active');
	   	    $("#step1").removeClass('disabled');
	   	    $("#step1").addClass('active');
	   	}
   	}
   		//alert(increment);
	   
   	
   		
  
  	//alert('DRAG'+dragList);
   	//alert(docId);
   	
    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
        var $target = $(e.target);   
        if ($target.parent().hasClass('disabled')) {
            return false;
        } 
		if(e.currentTarget.hash =="#step1"){
			
			$(".progress-bar").css("width", "100%");
			$("#jumpstep2").removeAttr('disabled');
			//alert('Step1');	
	    }if(e.currentTarget.hash =="#step2"){
	    	//alert('Step2');
	    	var count=$("#viewpagecount").val();
	    	jumpstep2(count);
	    	
	    	checkFields();
	    	
		}if(e.currentTarget.hash =="#step3"){
			//alert('Step3');
			jumpstep3(2);
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
	  
	/* $('.square_2').on('click', function(){
    $('.square_2.active').removeClass('active');
    $(this).addClass('active');
	
	$('.row_4').show('.square_2.active#test12'); 
	  });*/
	//$('.row_4').hide('.square_2 #test12');
      </script> 
<!--  Upload and Drag script  --> 
<script>
function saveUploadSignature(){
	var id=$("#drawsignature_no").val();
	var sign = $('img[id="blah"]').attr('src');
	var fileInput = document.getElementById('imgInp');
	if(sign == ''){
		$("#file_error").show();
    	$("#file_error").html('Please upload a picture of your signature.').fadeOut(10000);;
        fileInput.value = '';
	}else{
		$(".signature-sign").hide();
		$('.overlay-bg').hide();
			
		 $("#field"+id).attr('type', 'image'); 
		 $("#field"+id).attr('src', sign);
		 $("#field"+id).removeClass('form-control');
		 $("#signature").val(sign);
	
	}
}
function saveTypeSignature(){
	var id=$("#drawsignature_no").val();
    var sign = $("#myType").val();
	var typeSign=$("#typeName").val();
	var check=validationSignature1(sign,typeSign,"type");
	if(check ==true){
		$(".signature-sign").hide();
		$('.overlay-bg').hide();
	
		 $("#field"+id).attr('type', 'image'); 
		 $("#field"+id).attr('src', sign);
		 $("#field"+id).removeClass('form-control');
			$("#signature").val(sign);
	
	}
}
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
var typeValue=$("#typeName").val();
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
     global: false,
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
     global: false,
     error : function(e) {  
      alert('Error: ' + e);   
     }  
 });  
}
	

                 
      
      
  $(window).on("load resize", function(e) {
      var viewportWidth = $(window).width();
      if (viewportWidth < 769) {
      (function($) {
 		$("body").addClass('sidebar-collapse');
      })(jQuery);
		} else {
      $("body").removeClass('sidebar-collapse');
      }
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


$('#decline').click(function(){
	//$('.save-signature-box').hide();
	    $('.signature-sign').hide();
		$('.overlay-bg').hide();
		$('.Message').hide();
		$('.overlaywhite_bg').hide();
	 //return false;
}); 

//Draw Signature
function openMySignature(id){
	$("#drawsignature_error").hide();
	$("#signature-type-error").hide();
	$(".thumbnail").removeClass('selected');
	zkSignature.clear();
	$('.overlay-bg').show();
	$("#sType").removeClass('active');
	$("#type").removeClass('active');
	$("#sDraw").addClass('active');
	$("#draw").addClass('active');
	$("#uType").removeClass('active');
	$("#upload").removeClass('active');
	$("#blah").attr('src', '');
	$("#show_upload_signature").show();
	$("#blah").hide();
	document.getElementById("imgInp").value = "";
	$("#myType").val('');
	$('.signature-sign').show();
		var $slider = $('.signature-sign');
		$slider.animate({
		 right: parseInt($slider.css('right'),10) == -350 ? 0 : 0
	});
		
	$("#drawsignature_no").val(id);	
		
}
$("#saveSignature").click(function(){
	var id=$("#drawsignature_no").val();
	
	var canvas = document.getElementById("newSignature");
	// save canvas image as data url (png format by default)
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
		
		$("#drawsignature_error").show();
	}else{
	 $("#field"+id).attr('type', 'image'); 
	 $("#field"+id).attr('src', dataURL);
	 $("#field"+id).removeClass('form-control');
	 $(".signature-sign").hide();
		$('.overlay-bg').hide();
		$("#signature").val(dataURL);
	}
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
	  $("#input-drop-fild"+id).remove();
	  jumpstep3(2);
	  checkFields();
	  
  }
 
  function selfSignAll(){
	  var valid = $("#step3-form").valid();
	  alert(valid)
	  if(valid == true){
		
	   }
	  
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
<script>
/*global window, $ */
$(function () {
    'use strict';
    // Change this to the location of your server-side upload handler:
    var contextPath=$("#contextPath").val();
    var url = "app/fileUpload?signtype=S";
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
	 jumpstep3(2);
	 checkFields();
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

function jumpstep2(count){
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
	var info = "?docId="+docId+"&fileName="+fileName+"&draftId="+draftId+"&flag="+flag+"&step=2";
	$.ajax({
		//contentType : 'application/json; charset=utf-8',
		type : "GET",
		url : contextPath+"app/getDocument"+info,
		//dataType : 'json',
		//data : JSON.stringify(data),
		async:false,
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
			if(response == '103'){
        		$("#show-selfsign-steps").hide();
        		$("#skippopup").hide();
        		$("#show-selfsign-error").show();
        		$("#error-messgae").empty();
        		$("#error-messgae").append('The document has signed previously.');
        	}else if(response == "invalid"){
        		$("#show-selfsign-steps").hide();
        		$("#skippopup").hide();
        		$("#show-selfsign-error").show();
        		$("#error-messgae").empty();
        		$("#error-messgae").append('Invalid Link');
			}else {
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
					$("#stepNumber").val(2);
					//var test1='<div class="dragMe drgfields ui-draggable ui-draggable-dragging ui-draggable-handle" style="padding: 0px; position: absolute; left: 154.25px; top: 60px;" data-signer-id="1" data-document-id="1" id="fieldPosition1"><span>Name</span><span class="closeIt">x</span><input type="text" id="field1" class="selfsign-control" onchange="getfieldValue(this.value,1)" value="asdasd" name="name" required=""></div><div class="dragMe ui-draggable ui-draggable-handle ui-draggable-dragging" data-signer-id="1" data-document-id="1" style="position: absolute; left: 422px; top: 31.4844px;" id="fieldPosition1"><span>Name</span><span class="closeIt">x</span><input type="text" id="field1" class="selfsign-control" onchange="getfieldValue(this.value,1)" value="" name="name" required=""></div>';
					
					//setTimeout(function(){
						//$("#document-reader").append(test1);
						
					//},1000);
					 
				}else{
					alert('failed')
				}
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
			//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group name"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><span style="position:relative;" class="add-clear-span"><input name="name" type="text" class="form-control" id="field'+uniqueGenerator+'" onchange="getfieldValue(this.value,'+uniqueGenerator+')" placeholder="Name" value="'+fullname+'" type="text"></span><span class="input-group-btn"></span></div></div>');
			//dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
			
        	$("#"+droppableId).append(ui.helper.clone().html('<div class="input-drop-fild" id="input-drop-fild'+uniqueGenerator+'"><div class="input-group name"><a class="closeIt hideIt" style=" text-decoration: none;" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><span style="position:relative;" class="add-clear-span"><input name="name" type="text" class="form-control" id="field'+uniqueGenerator+'"  data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+' onchange="getfieldValue(this.value,'+uniqueGenerator+')" placeholder="Name" value="'+fullname+'" type="text"></span><span class="input-group-btn"></span></div></div>'));
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
			//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group date"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="date" type="text" class="form-control " onchange="getfieldValue(this.value,'+uniqueGenerator+')" id="field'+uniqueGenerator+'" placeholder="Date.." value="'+today+'"  type="text" readonly></span><span class="input-group-btn"</span></div></div>');
			//dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
			$("#"+droppableId).append(ui.helper.clone().html('<div class="input-drop-fild" id="input-drop-fild'+uniqueGenerator+'"><div class="input-group date"><a class="closeIt hideIt" style=" text-decoration: none;"  onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="date" type="text" class="form-control " onchange="getfieldValue(this.value,'+uniqueGenerator+')" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+' placeholder="Date.." value="'+today+'"  type="text" readonly></span><span class="input-group-btn"</span></div></div>'));
  			$(".dragMe").removeClass("btn btn-light-yellow margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
  			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
			
			
		}else if (document_id == 1 && signer_id == 3) {
			var signature=$("#signature").val();
			
			/* if(signature !=''){
				
				dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group signatureb"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="signature" type="image"  id="field'+uniqueGenerator+'" onclick="openMySignature('+uniqueGenerator+')" class="" placeholder="Signature here" src="'+signature+'" readonly></span><span class="input-group-btn"></span></div></div>');
			}else{
				
				dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group signatureb"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="signature" type="text"  id="field'+uniqueGenerator+'" onclick="openMySignature('+uniqueGenerator+')" class="form-control" placeholder="Signature here"  readonly></span><span class="input-group-btn"></span></div></div>');
			}
			dragEl.attr('id', 'fieldPosition'+uniqueGenerator+''); */
			if(signature !=''){
				
				//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group signatureb"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="signature" type="image"  id="field'+uniqueGenerator+'" onclick="openMySignature('+uniqueGenerator+')" class="" placeholder="Signature here" src="'+signature+'" readonly></span><span class="input-group-btn"></span></div></div>');
				$("#"+droppableId).append(ui.helper.clone().html('<div class="input-drop-fild" id="input-drop-fild'+uniqueGenerator+'"><div class="input-group signatureb"><a class="closeIt hideIt" style=" text-decoration: none;" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="signature" type="image"  id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+' onclick="openMySignature('+uniqueGenerator+')" class="" placeholder="Signature here" src="'+signature+'" readonly></span><span class="input-group-btn"></span></div></div>'));
			}else{
				
				//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group signatureb"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="signature" type="text"  id="field'+uniqueGenerator+'" onclick="openMySignature('+uniqueGenerator+')" class="form-control" placeholder="Signature here"  readonly></span><span class="input-group-btn"></span></div></div>');
				$("#"+droppableId).append(ui.helper.clone().html('<div class="input-drop-fild" id="input-drop-fild'+uniqueGenerator+'"><div class="input-group signatureb"><a class="closeIt hideIt" style=" text-decoration: none;" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="signature" type="text"  id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'  onclick="openMySignature('+uniqueGenerator+')" class="form-control" placeholder="Signature here"  readonly></span><span class="input-group-btn"></span></div></div>'));
			}
			
			
  			$(".dragMe").removeClass("btn btn-light-Bermuda margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
  			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
		}else  if (document_id == 1 && signer_id == 4) {
        	//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group text"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="text" type="text" class="form-control expandeble" onchange="getfieldValue(this.value,'+uniqueGenerator+')" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);"  id="field'+uniqueGenerator+'" placeholder="Text" value="" ></span><span class="input-group-btn"></span></div></div>');
			//dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
			$("#"+droppableId).append(ui.helper.clone().html('<div class="input-drop-fild" id="input-drop-fild'+uniqueGenerator+'"><div class="input-group text"><a class="closeIt hideIt" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="text" type="text" class="form-control expandeble" onchange="getfieldValue(this.value,'+uniqueGenerator+')" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);"  id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+' placeholder="Text" value="" ></span><span class="input-group-btn"></span></div></div>'));
  			$(".dragMe").removeClass("btn btn-light-purple margB20")
  			$("#signer-1").addClass("btn btn-light-oragne margB20");
  			$("#signer-2").addClass("btn btn-light-yellow margB20");
  			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
  			$("#signer-4").addClass("btn btn-light-purple margB20");
  			/* $("#signer-5").addClass("btn btn-light-Bermuda margB20"); */
  			$("#signer-6").addClass("btn btn-light-brown margB20");
  			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
			
		}else  if (document_id == 1 && signer_id == 5) {
    		dragEl = ui.helper.clone().html('<div class="input-drop-fild" id="input-drop-fild'+uniqueGenerator+'"><div class="input-field"><input name="checkbox" id="field'+uniqueGenerator+'" type="checkbox"  class="filled-in" checked><label for="single" ></label><span class="icon-close" onclick="hideTextbox('+uniqueGenerator+')"></span></div></div>');
			dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
		}else  if (document_id == 1 && signer_id == 6) {
    		var firstname=$("#firstName").val();
			//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group initials"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="initials" type="text" class="form-control expandeble" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);" onchange="getfieldValue(this.value,'+uniqueGenerator+')"  id="field'+uniqueGenerator+'" placeholder="Text" value="'+firstname+'" ></span><span class="input-group-btn"></span></div></div>');
			//dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
    		$("#"+droppableId).append(ui.helper.clone().html('<div class="input-drop-fild" id="input-drop-fild'+uniqueGenerator+'"><div class="input-group initials"><a class="closeIt hideIt" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="initials" type="text" class="form-control expandeble" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);" onchange="getfieldValue(this.value,'+uniqueGenerator+')"  id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+' placeholder="Text" value="'+firstname+'" ></span><span class="input-group-btn"></span></div></div>'));
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
        
        
        
        // debug current dropped position
        //alert("top: " + topPosition + ", left: " + leftPosition); 
      //  dragEl.data("signer-id", signer_id);

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
   /*      dragEl.removeClass("dragSigners col-sm-6 parent");
        dragEl.find("span.closeIt").removeClass("hideIt");
        dragEl.appendTo('#document-reader'); */
        jumpstep3(2);
        // update draged element position to database
        // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)
		checkFields()
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
           jumpstep3(2);
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
function jumpstep3(stepNumber){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	$("#fieldshtml").val("");
	var fieldsHTML = "";
	$(".drop > .dragMe").each(function() {
		fieldsHTML += $(this).prop("outerHTML");
	});
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
			 "signType":"S"
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
        	if(response == '103'){
        		$("#show-selfsign-steps").hide();
        		$("#skippopup").hide();
        		$("#show-selfsign-error").show();
        		$("#error-messgae").empty();
        		$("#error-messgae").append('The document has signed previously.');
        	}else if(response == "invalid"){
        		$("#show-selfsign-steps").hide();
        		$("#skippopup").hide();
        		$("#show-selfsign-error").show();
        		$("#error-messgae").empty();
        		$("#error-messgae").append('Invalid Link');
			}else{
	         	if(response != 'failed'){
	        			//alert("success");
	        			$("#stepNumber").val(3);
	            }else{
	            	alert('failed');
	            }
        	}
		},
		 error : function(e) {  
		    alert('Error: ' + e);   
		}  
	 });
}

function saveSelfsign(type){
	
	var checkError = true; 
	if( type == "send"){
		checkError= $("#step3-form").valid();
	}
	if(checkError != false){
		
		$('#skippopup').hide();
		$('.overlaywhite_bg').hide();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		var generatorLength=$("#generator").val();
		var docId=$("#docId").val();
		var draftId=$("#draftId").val();
		var stepNumber=$("#stepNumber").val();
		var fileName=$(".file-upload-input").val();
		var to=$("#recipients").val();
		var cc=$("#cc").val();
		var subject=$("#subject").val();
		var message=$("#message").val();
		var pageHeight=$("#pageHeight").val();
		var numpages=$("#numpages").val();
		var jsonArray = [];
		for(var i=1; i<generatorLength; i++) {
			var item = {};
		  	var fieldType=$("#field"+i).attr("type");
			if(fieldType !=null && fieldType !=undefined){
				if(fieldType=="text"){
					item ['type'] = type;
					item ['stepNumber'] = stepNumber;
					item ['docId'] = docId;
					item ['draftId'] = draftId;
					item ['documentName'] = fileName;
					item ['top'] =$("#field"+i).attr("data-top");
					item ['left'] = $("#field"+i).attr("data-left");
					item ['fieldType'] = $("#field"+i).attr("type");
					item ['fieldName'] = $("#field"+i).attr("name");
					item ['pageHeight']= pageHeight;
					item ['numpages']= numpages;
					item ['fieldWidth']= "100";
					item ['fieldHeight']= "30";
					item ['fieldValue'] = $('#field'+i).val();
					item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					item ['userId'] = 1;
					item ['to'] = to;  
					item ['cc'] = cc;  
					item ['subject'] = subject;  
					item ['message'] = message;  
				}else if(fieldType=="image"){
					item ['type'] = type;
					item ['stepNumber'] = stepNumber;
					item ['docId'] =docId
					item ['draftId'] = draftId;
					item ['documentName'] = fileName;
					var sign = document.getElementById('field'+i);
					var signature = sign.getAttribute('src');
					item ['top'] =$("#field"+i).attr("data-top");
					item ['left'] = $("#field"+i).attr("data-left");
					item ['fieldName'] = "signature"
					item ['pageHeight']= pageHeight;
					item ['numpages']= numpages;
					item ['fieldType'] = "image";
					item ['fieldValue'] = signature;
					item ['fieldWidth']= "100";
					item ['fieldHeight']= "36";
					item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					item ['userId'] = 1;  
					item ['to'] = to;  
					item ['cc'] = cc;  
					item ['subject'] = subject;  
					item ['message'] = message;  
				}else if(fieldType=="checkbox"){
					item ['type'] = type;
					item ['stepNumber'] = stepNumber;
					item ['docId'] =docId
					item ['draftId'] = draftId;
					item ['documentName'] = fileName;
					var sign = document.getElementById('field'+i);
					var signature = sign.getAttribute('src');
					item ['top'] =$("#field"+i).attr("data-top");
					item ['left'] = $("#field"+i).attr("data-left");
					item ['fieldName'] = "signature"
					item ['pageHeight']= pageHeight;
					item ['numpages']= numpages;
					item ['fieldType'] = "checkbox";
					item ['fieldValue'] = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAQAAABpN6lAAAABNElEQVR4Ae3QsVHEQBAF0TGhCgWkDAQX2iVzJhCAksHDkrcYG8CfwoLe7klg3i8zMzMzMzMzMzMzMzMzM/uPvdTS3eqr9pX5V436rn1l/qBPkPn4CTIfP0Hm4yfIfPgEmT/vfW3+WZv8Xydfvnz58uXLly9fvnz58uXLly9fvnz58uXLl/9UjzpW5n/UqKuOlfkjT0Dn5wmQ/M/5UJ6AyH+e/DwBn58nQPFn9/lQmADJn2115gm4/P4EWH5/Aiy/M8Erm9+fAMvvT4Dl9yfA8vsTYPmdCd7Y/P4EWH5/Aiy/PwGW358Ay+9NgOZ3JoDz8wSZz58g8/kTZD5/gsznT5D5/Akynz0BnJ8moPPDBHR+mIDODxPQ+WECOj9MAOeHCQIf3/Y3+GZmZmZmZmZmZmZmZmY/MrUQ01ASaE0AAAAASUVORK5CYII=";
					item ['fieldWidth']= "100";
					item ['fieldHeight']= "36";
					item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
					item ['userId'] = 1;  
					item ['to'] = to;  
					item ['cc'] = cc;  
					item ['subject'] = subject;  
					item ['message'] = message;  
				}
				
				jsonArray.push(item);
			}
		}
		var btn;
		if(type =='skipandsend'){
			btn='#skipandsend';
		}else{
			btn='#send';
		}
		
		$.ajax({
			type : "POST",
			url : contextPath+"app/saveSelfsign",
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
	        	if(response == '103'){
	        		$("#show-selfsign-steps").hide();
	        		$("#skippopup").hide();
	        		$("#show-selfsign-error").show();
	        		$("#error-messgae").empty();
	        		$("#error-messgae").append('The document has signed previously.');
	        	}else if(response == "invalid"){
	        		$("#show-selfsign-steps").hide();
	        		$("#skippopup").hide();
	        		$("#show-selfsign-error").show();
	        		$("#error-messgae").empty();
	        		$("#error-messgae").append('Invalid Link');
				}else{
	         	if(response != 'failed'){
	        			//alert("success");
	        			$("#show-selfsign-steps").hide();
	        			$("#skippopup").hide();
	        			$("#show-selfsign-success").show();
	        			if(type == 'send'){
	        				$("#success-messgae").html('Message sent successfully!');
	        				$("#success-messgae-email").html('Message sent successfully to the '+to+' email address.');
	        					
	        				//$("#success-messgae-email").html('Message sent successfully to the sanket.navle@banctec.in email address.');
	        			}else{
	        				$("#success-messgae").html('You have signed document successfully!');
	        			}
	        			$("#stepNumber").val(3);
	            }else{
	            	alert('failed');
	            }
	          }
			},
			 error : function(e) {  
			    alert('Error: ' + e);   
			}  
		 });
	}
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

 var step3Form=$("#step3-form").validate({
		//specify the validation rules
		errorElement: 'p',
    	errorClass: 'error',
		rules: {
			recipients: {
	     		required: true,
	     	    multiemail:true,
	     		},
	     	cc:{
	     		 multiemail:true
	     	},	
			subject:"required",
			message:"required",
		},
		//specify validation error messages
		messages: {
			subject: "Please enter a subject",
			message: "Please enter a message",
			recipients:{
	    		 required: "Please enter a valid email address"
	    	 },
			cc:{
	    		 required: "Please enter a valid email address"
	    	},
		}
});

 
 
 function checkFields(){
	 var generatorLength=$("#generator").val();
	// alert('asdasd');
	 var array = [];
			
	 for(var i=1; i<=generatorLength ; i++) {
		 var fieldType=$("#field"+i).attr("name");
		 if(fieldType !=null && fieldType != undefined){
			 var item = {};
			 	if (fieldType == "name" || fieldType == 'date' || fieldType == 'initials' || fieldType == 'text'){
				 item ['fieldType'] = fieldType;
				 item ['fieldValue'] = $('#field'+i).val();
			 	}
			 	if(fieldType =='signature'){
			 		var sign = document.getElementById('field'+i);
					var signature = sign.getAttribute('src');
			 		item ['fieldType'] = fieldType;
					item ['fieldValue'] = signature;
			 	}
			 	if(fieldType == 'checkbox'){
			 		item ['fieldType'] = fieldType;
					item ['fieldValue'] =  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAQAAABpN6lAAAABNElEQVR4Ae3QsVHEQBAF0TGhCgWkDAQX2iVzJhCAksHDkrcYG8CfwoLe7klg3i8zMzMzMzMzMzMzMzMzM/uPvdTS3eqr9pX5V436rn1l/qBPkPn4CTIfP0Hm4yfIfPgEmT/vfW3+WZv8Xydfvnz58uXLly9fvnz58uXLly9fvnz58uXLl/9UjzpW5n/UqKuOlfkjT0Dn5wmQ/M/5UJ6AyH+e/DwBn58nQPFn9/lQmADJn2115gm4/P4EWH5/Aiy/M8Erm9+fAMvvT4Dl9yfA8vsTYPmdCd7Y/P4EWH5/Aiy/PwGW358Ay+9NgOZ3JoDz8wSZz58g8/kTZD5/gsznT5D5/Akynz0BnJ8moPPDBHR+mIDODxPQ+WECOj9MAOeHCQIf3/Y3+GZmZmZmZmZmZmZmZmY/MrUQ01ASaE0AAAAASUVORK5CYII=";
			 	}
			 	array.push(item);
		}
	 }
	 if(array.length == 0){
		  $("#jumpstep3").attr('disabled','disabled');
	 }else{
	 	 $.each(array, function( key, value ) {
			  
			 if( value.fieldValue == ''){
				 //alert("FIELD VALUE "+value.fieldValue)	  
				  $("#jumpstep3").attr('disabled','disabled');
			  }else{
				 // alert("EMPTY VALUE "+value.fieldValue)
				  $("#jumpstep3").removeAttr('disabled');
			  }
		});
	 }
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

</body>
</html>