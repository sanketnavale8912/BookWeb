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
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>${title} | DrySign</title>
<!-- Bootstrap -->
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<link href="<%=appUrl %>/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="<%=appUrl %>/css/fonts_icon.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"  href="<%=appUrl %>/css/style1.css"/> 
<link rel="stylesheet"  href="<%=appUrl %>/css/inner_page.css"/>
<link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
<link href="<%=appUrl %>/css/jquery.signature.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.css">

<style>
body{
    background: #eee;
    height: 100vh;
}
#signature,#prev{
		width: 750px;
		height: 186px;
	}
.signature-sign .close {
    opacity: 9;
    font-size: 37px;
    position: relative;
    top: -10px;
}
.selected {
    box-shadow: 9px 11px 28px -12px #080808;
}
.Message {
      box-shadow: 0px 0px 10px 1px #d4d4d4 !important;
}
.footer{
	position: fixed;
    bottom: 0;
    width: 100%;
    height: 60px;
    z-index: 99999;
}
.loader1 {
   position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=appUrl %>/images/spin.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
 }
input[type=text]::-ms-clear {
    display: none;
}
.overlay-bg {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 1040;
    background: rgba(0, 0, 0, 0.81);
    display: none;
}
.document-reader img {
    border: 1px solid #c5c5c5;
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
	.saved_signature {
			position: relative;
			margin: 1px;
			margin-left: 0px;
   			border: 1px solid #ddd;
			border-radius: 3px;
			
	}
		.PDF_arrow {
    position: absolute;
    left: -77px;
    bottom: auto;
    /* z-index: 9; */
}
.PDF_View {
    margin: 0 auto;
    width: 890px;
    max-width: 90%;
  /*   border: 2px solid #000; */
    border-radius: 5px;
    position: relative;
    margin-bottom:90px
}

.Message {
    position: fixed;
    top: 29%;
    right: 0;
    left: 0;
    bottom: 0;
    width: 500px;
    height: 200px;
    background: #fff;
    z-index: 9999;
    margin: 0 auto;
    padding: 25px;
    box-shadow: 0px 0px 10px 8px #d4d4d4;
    display: inline-table;
    display: none;
    overflow: hidden;
    color: #aba9a9;
    max-width: 80%;
}

</style>
</head>
<body >
<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
<div id="loader1" class="loader1" style="display:none"></div>
<div class="PDF_Loading_view">
		<div class="PDF_Innner_loading text-center">
			<img src="<%=appUrl %>/images/logo_inner.png"/>
			<br/>
			<br/>
			 <div class="progress">
			    <div class="progress-bar" id="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
      			<span class="sr-only">70% Complete</span>
    				</div>
  			</div>
			<p>Loading document, Please wait !</p>
		</div>
</div>
<nav class="navbar navbar-default inner-header">
  <div class="container-fluid"> 
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header" style="width: 100%">
      <a class="navbar-brand" href="#"><img src="<%=appUrl %>/images/1.0/logo_inner.png"/></a>
         <div class="pull-right">
           <!--  <a class="btn" style=" text-decoration: none; " onclick="openMySignature();" href="#">HELLO</a>
		   <button type="button"  class="btn PDF-btn-red" value="Guide Me" onclick="openMySignature()" >Guide Me</button> -->
   		  <!-- <button type="button" id="finish" class="btn has-spinner PDF-btn-pri" onclick="saveDocument();" value="Finish" disabled style="margin: 26px 10px;">Finish</button> -->
     
    </div>
   </div>
  </div>
  <!-- <div class="progress">
    <div class="progress-bar" id="progress_bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
      <span class="sr-only">0% Complete</span>
    </div>
  </div> -->
  <!-- /.container-fluid --> 
</nav>
<div class="container-fluid" style="margin-top: 100px;">
<!--  <div class="col-md-2" id="show_arrow"> -->

<!-- 				</div> -->
	
	<div class="row PDF_Main  margTB20" >                
		<div class="PDF_View" style="width: 895px;">
				<div class="PDF_arrow">
			  <img class="arrow1" id="arrowright1" src="<%=appUrl %>/images/arrowright1.png" style=" position:absolute; width: 50px; height: 50px; display:none;"> 
  <img class="arrow1" id="arrowdown" src="<%=appUrl %>/images/arrowdown.png" style=" position:fixed; width: 50px; height: 50px;  display:none;"> 
  <img class="arrow1" id="arrowup" src="<%=appUrl %>/images/arrowup.png" style=" position:absolute; width: 50px; height: 50px;   display:none;">
    <img class="arrow1" id="completed" src="<%=appUrl %>/images/completed.png" style=" position:fixed; width: 50px; height: 50px; bottom: 10; right:0px; z-index: 1;display:none;">  
		</div>
		<div class="page">
			<div class='document-reader' id="document-reader">
			  
			 	<input type="hidden" id="fileName" value="${filename}" />

<%-- 			 	 <c:forEach var="page" begin="1" end="${numpages}">
					<div id="page_${page}" data-doc-id="${page}">
						 <img width="${pwidth}px" height="${pheight}px"  src="<%=appUrl %>/viewDocument?filename=${efaFile}&page=${page}&userId=${userId}"  onload="loadImage()" />
					</div>
					<!-- class="img-responsive img-center" -->
				</c:forEach>  --%>

				</div>
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
			<%-- <img class="img-responsive" src="<%=appUrl %>/images/PDF_view.jpg"/> --%>
		</div>
	</div>
</div>
<!--/.Footer -->
<div class="footer">
	<div class="text-center">
		Copyrights  &copy; <script>document.write(new Date().getFullYear())</script> Exela Technologies Inc., All Rights Reserved.
	</div>
</div>
<!-- Draw Signature -->
  <div class="signature-sign">
	 <div class="header">	 	
		 <a class="close" href="#"><span class="icon-close"></span></a>
	 </div>
	 <ul class="nav nav-tabs self-sign">
			<li id="sDraw" ><a href="#draw" data-toggle="tab">DRAW</a>
			</li>
			<li id="tDraw">
       		 <a  href="#tdraw"  data-toggle="tab">DRAW</a>
			</li>
			 <li id="sType">
       		 <a  href="#type"  data-toggle="tab">TYPE</a>
			</li>
			 <li id="mSignature">
       		 <a  href="#mysignature"  data-toggle="tab">SAVED</a>
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
				<div class="tab-pane" id="mysignature">
	         		 <div class="row margTB20">
						 
					 </div>
					 <div class="row margB20">
						  <div class="col-xs-12 text-right">
							   <a class="text-green" id="saveMySignature" href="#">Save</a>
						  </div>
					  </div>
					  <div class="row margTB20">
						  <div class="col-xs-12">
						 	 	<img id="save_my_signature" style="box-shadow: 9px 11px 28px -12px #080808;" src=""/>
						 	 	
						  </div>
						   
						  <div class="col-xs-12" id="drawsignature_error" style="display:none">
						   <div class="alert alert-danger">
						      Please select saved signature.
							</div>
						  </div>
						</div>
				</div>
		<div class="tab-pane" id="type">
				  <div class="row margTB20">
						<div class="col-md-6 col-sm-6 col-xs-12">
						<div class="input-field">
							<label for="last_name">Type your signature here</label>
							<input id="typeName" type="text" value="${signerName}" class="form-control">
							
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
		<div class="tab-pane" id="tdraw">
         		 <div class="row margTB20">
					 
				 </div>
				 <div class="row margB20">
					  <div class="col-xs-12 text-right">
						  <a class="text-red" id="clear" href="#">Clear</a>
						   <a class="text-green" id="saveSignature1" href="#">Save</a>
					  </div>
				  </div>
				  <div class="row margTB20">
					  <div class="col-xs-12">
					  	<div id="signature"></div>
					  </div>
					  <div class="col-xs-12" id="tdrawsignature_error" style="display:none">
					   <div class="alert alert-danger">
					      Please draw your signature.
						</div>
					  </div>
					</div>
				</div>	
	</div>
</div>
 <div class="overlay-bg"></div>
<div class="overlaywhite_bg"></div>
 <div class="Message" id="showSignCount">	
   	  <div>
	  	<a class="close"  href="#"><span class="icon-close"></span></a>
	  </div>
		 <div class="header text-center margTB20 paddLR10">		 	
		 
		 	<div class="alert alert-info alert-dismissible" role="alert">
			 
			  You are invited to sign this document in DrySign.<br>
			  <button type="button" class="btn btn-success btn-circle" id="requiredCount"></button><strong> Required</strong> 
			</div>
		 </div>	
	  <div class="text-center">	  
		<button type="button" id="close1" class="btn btn-danger" style="background: #2c3d4f;border: 1px solid transparent;min-width:20px"  >OK</button>
	  </div> 	
 </div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/bootstrap.js"></script>
<script src="js/jquery.browser.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.js"></script>

<script>	

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

$(document).ready(function(){
	
	var docId='${docId}';
	var fileName='${fileName}';
	var userId='${signRequestedBy}';
	
	
	//Guide me- Anirudh
	
	//alert(num);
    $(window).bind('scroll keyup', function (event) {
       // $(window).scroll(function(){ mousedown wheel DOMMouseScroll mousewheel   'body,html'
        /*debugging*/
		var num =$("#progresscount").val();
        var scrollBottom = $(window).scrollTop() + $(window).height();
      //  $("#infoText").text(" Top-"+scrollBottom+"Window scrollTop: "+$(window).scrollTop()+" Scroll bottom "+scrollBottom+"Top Offsets (service, clients):"+$("#formElement1").offset().top+", "+$("#formElement2").offset().top);
        /*end-debugging*/
        var test ;
for(var i=0;i<num;i++){
var a= $("#field_"+i).offset().top;
        if(scrollBottom < a){
        	var val =$("#field_"+i).val();
        	console.log("value-"+val);
    		if(val == ''){
        document.getElementById("arrowdown").style.top = $(window).height()-150+"px";
		document.getElementById("arrowdown").style.display = "block";
		document.getElementById("arrowright1").style.display = "none";
		document.getElementById("completed").style.display = "none";
		console.log("In down");
		}}
//		else if($(window).scrollTop() > a)
//		{
//		document.getElementById("arrowright1").style.display = "none";
//		document.getElementById("arrowdown").style.display = "none";
//		document.getElementById("arrowup").style.top = $(window).scrollTop()+100+"px";
//		document.getElementById("arrowup").style.display = "block";
//		} 
        else if (scrollBottom >= ($("#field_"+i).offset().top)) {
		var val =$("#field_"+i).val();
		if(val == ''){
                console.log("To #ab"+i);
				//$("#show_arrow").append("<img class='arrow' id='arrowright1' src='img/batman.png' style=' position:absolute; width: 100px; height: 100px; top:"+a+"px; left:80px;'>");
				document.getElementById("arrowdown").style.display = "none";
				document.getElementById("arrowup").style.display = "none";
				document.getElementById("completed").style.display = "none";
				document.getElementById("arrowright1").style.display = "block";
				document.getElementById("arrowright1").style.top = a-122+"px";
				test=i;
				break;

            }
        }
}
if(typeof test !='undefined')
{
if($(window).scrollTop()>($("#field_"+test).offset().top)){
		var val =$("#field_"+test).val();
		if(val == ''){
		document.getElementById("arrowright1").style.display = "none";
		document.getElementById("arrowdown").style.display = "none";
		document.getElementById("completed").style.display = "none";
		document.getElementById("arrowup").style.top = $(window).scrollTop()+"px";
		document.getElementById("arrowup").style.display = "block";
		}
}}
    }).scroll();
	
});


function getImageRender(envelopeId){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	var userId=$("#userId").val();
	//alert($(".file-upload-input").attr('title'));
	

	var info = "?envelopeId="+envelopeId;
	$.ajax({
		//contentType : 'application/json; charset=utf-8',
		type : "GET",
		url : contextPath+"getViewReadOnlyDocument"+info,
		//dataType : 'json',
		//data : JSON.stringify(data),
		beforeSend : function(xhr) {
			//$('#signupbtn').buttonLoader('start');
			xhr.setRequestHeader(header, token);
			$("#loader1").show();
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
						  //alert( key + ": " + value );
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
        	
		},
		error: function(xhr, textStatus, errorThrown)
		 {
		 	alert('ajax loading error... ... ');
		 	return false;
		}
	})	
	    
}




function countdown(callback) {
	   var bar = document.getElementById('progress'),
	 
	   time = 0, max = 5,
	   int = setInterval(function() {
	       bar.style.width = Math.floor(100 * time++ / max) + '%';
	       if (time - 1 == max) {
	           clearInterval(int);
	           // 600ms - width animation time
	           callback && setTimeout(callback, 100);
	       }
	   }, 1000);
	   
	   
	}

	countdown(function() {
	   $(".PDF_Loading_view").hide();
	   var envelopeId = '${envelopeId}';
	   getImageRender(envelopeId);
	   //$("#finish").attr('disabled','disabled'); 
	   //("#show_landing").show();
	  // $("#showSignCount").show();
	   //$('.overlaywhite_bg').show();
	   //$('.overlay-bg').show();
	   //var count=$("#progresscount").val()
	   //("#requiredCount").html(count);
	   var count=$("#requiredCount").html();
	  /*  $.confirm({
		    title: '3 Required',
		    content: 'You are invited to sign this document in DrySign!',
		    type: 'red',
		    typeAnimated: true,
		    buttons: {
		        tryAgain: {
		            text: 'Try again',
		            btnClass: 'btn-red',
		            action: function(){
		            }
		        },
		        close: function () {
		        }
		    }
		}); */
		
	 
	});




	




function loadImage() {
	$("#loader1").fadeOut("slow");
}

/***********Drop all textfield and date and signature on document**************/


</script>
<script src="<%=appUrl %>/js/signature.js"></script>
<script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
<script>
zkSignature.capture();

$('.close').click(function(){
	//$('.save-signature-box').hide();
	$(".signature-sign").hide();
	$('.overlay-bg').hide();
	 //return false;
}); 
$('#close1').click(function(){
	//$('.save-signature-box').hide();
	$("#showSignCount").hide();
	$('.overlay-bg').hide();
	 //return false;
}); 
/*

$('#decline').click(function(){
	//$('.save-signature-box').hide();
	    $('.signature-sign').hide();
		$('.overlay-bg').hide();
		$('.Message').hide();
		$('.overlaywhite_bg').hide();
	 //return false;
});  */

//Draw Signature


//End Draw Singature

</script>

<script src="<%=appUrl %>/js/jquery-ui.js"></script>
<script src="<%=appUrl %>/js/jquery.signature.js"></script>
<script src="<%=appUrl %>/js/jquery.ui.touch-punch.js"></script>



<input type="hidden" id="fname" value="${filename}" />
<input type="hidden" id="isSaved" value="NO" />
<input type="hidden" id="returnURL" value="${returnURL}" />
<input type="hidden" id="fileid" value="${fileId}" />
<input type="hidden" id="email" value="${email}" />
<input type="hidden" id="token" value="${key}" />
<input type="hidden" id="redirecturl" value="" />
<input type="hidden" id="envelopeid" value="${envelopeid}" />
<input type="hidden" id="imageField" value=""/>
<input type="hidden" id="fieldLength" value="0"/>
<input type="hidden" id="myType" value=""/>
<input type="hidden" id="initial" value="0.0"/>
<input type="hidden" id="setIndexPixel" value="0"/>
<input type="hidden" id="checkFlag" value="true"/>
<input type="hidden" id="isLogin" value="false"/>
<input type="hidden" id="mysignatutreVal" value=""/>
<input type="hidden" id="progresscount" value=""/>
<input type="hidden" id="drawsignature_no" value=""/>
<input type="hidden" id="projectName" value="${projectName}"/>
<input type="hidden" id="signerName" value="${signerName}"/>
<input type="hidden" id="drawBase64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQ0lEQVR4Xu3W0QkAIAxDQV3W/Teo4BQ+uE4QLv3InpmzHAECBAgQIECAAAECXwtsw/3rfoQjQIAAAQIECBAg8AQMd49AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDgAqC3dsd5CiH1AAAAAElFTkSuQmCC"/>
<input type="hidden" id="drawBaseIE64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAPbSURBVHhe7dZBEcAwDMCwbmDLn0H2GYj4TvqYgp+ZuQcAAFjt/QsAACxm3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAACw3jkfMvcE1ytbuLQAAAAASUVORK5CYII="/>
<input type="hidden" id="drawBaseMozilla64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAD2UlEQVR4nO3WMREAIBDAMNTi38EjgRF6lyF7x66Z2QAAwN/W6wAAAODOuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAgwLgDAECAcQcAgADjDgAAAcYdAAACjDsAAAQYdwAACDDuAAAQYNwBACDAuAMAQIBxBwCAAOMOAAABxh0AAAKMOwAABBh3AAAIMO4AABBg3AEAIMC4AwBAgHEHAIAA4w4AAAHGHQAAAow7AAAEGHcAAAgw7gAAEGDcAQAg4AAckOtgbGrrvgAAAABJRU5ErkJggg=="/>
<input type="hidden" id="tdrawBaseIE64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAI0SURBVHhe7cExAQAAAMKg9U9tDB8gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4K4GhOIAAQ18YIgAAAAASUVORK5CYII="/>
<input type="hidden" id="signatureCount" value=""/>
<input type="hidden" id="pageHeight" value=""/>
<input type="hidden" id="numpages" value=""/>
<input type="hidden" id="userId" value="${userId}"/>
</body>
</html>
