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
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>${title} | DrySign</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/fonts_icon.css">
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/inner_page.css" />
    <link rel="stylesheet" href="css/api.css" />
     <link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
      body {
          background: #eee;
   		  height: 100vh;
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
    z-index: auto !important;
}
.dragMe{
    position: relative;
}
	.document-reader img {
	  /*  border: 1px solid #c5c5c5;*/
	    overflow: auto;
	    display: block;
	}
	.PDF_View {
 	   border: 1px solid #bfb4b4 !imporant;
	}
	.render-image{
	border: 1px solid #d4d4d4;
	}
	.pdf_view2 {
    border-radius: 3px;
    overflow: auto;
	}
	
		 .inner-header {
    background: #00b497;
    height: 80px;
    border-radius: 0;
    margin: 0;
    border: 0;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 99999;
}
		
 .doc-width {
   	width: 816px;
   	float: left;
}
	.drop-select .closeIt {
    font-size: 8px;
    width: 15px;
    height: 15px;
    background: #000000;
    border-radius: 50%;
    color: #fff;
    box-shadow: none;
    text-shadow: none;
    padding: 2px 4px;
    position: absolute;
    top: 3px;
    right: -15px;
    z-index: 2;
}
.PDF_Main {
    position: relative;
    margin-top: 120px;
    margin-bottom: 110px;
}

 .loader {
   	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=appUrl %>/images/spin.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
	
 } 
 
.pollSlider {
    top: 118px;
    position: fixed;
    z-index: 3 !important;
}
#pollSlider-button {
	z-index: 2 !important;
}

		
    </style>
</head>

<body class="skin-blue">
<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
<input type="hidden" id="key" value="<%=request.getParameter("key") %>"/>
<input type="hidden" id="signerListSize" value="${signerListSize}"/>
<input type="hidden" id="docId" value="${docId}"/>
    <!-- Main Header -->
    <!-- Logo -->
    <div id="loader1" class="loader"><p>Loading document, Please wait !</p></div>
    <nav class="navbar navbar-default inner-header">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="pull-left">
                <a class="navbar-brand" href="#"><img src="<%=appUrl %>/images/1.0/logo_inner.png" /></a>
            </div>
            <div class="pull-right">
                <!--<button type="button" class="btn PDF-btn-red" value="Guide Me">Guide Me</button>-->
                <button type="button" id="step3-button" class="btn PDF-btn-pri" onclick="savePrepareDocument();" value="Submit" disabled>Submit</button>

            </div>
        </div>
    </nav>
    <!-- Content Wrapper. Contains page content -->
    <!-- breadcrumb -->
    <!-- Main content -->
    <div class="container-fluid" style="margin-top: 144px;display: none;" id="success_content">
  		<div class="Content-wh-module text-center">
		   			<img src="<%=appUrl %>/images/message-bg.png"/>		   	
				   <h4 class="message-text text-color-burmoda" id="success-messgae"></h4>
				   <%String prepareReturnURL=request.getParameter("prepareReturnURL"); %>
				   <c:choose>
					    <c:when test="${empty prepareReturnURL}">
					    </c:when>    
					    <c:otherwise>
					       <a href="${prepareReturnURL}" style="margin-top: 50px;" class="btn btn-primary font-24">OK</a>
					    </c:otherwise>
					</c:choose>
				   
		   </div>   
  	</div>
    <div class="container-fluid" style="margin-top: 144px;display: none;" id="error_content" >
  		<div class="Content-wh-module text-center">
		   			<img src="<%=appUrl %>/images/fail.png"/>		   	
			  		<h4 class="message-text text-color-burmoda" id="error-messgae" style="color:#e83123" style="display:none"></h4>
			   	   <!--  <button style="margin-top: 50px;" type="button" onClick="window.location.href = 'index.html';" value="GO to dashboard" class="btn btn-primary font-24">Go To Login</button> -->
		   </div>   
  	</div>
    <section id="open_document_content">
    	
        <div class=" PDF_Main ">
        <!-- <p class="text-center"><span class="label label-warning" id="signerSize">3 Signnee's -Drag-Drop the signature fields on the PDF for each signnee's to enable button </span></p> -->
           <!-- <div class="alert alert-info margTB20" style="margin: 0 auto;width: 890px;max-width: 90%;">
                Please put the required fields for all signees and sign this document. All the signees need to sign this documents. You will be notified in your mailbox once all the signees are done signing.
            </div>
            <br/>-->
           <div class="container-fluid">
			  <div class="row">
				  <div class="col-md-1"></div>
				  <div class="doc-width">
                <div class="pdf_view2"  >
				
                    <div class="document-reader" id="document-reader" style="padding-left: 0px;">
                        <div id='draggable-signature' class="fixed">
                            <!-- <img width="890px" height="1152px" class="render-image" src="img/PDF_view.jpg">
                            <div class="page-number">1</div>

                            <img width="890px" height="1152px" class="render-image" src="img/PDF_view.jpg">
                            <div class="page-number">2</div>

                            <img width="890px" height="1152px" class="render-image" src="img/PDF_view.jpg">
                            <div class="page-number">3</div>  -->
                        </div>
                    </div>
                </div>
          
            <div class="self-slide hidden-xs">
                <div class="pollSlider" style="z-index:3px !important;">
                    <div class="main-content" style="display: none;">
                        <div class="header-text text-center">
                            <i>Drag-Drop the fields on the PDF</i>
                        </div>
                        <div class="text-center margTB20" id="draggable1">
                        	<ul style="display:none">
								<c:forEach var="s" items="${signerList}" varStatus="loop" >
									<li data-name="${s.signerId}" id="signer_${loop.index}"> ${s.signerName}</li>
								</c:forEach>
							</ul>
                            <div id="signer-1" class="dragMe dragSigners btn btn-light-oragne margB20" data-signer-id="1" data-document-id="1">
                                <span class="icon-menu pull-left"></span>NAME<span class="icon-menu pull-right"></span>
                            </div>

                            <div id="signer-2" class="btn btn-light-yellow margB20 dragMe dragSigners" data-signer-id="2" data-document-id="1">
                                <span class="icon-menu pull-left"></span>DATE<span class="icon-menu pull-right"></span>
                            </div>

                            <div id="signer-3" class="btn btn-light-Bermuda margB20 dragMe dragSigners" data-signer-id="3" data-document-id="1">
                                <span class="icon-menu pull-left"></span>SIGNATURE<span class="icon-menu pull-right"></span>
                            </div>
                        </div>
                        
                    </div>
                </div>
                <div id="pollSlider-button" style="margin-right: 0px;"><span class="icon-arrow_left"></span></div>
            </div>
            <!--<div class="PDF_arrow">
                <img src="img/PDF_arrow.png" />
            </div>-->
        </div>

        <div class="fixed-action-btn click-to-toggle visible-xs">
            <a class="btn-floating btn-circle "><i class="glyphicon glyphicon-plus"></i></a>
            <ul>
               <!--  <li>
                     <a class="btn-floating"  onclick="saveDragAndDropMobileFields('Name');"> <button id="m_name" class="btn btn-light-oragne">
                     <span class="icon-menu pull-left "></span>NAME<span class="icon-menu pull-right "></span></button></a>
                </li>
                <li>
                    <a class="btn-floating"  onclick="saveDragAndDropMobileFields('Date');"> <button id="m_date" class="btn btn-light-yellow ">
                     <span class="icon-menu pull-left "></span>DATE<span class="icon-menu pull-right "></span></button></a>
                </li>
                <li><a class="btn-floating"  onclick="saveDragAndDropMobileFields('Signature');"><button id="m_signature" class="btn btn-light-Bermuda ">
					<span class="icon-menu pull-left "></span>SIGNATURE<span class="icon-menu pull-right "></span></button></a>
				</li> -->
             </ul>
        </div>
        </div>
				</div>
			</div>
    </section>
    <!-- /.content-wrapper -->
    <!-- Main Footer -->
    <!--/.Footer -->
    <div class="footer ">
        <div class="row ">
            <div class="col-xs-12 text-center ">
              <span class="icon-language"></span> ENGLISH  |  Copyright ©
                <script>
                    document.write(new Date().getFullYear())
                </script>, Exela Technologies Inc., All Rights Reserved.
            </div>
        </div>
    </div>
    <!--  Signatucher Tab -->
    <div class="overlay-bg"></div>
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
 <script src="<%=appUrl %>/js/jquery.min.js"></script>
 <script src="<%=appUrl %>/js/jquery-ui.js"></script>
 <script src="<%=appUrl %>/js/bootstrap.min.js"></script>
 <script src="<%=appUrl %>/js/app.min.js"></script>
 <script src="<%=appUrl %>/js/materialize.js"></script>
 <script src="<%=appUrl %>/js/jquery-ui.min.js"></script>
 <script src="<%=appUrl %>/js/jquery.ui.touch-punch.min.js"></script>
 <!-- Loader -->
 <script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
 <script>$('#widget').draggable();</script>
 <script>
 	
/* $(window).load(function() { // better to use $(document).ready(function(){
    $('.render-image').on('click touchstart', function(e) {
	
        var offset = $("#document-reader").offset();
		var relativeX = (e.pageX - offset.left);
		var relativeY = (e.pageY - offset.top);
		//alert(relativeX+':'+relativeY);
        $("#document-reader").append('<div class="drop-select"><span class="glyphicon glyphicon-move"></span><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox(1)" href="#clear"><span class="icon-close"></span></a><a data-signer="name" class="btn btn-default btn-select name" id="field1"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue1" value="1"><input type="hidden" class="btn-select-input" id="fieldvalue1" value="sanket"><input type="hidden" class="btn-select-email" id="fieldemailvalue1" value="sanket.navale@banctec.in"><span class="btn-select-value">Name</span><span class="btn-select-arrow fa fa-angle-down"></span><ul style="display: none;"><li data-name="1" id="sanket.navale@banctec.in">sanket</li><li data-name="1" id="sanket.navale@banctec.in">sanket1</li></ul></a></div>');
    });
}); */

function showPopover(number){
$("#field"+number).popover('show');
}
$(document).ready(function() {
    $('#pollSlider-button').click(function() {
        $('#pollSlider-button span').toggleClass("icon-arrow_left icon-arrow_right");
        //$(this).find($("span")).removeClass('icon-arrow_left').addClass('icon-arrow_right');
        $('.main-content').css('display', 'block');
        // alert($(this).css("margin-right"))
        if ($(this).css("margin-right") == "200px") {
            $('.pollSlider').animate({
                "margin-right": '-=200'
            });
            $('#pollSlider-button').animate({
                "margin-right": '-=200'
            });
            $('.main-content').css('display', 'none');
        } else {
            $('.pollSlider').animate({
                "margin-right": '+=200'
            });
            $('#pollSlider-button').animate({
                "margin-right": '+=200'
            });
            $('.main-content').css('display', 'block');
        }
    });
});
    //  Materialize.updateTextFields();
$('select').material_select();
$('.fixed-action-btn').openFAB();
$('.fixed-action-btn').closeFAB();
$('.fixed-action-btn.toolbar').openToolbar();
$('.fixed-action-btn.toolbar').closeToolbar();
  </script>
 <script src="<%=appUrl %>/js/jquery.ui.touch-punch.min.js"></script>
 <script>
$('#widget').draggable();
 </script>
 <script>
/* function openPopUpSignees() {
    alert('TEST')
} */

$(document).on('touchstart', '.render-image', function (e) {
	
	
	var field=$("#select_mobile_field").val();
	
	var offset = $("#document-reader").offset();
	
	var xPos = e.originalEvent.touches[0].pageX;
	var yPos = e.originalEvent.touches[0].pageY;
	var relativeX = (xPos - offset.left);
	var relativeY = (yPos - offset.top);
	//alert(relativeX+':'+relativeY);
	var uniqueGenerator = $("#generator").val();
	if(field == 'Name'){
		$("#document-reader").append('<div class="dragMe ui-draggable ui-draggable-handle ui-draggable-dragging" data-signer-id="1" data-document-id="1" style="position: absolute; left: '+relativeX+'px; top: '+relativeY+'px;" id="fieldPosition'+uniqueGenerator+'"><div class="drop-select"><a data-signer="name" class="btn btn-default btn-select name" id="field'+uniqueGenerator+'" style="min-width: 176px;"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'" value=""><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'" value=""><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'" value=""><span class="btn-select-value">Name</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div></div>');
	}
	if(field =='Date'){
		$("#document-reader").append('<div class="dragMe ui-draggable ui-draggable-handle ui-draggable-dragging" data-signer-id="2" data-document-id="1" style="position: absolute; left: '+relativeX+'px; top: '+relativeY+'px;" id="fieldPosition'+uniqueGenerator+'"><div class="drop-select"><a data-signer="date" class="btn btn-default btn-select date" id="field'+uniqueGenerator+'" style="min-width: 176px;"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'" value=""><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'" value=""><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'" value=""><span class="btn-select-value">Date</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div></div>');
	}
	if(field == 'Signature'){
		$("#document-reader").append('<div class="dragMe ui-draggable ui-draggable-handle ui-draggable-dragging" data-signer-id="3" data-document-id="1" style="position: absolute; left: '+relativeX+'px; top: '+relativeY+'px;" id="fieldPosition'+uniqueGenerator+'"><div class="drop-select"><a data-signer="signature" class="btn btn-default btn-select signature1" id="field'+uniqueGenerator+'" style="min-width: 176px;"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'" value=""><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'" value=""><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'" value=""><span class="btn-select-value">Signature</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div></div>');
	}
	
	 var incremented = parseInt(uniqueGenerator) + 1;
     $("#generator").val(incremented);
     
     var total_row=$("#signerListSize").val();
     var html = '<ul>';
	        for (var i = 0; i < total_row; i++) {
	        	var signername=$("#signer_"+i).html();
	        	
	        	var signeremail=$("#signer_"+i).attr('data-name');;
	        	
	        	
	        	if(signername  != undefined && signername !=""){
	        		//alert($("#signername"+i).val());
	        		html += '<li data-name="0" id="'+signeremail+'">'+signername+'</li>';
	        	}
	        }
     html += '</ul>';
     
	 $('#field'+uniqueGenerator).append(html);
     
});

/* $(document).on('touchstart', '.render-image', function() { 
	alert('test'); 
	
}); */
	
	
/* $(window).load(function() { // better to use $(document).ready(function(){
    $('.render-image').on('click touchstart', function(e) {

        var offset = $("#document-reader").offset();
        var relativeX = (e.pageX - offset.left);
        
        var relativeY = (e.pageY - offset.top);
        //alert(relativeX+':'+relativeY);
        $("#document-reader").append('<div class="dragMe ui-draggable ui-draggable-handle ui-draggable-dragging" data-signer-id="1" data-document-id="1" style="position: absolute; left: '+relativeX+'px; top: '+relativeY+'px;" id="fieldPosition1"><div class="drop-select"><span class="glyphicon glyphicon-move"></span><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox(1)" href="#clear"><span class="icon-close"></span></a><a data-signer="name" class="btn btn-default btn-select name" id="field1"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue1" value="1"><input type="hidden" class="btn-select-input" id="fieldvalue1" value="sanket"><input type="hidden" class="btn-select-email" id="fieldemailvalue1" value="sanket.navale@banctec.in"><span class="btn-select-value">Name</span><span class="btn-select-arrow fa fa-angle-down"></span><ul style="display: none;"><li data-name="1" id="sanket.navale@banctec.in">sanket</li><li data-name="1" id="sanket.navale@banctec.in">sanket1</li></ul></a></div></div>');
    });
});
 */
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

/* var oldFunc = element.onmousedown;
element.onmousedown = function(evt) {
    oldFunc.call(this, evt || window.event);
} */

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
<script>
$(function() {
	
	var docId='${docId}';
	var userId='${userId}';
	getAjaxDocument(docId,userId);	
	function getAjaxDocument(docId,userId){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		
		var info = "?docId="+docId+"&userId="+userId;
		$.ajax({
			//contentType : 'application/json; charset=utf-8',
			type : "GET",
			url : contextPath+"ajaxGetDocument"+info,
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
								$("#numpages").val(numpages);
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
						$(".doc-width").css({'width':+width});
						for (var i = 1; i <= numpages; i++) {
						  		//$("#document-reader").append('<div class="drop" id="'+i+'"><img width="'+width+'px" height="'+height+'px" class="render-image" onload="loadImage()" src="'+contextPath+'getImgDocument?fileid='+fileid+'&filename='+filename+'&page='+i+'&userId='+userId+'"></div>');
								$.ajax({
									//contentType : 'application/json; charset=utf-8',
									type : "GET",
									url : contextPath+'getImgDocument?fileid='+fileid+'&filename='+filename+'&page='+i+'&userId='+userId+'&numpages='+numpages,
									async: false,
									//dataType : 'json',
									//data : JSON.stringify(data),
									beforeSend : function(xhr) {
										//$('#signupbtn').buttonLoader('start');
										$("#loader1").show();
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
						
						$("#loader1").hide();
						 
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
})
//remove the dragsigner when click on close icon
$(document).on("click", ".closeIt", function() {
    var parent = $(this).parent();
    parent.remove();
});

function DragSigner() {

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

                  document_id = dragEl.data("document-id");
                  signer_id = dragEl.data("signer-id");
                  leftPosition = ui.offset.left - $(this).offset().left;
                  topPosition = ui.offset.top - $(this).offset().top;
                  var droppableId = $(this).attr("id");
                 // alert("top: " + topPosition + ", left: " + leftPosition);
                  var uniqueGenerator = $("#generator").val();
                  if (document_id == 1 && signer_id == 1) {
                  	var fullname=$("#fullName").val();
                  //dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group name"> <span style="position:relative;" class="add-clear-span"><input name="name" type="text" class="form-control" id="field'+uniqueGenerator+'" onchange="getfieldValue(this.value,'+uniqueGenerator+')" placeholder="Name" value="'+fullname+'" type="text"></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none;" id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></span></div></div>');
          			$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a data-signer="name" class="btn btn-default btn-select name" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Name</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="closeIt hideIt" style=" text-decoration: none;"  onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>'));
          			$(".dragMe").removeClass("btn btn-light-oragne margB20")
          			$("#signer-1").addClass("btn btn-light-oragne margB20");
          			$("#signer-2").addClass("btn btn-light-yellow margB20");
          			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
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
          		    //dragEl = ui.helper.clone().html('<div class="drop-select"><a data-signer="date" class="btn btn-default btn-select date" id="field'+uniqueGenerator+'"><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Date</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>');
          			$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a data-signer="date" class="btn btn-default btn-select date" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Date</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="closeIt hideIt" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>'));
          			$(".dragMe").removeClass("btn btn-light-yellow margB20")
          			$("#signer-1").addClass("btn btn-light-oragne margB20");
          			$("#signer-2").addClass("btn btn-light-yellow margB20");
          			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
          			
          			
          			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
          		  }else if (document_id == 1 && signer_id == 3) {
          			//dragEl = ui.helper.clone().html('<div class="drop-select"><a data-signer="signature" class="btn btn-default btn-select signature1" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Signature</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>');
          			$("#"+droppableId).append(ui.helper.clone().html('<div class="drop-select" id="drop-select'+uniqueGenerator+'"><a data-signer="signature" class="btn btn-default btn-select signature1" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" data-pagenumber='+droppableId+'><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Signature</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="closeIt hideIt" style=" text-decoration: none;"  onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>'));

          			$(".dragMe").removeClass("btn btn-light-Bermuda margB20")
          			$("#signer-1").addClass("btn btn-light-oragne margB20");
          			$("#signer-2").addClass("btn btn-light-yellow margB20");
          			$("#signer-3").addClass("btn btn-light-Bermuda margB20");
          			
          			$(this).find("div.dragMe").attr('id', 'fieldPosition'+uniqueGenerator+'');
          			
          	      }/* else  if (document_id == 1 && signer_id == 4) {
                  	//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group text"> <span style="position:relative;" class="add-clear-span"><input name="text" type="text" class="form-control expandeble" onchange="getfieldValue(this.value,'+uniqueGenerator+')" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);"  id="field'+uniqueGenerator+'" placeholder="Text" value="" ></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none;" id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></span></div></div>');
          			dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="textbox" class="btn btn-default btn-select textbox" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Textbox</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>');
                  	dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
          		  }else  if (document_id == 1 && signer_id == 5) {
              		//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-field"><input name="checkbox" id="field'+uniqueGenerator+'" type="checkbox"  class="filled-in" checked><label for="single" ></label><span class="icon-close" onclick="hideTextbox('+uniqueGenerator+')"></span></div></div>');
          			dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="checkbox" class="btn btn-default btn-select checkbox" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Checkbox</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>');
              		dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
          		  }else  if (document_id == 1 && signer_id == 6) {
              		var firstname=$("#firstName").val();
          			//dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group initials"> <span style="position:relative;" class="add-clear-span"><input name="initials" type="text" class="form-control expandeble" onkeypress="enlargeText(field'+uniqueGenerator+',this.value);" onchange="getfieldValue(this.value,'+uniqueGenerator+')"  id="field'+uniqueGenerator+'" placeholder="Text" value="'+firstname+'" ></span><span class="input-group-btn"><a class="btn" style=" text-decoration: none;" id="fieldclose'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></span></div></div>');
          			dragEl = ui.helper.clone().html('<div class="drop-select"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><a data-signer="initials" class="btn btn-default btn-select initials" id="field'+uniqueGenerator+'" ><input type="hidden" class="btn-select-priority" id="fieldpriorityvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-input" id="fieldvalue'+uniqueGenerator+'"  value="" /><input type="hidden" class="btn-select-email" id="fieldemailvalue'+uniqueGenerator+'"  value="" /><span class="btn-select-value">Initails</span><span class="btn-select-arrow fa fa-angle-down"></span></a><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a></div>');
          			dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
          		  } */
                  var incremented = parseInt(uniqueGenerator) + 1;
                  $("#generator").val(incremented);
                 // dragEl.data("signer-id", signer_id);	
					signerEmailList();
                   dragEl.draggable({
                      helper: 'original',
                      cursor: 'move',
                      tolerance: 'fit',
                      drop: function(event, ui) {
                          $(ui.draggable).remove();
                      }
                  }); 

                  // append element to #document-reader
                  // append element to #document-reader
                  //dragEl.addClass("dragMe");
                  /* if (document_id == 1 && signer_id == 1) {
                      dragEl.removeClass("btn btn-light-oragne margB20");
                  } else if (document_id == 1 && signer_id == 2) {
                      dragEl.removeClass("btn btn-light-yellow margB20");
                  } else if (document_id == 1 && signer_id == 3) {
                      dragEl.removeClass("btn btn-light-Bermuda margB20");
                  } else if (document_id == 1 && signer_id == 4) {
                      dragEl.removeClass("btn btn-light-purple margB20");
                  } else if (document_id == 1 && signer_id == 5) {
                      dragEl.removeClass("btn btn-light-blue margB20");
                  } else if (document_id == 1 && signer_id == 6) {
                      dragEl.removeClass("btn btn-light-brown margB20");
                  } */
                 /*  dragEl.removeClass("dragSigners col-sm-6 parent");
                  dragEl.find("span.closeIt").removeClass("hideIt");
                  dragEl.appendTo('#document-reader'); */
				
                  var total_row=$("#signerListSize").val();
                  var html = '<ul>';
          	        for (var i = 0; i < total_row; i++) {
          	        	var signername=$("#signer_"+i).html();
          	        	
          	        	var signeremail=$("#signer_"+i).attr('data-name');;
          	        	
          	        	
          	        	if(signername  != undefined && signername !=""){
          	        		//alert($("#signername"+i).val());
          	        		html += '<li data-name="0" id="'+signeremail+'">'+signername+'</li>';
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
                  // update draged element position to database
                  // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)

                  // activate dragging for cloned element
                  DragMe();
              }
          });
}
function DragMe() {
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
                  dragEl = $(this);
                  stopPosition = dragEl.position();
                  document_id = dragEl.data("document-id");
                  signer_id = dragEl.data("signer-id");

                  // debug current dropped position
                  // this position is working perfectly fine.
                  // above drag, drop and clone position should behave like this
                  // alert("top: " + stopPosition.top + ", left: " + stopPosition.left); 

                  console.log(dragEl.hasClass("parent"))
                  if (!dragEl.hasClass("parent")) {
                      // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)
                  }
              }
          });
      }
// this function is simply for updating required fields to database
// please ignore this for now
function updateDraggedPosition(dragEl, stopPosition, document_id, signer_id) {
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

function hideTextbox(id) {
    $("#drop-select" + id).remove();
    //alert('HIDE'+id);
    //$("#field"+id).find("a.closeIt").removeClass("hideIt");
    signerEmailList();
	 
}

	
  </script>
<script>
$(document).ready(function () {
	
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
   // jumpstep2(3);
});


$(document).on('click', function (e) {
    var target = $(e.target).closest(".btn-select");
    if (!target.length) {
        $(".btn-select").removeClass("active").find("ul").hide();
    }
});
$(document).ready(function(){
	
});

function loadImage() {
	$("#loader1").fadeOut("slow");
	//$(".loadImage").show();
}

function signerEmailList(){
	
	var generatorLength=$("#generator").val();
	var array1 = [];
	for(var i=0; i<generatorLength ; i++) {
		var fieldType=$("#field"+i).attr("data-signer");
		//if(fieldType !=null && fieldType !=undefined && fieldType =='signature'){
			if(fieldType !=null && fieldType !=undefined){
			array1[i]=$("#fieldemailvalue"+i).val();   
		}
	}
	
	var array2 = [];
	var total_row=$("#signerListSize").val()
	for (var i = 0; i <= total_row; i++) {
		var signeremail=$("#signer_"+i).attr('data-name');
		if(signeremail  != undefined && signeremail !=""){
       	
       	array2[i]=signeremail;   
		}
	}
	
	//alert("array1 "+array1);
	//alert("array2 "+array2);
	 var foo = [];

	$.grep(array2, function(el) {

		if ($.inArray(el, array1) != -1) {
			foo.push(el);
		}

	});
	//alert(" they have the same " + foo);
	var a1=foo.sort();
	var a2=array2.sort();
	var is_same = a1.length == a2.length && a1.every(function(element, index) {
	    return element === a2[index]; 
		});
	//alert(is_same);		
	
	if(array1.length==0){$("#step3-button").attr('disabled','disabled');}
	for (var i = 0; i <array1.length; i++) {
		if(array1[i] == ""){
			 $("#step3-button").attr('disabled','disabled');
		}if(array1[i] != ""){
			//alert('Not empty array')
			if(is_same == 'true' || is_same== true){
				$("#step3-button").removeAttr('disabled');
			}else{
				$("#step3-button").attr('disabled','disabled');
			}
		}
	} 
	
	
}

function savePrepareDocument(){
	

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	var generatorLength=$("#generator").val();
	var pageHeight=$("#pageHeight").val();
	var numpages=$("#numpages").val();
	var docId=$("#docId").val();
	var key=$("#key").val();
	var jsonArray = [];
	for(var i=1; i<generatorLength; i++) {
		var item = {};
		var fieldType=$("#field"+i).attr("data-signer");
		if(fieldType !=null && fieldType !=undefined){
			if(fieldType == "name"){
				item ['docId'] = docId;
				item ['top'] =$("#field"+i).attr("data-top");
				item ['left'] = $("#field"+i).attr("data-left");
				item ['fieldType'] = "text";
				item ['fieldName'] = $("#field"+i).attr("data-signer");
				item ['priority'] = $("#fieldpriorityvalue"+i).val();
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['fieldValue'] = $("#fieldvalue"+i).val();
				item ['userId'] = $("#fieldemailvalue"+i).val();
				item ['fieldWidth']= "176";
				item ['fieldHeight']= "57";
				item ['pageHeight']= pageHeight;
				item ['numpages']= numpages;
				item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
				
			}else if(fieldType == "date"){
				item ['docId'] = docId;
				item ['top'] =$("#field"+i).attr("data-top");
				item ['left'] = $("#field"+i).attr("data-left");
				item ['fieldType'] = "date";
				item ['fieldName'] = $("#field"+i).attr("data-signer");
				item ['priority'] = $("#fieldpriorityvalue"+i).val();
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['userId'] = $("#fieldemailvalue"+i).val();
				item ['fieldWidth']= "176";
				item ['fieldHeight']= "57";
				item ['pageHeight']= pageHeight;
				item ['numpages']= numpages;
				item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
			}else if(fieldType == "signature"){
				item ['docId'] = docId;
				item ['top'] =$("#field"+i).attr("data-top");
				item ['left'] = $("#field"+i).attr("data-left");
				item ['fieldType'] = "image";
				item ['fieldName'] = $("#field"+i).attr("data-signer");
				item ['priority'] = $("#fieldpriorityvalue"+i).val();
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['userId'] = $("#fieldemailvalue"+i).val();
				item ['fieldWidth']= "176";
				item ['fieldHeight']= "57";
				item ['pageHeight']= pageHeight;
				item ['numpages']= numpages;
				item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
			}else if(fieldType == "textbox"){
				item ['docId'] = docId;
				item ['top'] =$("#field"+i).attr("data-top");
				item ['left'] = $("#field"+i).attr("data-left");
				item ['fieldType'] = "text";
				item ['fieldName'] = $("#field"+i).attr("data-signer");
				item ['priority'] = $("#fieldpriorityvalue"+i).val();
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['userId'] = $("#fieldemailvalue"+i).val();
				item ['fieldWidth']= "176";
				item ['fieldHeight']= "57";
				item ['pageHeight']= pageHeight;
				item ['numpages']= numpages;
				item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
			}else if(fieldType == "checkbox"){
				item ['docId'] = docId;
				item ['top'] =$("#field"+i).attr("data-top");
				item ['left'] = $("#field"+i).attr("data-left");
				item ['fieldType'] = "image";
				item ['fieldName'] = $("#field"+i).attr("data-signer");
				item ['priority'] = $("#fieldpriorityvalue"+i).val();
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['userId'] = $("#fieldemailvalue"+i).val();
				item ['fieldWidth']= "176";
				item ['fieldHeight']= "57";
				item ['pageHeight']= pageHeight;
				item ['numpages']= numpages;
				item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
			}else if(fieldType == "initials"){
				item ['docId'] = docId;
				item ['top'] =$("#field"+i).attr("data-top");
				item ['left'] = $("#field"+i).attr("data-left");
				item ['fieldType'] = "text";
				item ['fieldName'] = $("#field"+i).attr("data-signer");
				item ['fieldValue'] = $("#fieldvalue"+i).val();
				item ['priority'] = $("#fieldpriorityvalue"+i).val();
				item ['signerName'] = $("#fieldvalue"+i).val();
				item ['userId'] = $("#fieldemailvalue"+i).val();
				item ['fieldWidth']= "176";
				item ['fieldHeight']= "57";
				item ['pageHeight']= pageHeight;
				item ['numpages']= numpages;
				item ['pageNumber']= $("#field"+i).attr("data-pagenumber");
			}
			jsonArray.push(item);
			console.log(jsonArray);
		}
	}
	 var btn='#step3-button';
	$.ajax({
		type : "POST",
		url : contextPath+"savePrepareDocument?key="+key,
		dataType: 'json',
	    contentType: "application/json; charset=utf-8",
	    data: JSON.stringify(jsonArray),
	    beforeSend: function (xhr) {
	    	$(btn).buttonLoader('start');
	    	$("#loader1").show();
   			xhr.setRequestHeader(header, token);
   	    },
	    complete: function () {
	    	$(btn).buttonLoader('stop');
	    	$("#loader1").hide();
	    },
        success : function(response) {
        	if(response == '200'){ 
        		//alert("SUCCESS");  //OK
        		$("#open_document_content").hide();
            	$("#error_content").hide();
            	$("#step3-button").hide();
            	$("#success_content").show();
            	$("#success-messgae").html('YOU HAVE SUCCESSFULLY PREPARED THE DOCUMENT');
            }else if(response == '201'){
            	//alert('ERROR CODE: 201'); //KEY IS NOT EXIST 
            	$("#open_document_content").hide();
            	$("#error_content").show();
            	$("#error-messgae").html('ERROR 201:TOKEN IS INVALID');
            }else if(response == '202'){
            	//alert('YOU HAVE ALREDY PREPARE THE DOCUMENT');
            	$("#open_document_content").hide();
            	$("#error_content").show();
            	$("#error-messgae").html('ERROR 202:YOU HAVE ALREDY PREPARED THE DOCUMENT');
            }else if(response == '203'){
            	//alert('ERROR CODE: 103'); //KEY IS NULL
            	$("#open_document_content").hide();
            	$("#error_content").show();
            	$("#error-messgae").html('ERROR 203:TOKEN IS INVALID');
            }else if(response == '204'){
            	//alert('ERROR CODE: 104');  //ERROR WHILE SAVE FIELDS
            	$("#open_document_content").hide();
            	$("#error_content").show();
            	$("#error-messgae").html('ERROR 204:FAILD');
            }
		},
		 error : function(e) {  
		    alert('Error: ' + e);   
		}  
	 });
}
	
function saveDragAndDropMobileFields(value){
	if(value == 'Name'){
		$("#m_name").css("color","#000");
		$("#m_name").css("border","1px solid");
		
		
		$("#m_date").css("color","#fff");
		$("#m_date").css("border","none");
		
		$("#m_signature").css("color","#fff");
		$("#m_signature").css("border","none");
	}
	if(value == 'Date'){
		$("#m_date").css("color","#000");
		$("#m_date").css("border","1px solid");
		
		$("#m_name").css("color","#fff");
		$("#m_name").css("border","none");
		$("#m_signature").css("color","#fff");
		$("#m_signature").css("border","none");
	}
	if(value == 'Signature'){
		$("#m_signature").css("color","#000");
		$("#m_signature").css("border","1px solid");
		
		$("#m_name").css("color","#fff");
		$("#m_name").css("border","none");
		$("#m_date").css("color","#fff");
		$("#m_date").css("border","none");
	}
	$("#select_mobile_field").val(value);
}	



	</script>
</body>
<input type="hidden" id="generator" value="1" />
<input type="hidden" id="pageHeight" value="0"/>
<input type="hidden" id="prepareReturnURL" value="${prepareReturnURL}"/>
<input type="hidden" id="select_mobile_field" value=""/>\
<input type="hidden" id="numpages" value="0" />


</html>