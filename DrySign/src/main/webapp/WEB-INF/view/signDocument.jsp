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
    box-shadow: 9px 11px 28px -12px #130202;
}
.Message {
      box-shadow: 0px 0px 10px 1px #d4d4d4 !important;
}
.signature-sign {
    width: 800px;
    z-index: 9999;
    position: fixed;
    /* right: -1000px; */
    background: #fff;
    color: #000;
    top: 0px;
    height: 100%;
    padding: 25px;
    z-index: 1042;
    max-width: 96%;
    right: -800px;
    border-left: 1px solid #d4d4d4;
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
#arrowdown{
cursor:pointer;
}
#arrowup{
cursor:pointer;
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
<body >
<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
<div id="loader1" class="loader1" style="display:none"></div>
<div class="PDF_Loading_view">
		<div class="PDF_Innner_loading text-center">
			<img src="<%=appUrl %>/images/1.0/logo_inner.png"/>
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
   		  <button type="button" id="finish" class="btn has-spinner PDF-btn-pri" onclick="saveDocument();" value="Finish" disabled style="margin: 26px 10px;">Finish</button>
     
    </div>
   </div>
  </div>
  <div class="progress">
    <div class="progress-bar" id="progress_bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
      <span class="sr-only">0% Complete</span>
    </div>
  </div>
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
	<span class="icon-language"></span> ENGLISH  |	Copyright  &copy; <script>document.write(new Date().getFullYear())</script> Exela Technologies Inc., All Rights Reserved.
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
			<li id="uType">
       		 <a  href="#upload" data-toggle="tab">UPLOAD</a>
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
						  <a class="text-red" onclick="zkSignature.clear()" href="#/">Clear</a>
						   <a class="text-green" id="saveSignature" href="#/">Save</a>
					  </div>
				  </div>
				  <div class="row margTB20">
					  <div class="col-xs-12">
					  	<div id="canvas">
								Canvas is not supported.
						</div>
					  </div>
					   <div class="col-xs-12">
					  	 <input type="checkbox" id="default_sign_check_sdraw" name="default_sign_check">
						 Use this as default signature
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
					  <a class="text-red"  href="#/" onclick="clearUploadSignature();">Clear</a>
						   <a class="text-green"  href="#/" onclick="saveUploadSignature();">Save</a>
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
					   <div class="col-xs-12" id="default_sign_check_upload_show" style="display:none">
					  	 <input type="checkbox" id="default_sign_check_upload" name="default_sign_check" >
						 Use this as default signature
					  </div>
				</div>
				<div class="tab-pane" id="mysignature">
	         		 <div class="row margTB20">
						 
					 </div>
					 <div class="row margB20">
						  <div class="col-xs-12 text-right">
							   <a class="text-green" id="saveMySignature" href="#/">Save</a>
						  </div>
					  </div>
					  <div class="row margTB20">
						  <div class="col-xs-12">
						 	 	<c:set var="mysignature" value="${signature}"/>
						 	 	<c:choose> 
					  				<c:when test="${mysignature == null}">
					  				<img id="save_my_signature" style="box-shadow: 9px 11px 28px -12px #080808;" src=""/>
					  				</c:when>
					  				 <c:otherwise>
					  				 <img id="save_my_signature" style="box-shadow: 9px 11px 28px -12px #080808;" src="${signature}"/>
					  				 </c:otherwise>
					  			</c:choose>	
						 	 	
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
						   <a class="text-green" href="#/" onclick="saveTypeSignature();">Save</a>
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
				   <div class="col-xs-12">
					  	 <input type="checkbox" id="default_sign_check_type" name="default_sign_check">
						 Use this as default signature
					  </div>
				   
		</div>
		<div class="tab-pane" id="tdraw">
         		 <div class="row margTB20">
					 
				 </div>
				 <div class="row margB20">
					  <div class="col-xs-12 text-right">
						  <a class="text-red" id="clear" href="#/">Clear</a>
						   <a class="text-green" id="saveSignature1" href="#/">Save</a>
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
					  
					    <div class="col-xs-12">
					  	 <input type="checkbox" id="default_sign_check_tdraw" name="default_sign_check">
						 Use this as default signature
					  </div>
					  
					</div>
				</div>	
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

//Guide me on click- Anirudh
$("#arrowdown").click(function(){
    console.log("The paragraph was clicked.");
    var num =$("#progresscount").val();
    for(var i=0;i<num;i++)
    {
    	var val =$("#field_"+i).val();
    	console.log("value-"+val);
		if(val == ''){
			$('html, body').animate({scrollTop:$("#field_"+i).offset().top -100}, 2000);
			//window.scrollTo(0, $("#field_"+i).offset().top -100);
			break;
		}
    	
    }
    
});

$("#arrowup").click(function(){
    console.log("The paragraph was clicked.");
    var num =$("#progresscount").val();
    for(var i=0;i<num;i++)
    {
    	var val =$("#field_"+i).val();
    	console.log("value-"+val);
		if(val == ''){
			$('html, body').animate({scrollTop:$("#field_"+i).offset().top -100}, 2000);
			//.scrollTo(0, $("#field_"+i).offset().top -100);
			break;
		}
    	
    }
    
});

$(document).ready(function(){
	
	
	
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
console.log("value of a - "+a);
        if(scrollBottom < a){
        	var val =$("#field_"+i).val();
        	console.log("value-"+val);
    		if(val == ''){
        document.getElementById("arrowdown").style.top = $(window).height()-150+"px";
		document.getElementById("arrowdown").style.display = "block";
		document.getElementById("arrowdown").style.marginLeft = "2%";
		document.getElementById("arrowright1").style.display = "none";
		document.getElementById("completed").style.display = "none";
		console.log("In down");
		break;
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
				console.log("value of test- "+test);
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
		document.getElementById("arrowup").style.marginLeft = "15px";
		}
}}
    }).scroll();
	
});


function getImageRender(docId,fileName,userId){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var contextPath=$("#contextPath").val();
	//alert($(".file-upload-input").attr('title'));
	

	var info = "?docId="+docId+"&fileName="+fileName+"&userId="+userId;
	$.ajax({
		//contentType : 'application/json; charset=utf-8',
		type : "GET",
		url : contextPath+"getViewDocument"+info,
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
				//delete file
				//deleteImageDocument(filename);
			getFieldData();
				
				
				//$("#stepNumber").val(2);
				//var test1='<div class="dragMe drgfields ui-draggable ui-draggable-dragging ui-draggable-handle" style="padding: 0px; position: absolute; left: 154.25px; top: 60px;" data-signer-id="1" data-document-id="1" id="fieldPosition1"><span>Name</span><span class="closeIt">x</span><input type="text" id="field1" class="selfsign-control" onchange="getfieldValue(this.value,1)" value="asdasd" name="name" required=""></div><div class="dragMe ui-draggable ui-draggable-handle ui-draggable-dragging" data-signer-id="1" data-document-id="1" style="position: absolute; left: 422px; top: 31.4844px;" id="fieldPosition1"><span>Name</span><span class="closeIt">x</span><input type="text" id="field1" class="selfsign-control" onchange="getfieldValue(this.value,1)" value="" name="name" required=""></div>';
				
				//setTimeout(function(){
					//$("#document-reader").append(test1);
					
				//},1000);
				
				
				 
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

function deleteImageDocument(){
	
	
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
     url : contextPath+"typeSignature?imgType="+typeValue,  
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
var typeValue=$("#typeName").val().fulltrim();
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var contextPath=$("#contextPath").val();
$.ajax({  
     type : "GET",   
     url : contextPath+"typeSignature",   
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

String.prototype.fulltrim = function() {
	  return this.replace(/(?:(?:^|\n)\s+|\s+(?:$|\n))/g, '').replace(/\s+/g, ' ');
	};
	
/*****************************Progress bar front ***********************************/
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
  
  
   var docId='${docId}';
	var fileName='${fileName}';
	var userId='${signRequestedBy}';
	
	getImageRender(docId,fileName,userId);
  
});

function loadImage() {
	$("#loader1").fadeOut("slow");
}

/***********Drop all textfield and date and signature on document**************/
function getFieldData(){
	var contextPath=$("#contextPath").val();
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	var filename='${filename}';
	var fileId='${fileId}';
	var email='${email}';
	
	if(dd<10) {
	    dd='0'+dd
	} 
	if(mm<10) {
	    mm='0'+mm
	} 
	today = mm+'/'+dd+'/'+yyyy;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var pageHeight=$("#pageHeight").val();
$.ajax({  
    type : "GET",   
    url : contextPath+"getApplicationFieldData",   
    data : {"fname":filename,"fileid":fileId,"email":email},  
 	dataType: 'json',
    contentType: "application/json; charset=utf-8",
    beforeSend : function(xhr) {	                
    	xhr.setRequestHeader(header, token);
    },
	success : function(response) {  
  	  if(response){       
  		$("#fieldLength").val(response.length)
  		var count=1;
  		var signatureCount=0;
  		var totalCount=0;
  		for ( var key =0; key < response.length; ++key) 
  		{
  			var pixel=0;
  			
  			//check field name  || response[key].fieldName =='textbox' || response[key].fieldName =='initials'
  			if(response[key].fieldName =='name'){
  				var sum=0.00;  
  	   		 	 if(response[key].pageNumber == 1 ){
  	   	    	   	var sum=0.00;
 	 			     sum=sum;
 	 			  }else  if(response[key].pageNumber > 1 ){
 	 			    sum=pageHeight*(response[key].pageNumber-1);
 	 			  }
  	   		  	var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
  	   			var y=parseFloat(sum)+parseFloat(pixel)+parseFloat( response[key].yPosition);
  	   			if(response[key].fieldValue != 'null' ){
  	   			    var fieldKeyValue=parseFloat(response[key].fieldValue.length)*parseFloat(7)+parseFloat(20);
  	   				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ fieldKeyValue+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;border:0px;background-color: transparent;" name="document_field" id="field_'+key+'" readonly value="'+ response[key].fieldValue+'" >');	
  	   				
  	   			}else{
  	   				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="name" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;background-color: transparent;" name="document_field" id="field_'+key+'" onkeypress="enlargeText(field_'+key+',this.value);" onchange="progressdata(this.value);"  value="" >');
  	   				totalCount++;
  	   			}
  	   			newTextBoxDiv.appendTo("#document-reader");
	  	   		
  	    	}
  			if(response[key].fieldName =='textbox'){
  				var sum=0.00;  
  	   		 	 if(response[key].pageNumber == 1 ){
  	   	    	  	 var sum=0.00;
  	 			    	   sum=sum;
  	 			       }else  if(response[key].pageNumber > 1 ){
  	 			    	   sum=pageHeight*(response[key].pageNumber-1);
  	 			      }
  	   		  	var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
  	   			var y=parseFloat(sum)+parseFloat(pixel)+parseFloat( response[key].yPosition);
  	   			if(response[key].fieldValue != 'null' ){
  	   			    var fieldKeyValue=parseFloat(response[key].fieldValue.length)*parseFloat(7)+parseFloat(20);
  	   				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="textbox" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ fieldKeyValue+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;background-color: transparent;" name="document_field" id="field_'+key+'" readonly value="'+ response[key].fieldValue+'" >');	
  	   			}else{
  	   				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="textbox" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;background-color: transparent;" name="document_field" id="field_'+key+'" onkeypress="enlargeText(field_'+key+',this.value);" onchange="progressdata(this.value);"  value="" >');
  	   			    totalCount++
  	   			}
  	   			newTextBoxDiv.appendTo("#document-reader");
  	    	}
  			if(response[key].fieldName =='initials'){
  				var sum=0.00;  
  	   		 	 if(response[key].pageNumber == 1 ){
  	   	    	   var sum=0.00;
  	 			    	   sum=sum;
  	 			       }else  if(response[key].pageNumber > 1 ){
  	 			    	   sum=pageHeight*(response[key].pageNumber-1);
  	 			      }
  	   		  	var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
  	   			var y=parseFloat(sum)+parseFloat(pixel)+parseFloat( response[key].yPosition);
  	   			if(response[key].fieldValue != 'null' ){
  	   			    var fieldKeyValue=parseFloat(response[key].fieldValue.length)*parseFloat(7);
  	   				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="initials" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ fieldKeyValue+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;background-color: transparent;" name="document_field" id="field_'+key+'" readonly value="'+ response[key].fieldValue+'" >');	
  	   			}else{
  	   				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="initials" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;background-color: transparent;" name="document_field" id="field_'+key+'" onkeypress="enlargeText(field_'+key+',this.value);" onchange="progressdata(this.value);"  value="" >');
  	   			    totalCount++
  	   			}
  	   			newTextBoxDiv.appendTo("#document-reader");
  	    	}
  			if(response[key].fieldName =='date'){
  				 var sum=0.00;  
  	    		  if(response[key].pageNumber == 1 ){
  	    	    	   var sum=0.00;
  	  			    	   sum=sum;
  	  			       }else  if(response[key].pageNumber > 1 ){
  	  			    	   sum=pageHeight*(response[key].pageNumber-1);
  	  			      }
  	    			var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
  	    			var y=parseFloat(sum)+parseFloat(pixel)+parseFloat( response[key].yPosition);
  	    			newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="date" placeholder="DD/MM/YYYY" type="text" placeholder="'+ response[key].fieldName+'"  style="display: block;width: 100%;height: '+ response[key].fieldHeight+'px;border-radius: 2px;border: 0px solid transparent;border-radius: 4px;margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;text-align: left;border-color: #b5b3b3;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;background: rgba(251, 251, 251, 0);transition: none !important;-webkit-transition: none !important;font-size: 15px;font-family: NimbusSansL, Helvetica, Arial, sans-serif !important;z-index: 1020;-moz-box-shadow: inset 0px 1px 1px #AAA;-webkit-box-shadow: inset 0px 1px 1px #AAA; box-shadow: none;outline: none;white-space: pre;background-color: transparent;" name="document_field" id="field_'+key+'" onchange="progressdata(this.value);"  placeholder="DD/MM/YYYY"  value="'+today+'" readonly>');
  	    			newTextBoxDiv.appendTo("#document-reader");
  	    	}
  			if( response[key].fieldName =='signature' || response[key].fieldName =='sign'){
			       var sum=0.00;
			   	   if(response[key].pageNumber == 1 ){
			    	   sum=sum;
			       }else  if(response[key].pageNumber > 1 ){
			    	   sum=pageHeight*(response[key].pageNumber-1);
			       }
			var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
			var y=parseFloat(sum)+parseFloat(pixel)+parseFloat(response[key].yPosition);
			
			//newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="signature" type="text" src=""  style="margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;top:'+y+'px;height:'+response[key].fieldHeight+'px;" name="document_field" id="field_'+key+'" value="" data-toggle="modal" onclick="openMySignature('+key+')"/><input type="hidden" id="imageField'+key+'" value="'+key+'" />');
				if(response[key].fieldValue != 'null' ){
	   				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="signature" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;text-decoration: none;background-color: transparent;" name="document_field" id="field_'+key+'" readonly value="'+ response[key].fieldValue+'" >');	
   				}else{
   					newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><a href="javascript:void(0)"><input class="signature" placeholder="'+ response[key].fieldName+'"  type="text" style="margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;text-decoration: none;background-color: transparent;" name="document_field" id="field_'+key+'" onclick="openMySignature('+key+')" onchange="progressdata(this.value);" value="" readonly></a>');
   					totalCount++;
   				}
				signatureCount++;	
			newTextBoxDiv.appendTo("#document-reader");
			}
  		   count++;
  		 $("#progresscount").val(count);
  		}	
  		//alert(totalCount);
	  	 //alert(totalCount);
  		
  		 $("#requiredCount").val(totalCount);
  		
  		 if(totalCount ==0){
  			progressdata(0); 
  		 }else{
  			$("#finish").attr('disabled','disabled');
  		 }
  		 var count=totalCount;
		   if(count != 0 && count !="" && count !=undefined){
			   $.alert({
					 title: count+' Required field(s)',
					 content: 'You are invited to sign this document in DrySign',
					 type: 'dark',
				});
		   }
  		$("#signatureCount").val(signatureCount);
  	   }	
    },  
    error : function(e) {  
     alert('Error: ' + e);   
    }  
 });  
}

/****Progress bar increase and decrease base on textfield,date and signature fields from document **************/
function progressdata(textValue){
	var completeness = $("#progresscount").val();
	//var completeness = 5;
	var tcompleteness=parseFloat(100)/parseFloat(completeness);
	$(".page input[id][name$='document_field']").each(function () {
		//alert(this.value);
		if (this.value == "") {
			 completeness--;
		}
	});
	
	slide_progress(completeness*tcompleteness);
}

function slide_progress(completeness){
	 $('#progress_bar').attr('aria-valuenow', (completeness)).css('width',(completeness)+"%");
	 if(completeness >= 100){
		 $("#finish").removeAttr('disabled');
		 document.getElementById("arrowdown").style.display = "none";
		 document.getElementById("arrowup").style.display = "none";
	     document.getElementById("arrowright1").style.display = "none";
		 document.getElementById("completed").style.display = "block";
		/* document.getElementById("finish").disabled = false;
		$("#finish").css("color","background-color: #3c763d");
		$("#finish").show() */
	 }else{
		 $("#finish").attr('disabled','disabled'); 
	 }
}
function enlargeText(id,value){
	 // alert(value.length);
	  $(id).css('width',((value.length + 2) * 8) + 'px');
 }
function saveDocument(){
	
	var contextPath=$("#contextPath").val();
	var fieldLength=$("#fieldLength").val();
	var projectName=$("#projectName").val();
	//var fieldValue=$("#imageField").val();
	var jsonArray = [];
	var signeremail = $("#email").val();
	var fname = $("#fname").val();
	var fileid = $("#fileid").val();
	var token = $("#token").val();
	var returnURL = $("#returnURL").val();
	var token1 = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	var envelopeid = $("#envelopeid").val();
	var info = "?token="+token;
	var btn="#finish";
	for(var i=0; i<fieldLength; i++) {
		var item = {};
		var fieldType=$("#field_"+i).attr("type");
		if(fieldType == 'image'){
			var sign = document.getElementById('field_'+i);
			var signature = sign.getAttribute('src');
			var pageNumber=$("#pageNumber_"+i).val();
			item ["id"] =$("#field_id"+i).val();
			item ["documentName"] = $("#fname").val();
			item ["top"] = $("#yposition_"+i).val()
			item ["left"] = $("#field_"+i).css("margin-left");
			item ["fieldType"] = "image";
			item ["fieldValue"] = signature;
			//item ["pageNumber"] = pageNumber-parseInt(1);
			item ["pageNumber"] = pageNumber;
		}else if(fieldType == 'text'){
			var pageNumber=$("#pageNumber_"+i).val();
			item ["id"] =$("#field_id"+i).val();
			item ["documentName"] = $("#fname").val();
			item ["top"] = $("#yposition_"+i).val()
			item ["left"] = $("#field_"+i).css("margin-left");
			item ["fieldType"] = "text";
			item ["fieldValue"] = $("#field_"+i).val();
			//item ["pageNumber"] = pageNumber-parseInt(1);
			item ["pageNumber"] = pageNumber;
		}else if(fieldType == 'date'){
			var pageNumber=$("#pageNumber_"+i).val();
			item ["id"] =$("#field_id"+i).val();
			item ["documentName"] = $("#fname").val();
			item ["top"] = $("#yposition_"+i).val()
			item ["left"] = $("#field_"+i).css("margin-left");
			item ["fieldType"] = "text";
			item ["fieldValue"] = $("#field_"+i).val();
			//item ["pageNumber"] = pageNumber-parseInt(1);
			item ["pageNumber"] = pageNumber;
		}
		jsonArray.push(item);
	}

  	 $.ajax({
		type : "POST",
		url : "saveDocument"+info,
		dataType: 'json', 
	    data: JSON.stringify(jsonArray),
	    contentType: "application/json;",
	    beforeSend : function(xhr) {	         
	    	$(btn).buttonLoader('start');
	    	$("#loader1").show();
	    	xhr.setRequestHeader(header, token1);
	    },
	    complete: function () {
	    	$(btn).buttonLoader('stop');
	    	$("#loader1").hide();
	    },
        success : function(response) { 
        	if(response == "500"){
            	if(returnURL !=''){
            		window.location.href = "successPage?returnURL="+returnURL;	
            	}
            	else{
            		window.location.href = "success";
            	}
            	//alert('success');
                if(redirecturl != "" || redirecturl.trim() !="")
            	{	
                	$(".page").hide();
	            	$('#successMessage').modal('show');
	                $("#header").hide();
	                $("#view-docrender").hide();
	                $(".form-control").hide();
	                $("#nav_down").hide();
            		
            	}else{ 	
            	 	$(".page").hide();
	            	$('#successMessage').modal('show');
	            	$("#view-docrender").hide();
	                $("#header").hide();
	                $(".form-control").hide();
	                $("#nav_down").hide();
            	}
                
          } else if(response == "502"){
        	 	 window.location.href = "error";
        	  
          }else{
                alert("Error while saving details.");
          }

		} 
	}); 
}
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
function openMySignature(id){
	$("#drawsignature_error").hide();
	$("#myType").val('');
	$(".thumbnail").removeClass('selected');
	 var projectName=$("#projectName").val();
	// $('#default_sign_check_sdraw input').prop('checked', false);
	// $('#default_sign_check_tdraw input').prop('checked', false);
	// $('#default_sign_check_type input').prop('checked', false);
	 
	 $('#default_sign_check_sdraw').attr('checked', false);
	 $('#default_sign_check_tdraw').attr('checked', false);
	 $('#default_sign_check_type').attr('checked', false);
	 $('#default_sign_check_upload').attr('checked', false);
	 $("#default_sign_check_upload_show").hide();
	 
	/* $("#sDraw").addClass("active");
	$("#draw").addClass("active"); */
	var isSaved=$("#isSaved").val();
 
		/* if ($.browser.msedge || $.browser.msie && $.browser.version <= 6 || $.browser.msie && $.browser.version > 6 && projectName =='Talento'){
		 */	//show
			$("#tDraw").show();
			$("#sDraw").hide();
			if(isSaved == "YES"){
				$("#sType").removeClass('active');
				$("#type").removeClass('active');
				$("#sDraw").removeClass('active');
				$("#draw").removeClass('active');
				$("#mSignature").addClass('active');
				$("#mysignature").addClass('active');
				$("#tDraw").removeClass('active');
				$("#tdraw").removeClass('active');
				$("#uType").removeClass('active');
				$("#upload").removeClass('active');
				$("#mSignature").show();
			}else{
				$("#sType").removeClass('active');
				$("#type").removeClass('active');
				$("#sDraw").removeClass('active');
				$("#draw").removeClass('active');
				$("#mSignature").removeClass('active');
				$("#mysignature").removeClass('active');
				$("#tDraw").addClass('active');
				$("#tdraw").addClass('active');
				$("#uType").removeClass('active');
				$("#upload").removeClass('active');
				$("#mSignature").hide();
				
			}
			
			
		/* }else{
			//hide
			$("#tDraw").hide();
			if(isSaved == "YES"){
				$("#sType").removeClass('active');
				$("#type").removeClass('active');
				$("#tDraw").removeClass('active');
				$("#tdraw").removeClass('active');
				$("#mSignature").addClass('active');
				$("#mysignature").addClass('active');
				$("#sDraw").removeClass('active');
				$("#draw").removeClass('active');
				$("#mSignature").show();
			}else{
				$("#sType").removeClass('active');
				$("#type").removeClass('active');
				$("#tDraw").removeClass('active');
				$("#tdraw").removeClass('active');
				$("#mSignature").removeClass('active');
				$("#mysignature").removeClass('active');
				$("#sDraw").addClass('active');
				$("#draw").addClass('active');
				$("#mSignature").hide();
			}
		} */
	
	
		
	$("#show_upload_signature").show();
	
		
	$("#blah").hide();
	zkSignature.clear();
	$('#signature').signature('clear');
	$("#blah").attr('src', '');
	document.getElementById("imgInp").value = "";
	$('.overlay-bg').show();
	//$('body').css('overflow','hidden')
	$('.signature-sign').show();
		var $slider = $('.signature-sign');
		$slider.animate({
		 right: parseInt($slider.css('right'),10) == -350 ? 0 : 0
	});
	$("#drawsignature_no").val(id);	
	getSigntype();
	
	
}
$("#saveSignature").click(function(){
	var id=$("#drawsignature_no").val();
	var canvas = document.getElementById("newSignature");
	var dataURL = canvas.toDataURL("image/png");
	console.log(dataURL);
	//var defaultBase64=$("#drawBaseIE64").val();
	 //Check if browser is IE or not
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
		$("#field_"+id).attr('type', 'image'); 
		val= $("#field_"+id).attr('src', dataURL);	
		$("#field_"+id).val(id);
 		progressdata(val);
 		$(".signature-sign").hide();
 		$('.overlay-bg').hide();
 		var checkSignature=$("#isSaved").val();
 		
 		if($("#default_sign_check_sdraw").prop('checked') ==true){
 			var token = $("meta[name='_csrf']").attr("content");
 			var header = $("meta[name='_csrf_header']").attr("content");
 			var contextPath=$("#contextPath").val();
 			var data = {
 					 "signature" : dataURL,
 					 "signType" :"Draw",
 					 "email" :$("#email").val(),
 					 "fullName":$("#signerName").val(),
 					 "status":"1"
 			}
 			$.ajax({
 				type : "POST",
 				url : contextPath+"saveSignerSignature",
 				dataType: 'json',
 			    contentType: "application/json; charset=utf-8",
 			    data: JSON.stringify(data),
 			    beforeSend: function (xhr) {
 		   			xhr.setRequestHeader(header, token);
 		   			//$("#loader2").show();
 			    },
 			    complete: function () {
 			    	//$("#loader2").hide();
 			    },
 		        success : function(response) {
 		         	if(response != 'failed'){
 		        	
 		         		$("#save_my_signature").attr('src', dataURL);
 		    	 		$("#save_my_signature").addClass("saved_signature");
 		    	 		$("#isSaved").val("YES");	
 		    	 		
 		        				
 		            }else{
 		            	alert('failed');
 		            }
 				},
 				 error : function(e) {  
 				    alert('Error: ' + e);   
 				}  
 			 });
 		}
 		var signatureCount=$("#fieldLength").val();
 		if(signatureCount > 1){
	 		for(var i=0; i<signatureCount; i++) {
	 			
	 			var fieldType=$("#field_"+i).attr("type");
	 			var fieldSrc=$("#field_"+i).attr("src");
	 			if(fieldType == 'image' &&  fieldSrc !=''){
	 			   $("#field_"+i).attr('src', dataURL);		
				
	 			}
	 		}
	     }
	}
});

$("#saveSignature1").click(function(){
	var id=$("#drawsignature_no").val();
	var canvas = document.getElementById("newSignature1");
	var dataURL = canvas.toDataURL("image/png");
		//var defaultBase64=$("#drawBaseIE64").val();
	 //Check if browser is IE or not
	var defaultBase64=$("#tdrawBaseIE64").val();;
	console.log(dataURL);
	//if ($.browser.msedge || $.browser.msie && $.browser.version <= 6 || $.browser.msie && $.browser.version > 6  ){
	if( $.browser.safari ){
		 defaultBase64=$("#drawBaseSafari641").val();
	} 
	if ($.browser.mozilla && $.browser.version >= "2.0" ){
		defaultBase64=$("#drawBaseMozilla641").val();
	}
	if ($.browser.msedge || $.browser.msie && $.browser.version <= 6 || $.browser.msie && $.browser.version > 6){
		   	//alert('IE')
			defaultBase64=$("#drawBaseIE641").val();
		}
	if(defaultBase64 == dataURL){
		 
		$("#tdrawsignature_error").show();
	}else{
		$("#field_"+id).attr('type', 'image'); 
		val= $("#field_"+id).attr('src', dataURL);	
		$("#field_"+id).val(id);
 		progressdata(val);
 		$(".signature-sign").hide();
 		$('.overlay-bg').hide();
 		var checkSignature=$("#isSaved").val();
 		if($("#default_sign_check_tdraw").prop('checked') ==true){
 			
 			var token = $("meta[name='_csrf']").attr("content");
 			var header = $("meta[name='_csrf_header']").attr("content");
 			var contextPath=$("#contextPath").val();
 			var data = {
 					 "signature" : dataURL,
 					 "signType" :"Draw",
 					 "email" :$("#email").val(),
 					 "fullName":$("#signerName").val(),
 					 "status":"1"
 			}
 			$.ajax({
 				type : "POST",
 				url : contextPath+"saveSignerSignature",
 				dataType: 'json',
 			    contentType: "application/json; charset=utf-8",
 			    data: JSON.stringify(data),
 			    beforeSend: function (xhr) {
 		   			xhr.setRequestHeader(header, token);
 		   			//$("#loader2").show();
 			    },
 			    complete: function () {
 			    	//$("#loader2").hide();
 			    },
 		        success : function(response) {
 		         	if(response != 'failed'){
 		        	
 		         		$("#save_my_signature").attr('src', dataURL);
 		    	 		$("#save_my_signature").addClass("saved_signature");
 		    	 		$("#isSaved").val("YES");	
 		        				
 		            }else{
 		            	alert('failed');
 		            }
 				},
 				 error : function(e) {  
 				    alert('Error: ' + e);   
 				}  
 			 });
 			
 		}
 		
 		var signatureCount=$("#fieldLength").val();
 		if(signatureCount > 1){
	 		for(var i=0; i<signatureCount; i++) {
	 			
	 			var fieldType=$("#field_"+i).attr("type");
	 			var fieldSrc=$("#field_"+i).attr("src");
	 			if(fieldType == 'image' &&  fieldSrc !=''){
	 			   $("#field_"+i).attr('src', dataURL);		
				
	 			}
	 		}
	     }
	}
		
});

function saveTypeSignature(){
	var id=$("#drawsignature_no").val();
    var sign = $("#myType").val();
	var typeSign=$("#typeName").val();
	var check=validationSignature1(sign,typeSign,"type");
	if(check ==true){
		
		$("#field_"+id).attr('type', 'image'); 
		val= $("#field_"+id).attr('src', sign);	
		$("#field_"+id).val(id);
 		progressdata(val);
 		$(".signature-sign").hide();
 		$('.overlay-bg').hide();
 		var checkSignature=$("#isSaved").val();
 		if($("#default_sign_check_type").prop('checked')==true){
 			
 			var token = $("meta[name='_csrf']").attr("content");
 			var header = $("meta[name='_csrf_header']").attr("content");
 			var contextPath=$("#contextPath").val();
 			var data = {
 					 "signature" : sign,
 					 "signType" :"Type",
 					 "email" :$("#email").val(),
 					 "fullName":$("#signerName").val(),
 					 "status":"1"
 			}
 			$.ajax({
 				type : "POST",
 				url : contextPath+"saveSignerSignature",
 				dataType: 'json',
 			    contentType: "application/json; charset=utf-8",
 			    data: JSON.stringify(data),
 			    beforeSend: function (xhr) {
 		   			xhr.setRequestHeader(header, token);
 		   			//$("#loader2").show();
 			    },
 			    complete: function () {
 			    	//$("#loader2").hide();
 			    },
 		        success : function(response) {
 		         	if(response != 'failed'){
 		        	
 		         		$("#save_my_signature").attr('src', sign);
 		    	 		$("#save_my_signature").addClass("thumbnail selected");
 		    	 		$("#isSaved").val("YES");
 		        				
 		            }else{
 		            	alert('failed');
 		            }
 				},
 				 error : function(e) {  
 				    alert('Error: ' + e);   
 				}  
 			 });
 				
 		}
 		var signatureCount=$("#fieldLength").val();
 		if(signatureCount > 1){
	 		for(var i=0; i<signatureCount; i++) {
	 			
	 			var fieldType=$("#field_"+i).attr("type");
	 			var fieldSrc=$("#field_"+i).attr("src");
	 			if(fieldType == 'image' &&  fieldSrc !=''){
	 			   $("#field_"+i).attr('src', sign);		
				
	 			}
	 		}
	     }
		//$(".saved_signature").attr('src', sign);
	}

}


$("#saveMySignature").click(function(){
	var id=$("#drawsignature_no").val();
	var sign=$('#save_my_signature').attr('src');
	$("#field_"+id).attr('type', 'image'); 
	val= $("#field_"+id).attr('src', sign);	
	$("#field_"+id).val(id);
	progressdata(val);
	$(".signature-sign").hide();
	$('.overlay-bg').hide();
	
	var signatureCount=$("#fieldLength").val();
		if(signatureCount > 1){
 		for(var i=0; i<signatureCount; i++) {
 			
 			var fieldType=$("#field_"+i).attr("type");
 			var fieldSrc=$("#field_"+i).attr("src");
 			if(fieldType == 'image' &&  fieldSrc !=''){
 			   $("#field_"+i).attr('src', sign);		
			
 			}
 		}
     }
});

function saveUploadSignature(){
	var id=$("#drawsignature_no").val();
	var sign=$('#blah').attr('src');
	var fileInput = document.getElementById('imgInp');
	if(sign == ''){
		$("#file_error").show();
    	$("#file_error").html('Please upload a picture of your signature.').fadeOut(10000);;
        fileInput.value = '';
	}else{
		$("#field_"+id).attr('type', 'image'); 
		val= $("#field_"+id).attr('src', sign);	
		$("#field_"+id).val(id);
		progressdata(val);
		$(".signature-sign").hide();
		$('.overlay-bg').hide();
		if($("#default_sign_check_upload").prop('checked') ==true){
 			
 			var token = $("meta[name='_csrf']").attr("content");
 			var header = $("meta[name='_csrf_header']").attr("content");
 			var contextPath=$("#contextPath").val();
 			var data = {
 					 "signature" : sign,
 					 "signType" :"Upload",
 					 "email" :$("#email").val(),
 					 "fullName":$("#signerName").val(),
 					 "status":"1"
 			}
 			$.ajax({
 				type : "POST",
 				url : contextPath+"saveSignerSignature",
 				dataType: 'json',
 			    contentType: "application/json; charset=utf-8",
 			    data: JSON.stringify(data),
 			    beforeSend: function (xhr) {
 		   			xhr.setRequestHeader(header, token);
 		   			//$("#loader2").show();
 			    },
 			    complete: function () {
 			    	//$("#loader2").hide();
 			    },
 		        success : function(response) {
 		         	if(response != 'failed'){
 		        	
 		         		$("#save_my_signature").attr('src', sign);
 		    	 		$("#save_my_signature").addClass("saved_signature");
 		    	 		$("#isSaved").val("YES");	
 		        				
 		            }else{
 		            	alert('failed');
 		            }
 				},
 				 error : function(e) {  
 				    alert('Error: ' + e);   
 				}  
 			 });
 			
 		}
		var signatureCount=$("#fieldLength").val();
			if(signatureCount > 1){
	 		for(var i=0; i<signatureCount; i++) {
	 			
	 			var fieldType=$("#field_"+i).attr("type");
	 			var fieldSrc=$("#field_"+i).attr("src");
	 			if(fieldType == 'image' &&  fieldSrc !=''){
	 			   $("#field_"+i).attr('src', sign);		
				
	 			}
	 		}
	     }
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
						 $("#blah").show();
		    	    	 $('#blah').attr('src', 'data:image/jpeg;base64,'+response);	 
		    	    	 $("#default_sign_check_upload_show").show();
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


//End Draw Singature

</script>

<script src="<%=appUrl %>/js/jquery-ui.js"></script>
<script src="<%=appUrl %>/js/jquery.signature.js"></script>
<script src="<%=appUrl %>/js/jquery.ui.touch-punch.js"></script>
<script>
$(function() {
	// Initalize
	$('#signature').signature();

	// Clear signature area
	$('#clear').click(function() {
		$('#signature').signature('clear');
	});

});
function clearUploadSignature(){
	$('#blah').attr('src', '');
    $("#imgInp").val("");
    $("#show_upload_signature").show();
    $("#blah").hide();
		
}
</script>


<input type="hidden" id="fname" value="${filename}" />
<input type="hidden" id="isSaved" value="${isSaved}" />
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
<input type="hidden" id="drawBaseMozilla641" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAACNElEQVR4nO3BMQEAAADCoPVPbQwfoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIC/AYTiAAFN6tGQAAAAAElFTkSuQmCC"/>
<input type="hidden" id="tdrawBaseIE64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALOklEQVR4Xu3WQQ0AAAgDMfBvGhtcUhQsHY/tOAIECBAgQIAAAQIE3gvs+4QCEiBAgAABAgQIECAwhrsnIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgcBBMALvhIyDxAAAAAElFTkSuQmCC"/>
<input type="hidden" id="drawBaseSafari64" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQ0lEQVR4Ae3WQQ3AQAwDweuBLX8GqVQUWWmCwBrn4Wdm3uMIECBAgAABAgQIEFgtcFenE44AAQIECBAgQIAAgV/AcPcIBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEPjL3BNcQbtHHAAAAAElFTkSuQmCC"/>
<input type="hidden" id="drawBaseSafari641" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAALQElEQVR4Ae3WwQ0AIAwDMWD/nYvYgpPcCSKnj+yZWY4AAQIECBAgQIAAgb8Fzt/xpCNAgAABAgQIECBA4AkY7v6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQICA4e4HCBAgQIAAAQIECAQEDPdASSISIECAAAECBAgQMNz9AAECBAgQIECAAIGAgOEeKElEAgQIECBAgAABAoa7HyBAgAABAgQIECAQEDDcAyWJSIAAAQIECBAgQMBw9wMECBAgQIAAAQIEAgKGe6AkEQkQIECAAAECBAgY7n6AAAECBAgQIECAQEDAcA+UJCIBAgQIECBAgAABw90PECBAgAABAgQIEAgIGO6BkkQkQIAAAQIECBAgYLj7AQIECBAgQIAAAQIBAcM9UJKIBAgQIECAAAECBAx3P0CAAAECBAgQIEAgIGC4B0oSkQABAgQIECBAgIDh7gcIECBAgAABAgQIBAQM90BJIhIgQIAAAQIECBAw3P0AAQIECBAgQIAAgYCA4R4oSUQCBAgQIECAAAEChrsfIECAAAECBAgQIBAQMNwDJYlIgAABAgQIECBAwHD3AwQIECBAgAABAgQCAoZ7oCQRCRAgQIAAAQIECBjufoAAAQIECBAgQIBAQMBwD5QkIgECBAgQIECAAAHD3Q8QIECAAAECBAgQCAgY7oGSRCRAgAABAgQIECBguPsBAgQIECBAgAABAgEBwz1QkogECBAgQIAAAQIEDHc/QIAAAQIECBAgQCAgYLgHShKRAAECBAgQIECAgOHuBwgQIECAAAECBAgEBAz3QEkiEiBAgAABAgQIEDDc/QABAgQIECBAgACBgIDhHihJRAIECBAgQIAAAQKGux8gQIAAAQIECBAgEBAw3AMliUiAAAECBAgQIEDAcPcDBAgQIECAAAECBAIChnugJBEJECBAgAABAgQIGO5+gAABAgQIECBAgEBAwHAPlCQiAQIECBAgQIAAAcPdDxAgQIAAAQIECBAICBjugZJEJECAAAECBAgQIGC4+wECBAgQIECAAAECAQHDPVCSiAQIECBAgAABAgQMdz9AgAABAgQIECBAICBguAdKEpEAAQIECBAgQIDABT9oBHGy6bCzAAAAAElFTkSuQmCC"/>
<input type="hidden" id="drawBaseIE641" value="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAC6CAYAAADxncgCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAI0SURBVHhe7cExAQAAAMKg9U9tDB8gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4K4GhOIAAQ18YIgAAAAASUVORK5CYII=">

<input type="hidden" id="signatureCount" value=""/>
<input type="hidden" id="pageHeight" value=""/>
<input type="hidden" id="numpages" value=""/>
<input type="hidden" id="requiredCount" value=""/>

</body>
</html>