<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<jsp:include page="header.jsp"></jsp:include>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css" href="<%=appUrl %>/css/responsive.bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=appUrl %>/css/responsive.dataTables.css">
<link rel="stylesheet" href="<%=appUrl %>/css/jquery.dataTables.min.css"> 
 <style>
.pdfobject-container { height: 500px;}
.pdfobject { border: 1px solid #666; }

td.details-control {
    background: url('images/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.shown td.details-control {
    background: url('../images/details_close.png') no-repeat center center;
}
table.dataTable.display tbody tr.odd {
    background-color: #f1f1f1;
}
.error{
color:red !important;
}
</style>  
<%-- <link href="<%=appUrl %>/css/materialize.css" rel="stylesheet"/> --%>
<link rel="stylesheet" href="<%=appUrl %>/css/style.css"/>
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css"/>
<div class="content-wrapper bg_wrap">
    <div class="container-fluid">
	<!-- breadcrumb -->
	<ol class="breadcrumb">		
		<li>History</li>
		<li class="active">Completed Documents</li>			
	</ol>		
	</div>
    <!-- Main content -->
    <section class="container-fluid contentdoc">
    <div class="Content-wh-module">
	  <div class="row">
       	<div class="table_scroll">
        <div class="col-md-12 col-sm-12 col-xs-12  ">
		<table id="example" class="display table Data_table_heading dataTable no-footer" cellspacing="0" width="100%" style="font-size:16px;">
        	<thead>
	            <tr>
	               <th></th>
	                <!-- <th>ENVELOPE ID</th> -->
	                <th class="text-center">Title</th>
	                <!-- <th>SignedUser</th> -->
	                <!-- <th>Document Name</th> -->
	                <th class="text-left">Sign Type</th>
	                <th class="text-left">Date and Time</th>
	                <th class="text-left">Doc Id</th>
	                <th class="text-left"></th>
	            </tr>
        	</thead>
      	</table>
		</div>
		</div>
       </div>
       </div>
    </section>

<!-- Model Popup   -->



<div id="myModal" class="modal fade" role="dialog">
<form id = "emailform" name = "eform">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send Email </h4>
      </div>
      <div class="modal-body">
      <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
	                <div class="form-horizontal">
					  <div class="form-group">
					    <label for="inputEmail3" class="col-sm-4 control-label">Recipient Email Address<span class="redstar">*</span></label>
					    <div class="col-sm-8">
					      <input id="emailadd" type="text" name ="email" class="form-control" placeholder="Email">
					  
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword3" class="col-sm-4 control-label">Add CC</label>
					    <div class="col-sm-8">
					    
					     	<input id="cc" name="cc" type="text" class="form-control" placeholder="CC">
					    </div>
					  </div>
					   <div class="form-group">
					    <label for="inputPassword3" class="col-sm-4 control-label">Subject<span class="redstar">*</span></label>
					    <div class="col-sm-8">
					      	 <input id="subject" name="subject" type="text" class="form-control" placeholder="Subject">
					    </div>
					  </div>
					   <div class="form-group">
					    <label for="inputPassword3" class="col-sm-4 control-label">Message<span class="redstar">*</span></label>
					    <div class="col-sm-8">
					      <input id="docuID" name="docid" type="hidden" class="form-control">
					      <textarea id="message" name="message" class="form-control" placeholder="Message"></textarea>
					    </div>
					  </div>
					 
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10" style="margin-left:257px">
					      <button type="button"  id="" class="btn btn-danger"  data-dismiss="modal">CANCEL</button>
					      <button type="button" id="sendbtn1" onclick="sendemail();" style="text-transform: capitalize;" class="btn has-spinner btn-primary">SEND</button>&nbsp;&nbsp;
						 </div>
					  </div>
					</div>
     <!--              <div class="form-horizontal">
                     <div class="row ">
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="form-group">
					     		<input id="emailadd" type="text" name ="email" class="form-control">
								<label for="last_name">Recipient Email Address<span class="redstar">*</span></label>
							</div>
						</div> 
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="form-group">
							<label for="file_name">Add CC</label>
								<input id="cc" name="cc" type="text" class="form-control">
								</div>
							</div>
					  </div> 
					  <div class="row">
						  <div class="col-xs-12">						  	
						  	<div class="form-group">
						  	  <label for="file_name">Subject<span class="redstar">*</span></label>
							 <input id="subject" name="subject" type="text" class="form-control">
        					</div>
						  </div>
					  </div>
                      <div class="row">
						  <div class="col-xs-12">						  	
						  	<div class="form-group">
							 <textarea id="message" name="message" class="form-control"></textarea>
							<label for="textarea1">Message<span class="redstar">*</span></label>
							</div>
						  </div>
					  </div>
                      <input id="docuID" name="docid" type="hidden" class="form-control">
                      <ul class="list-inline text-right">                     
                      <li>
                       <button type="button"  class="btn btn-red font-16" onclick="checkEmailValid();">TEST</button>
                       <button class="btn has-spinner btn-default" type="submit">Button</button>
                        <button type="button"  id="" class="btn btn-danger"  data-dismiss="modal">Cancel</button>
                         <button type="button"  onClick="window.location.href = 'selfSign_message.html';"  class="btn btn-primary next-step">Send</button>
                         <button type="button" id="sendbtn1" onclick="sendemail();" class="btn has-spinner btn-primary">Send</button>
                      </li>
                     </ul>
                  </div> -->
                
				  </div>
                <!-- Buttons --> 
                
              </div>

      </div>
     <!--  <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>  -->
      <div class="alert alert-success fade in" style="display:none;text-align:center;margin: 0px;" id="emailsuccessalert" style="display:none">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="emailsuccess">Email has been sent successfully.</div>
</div> 
 <div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="emailfailalert" style="display:none">
				    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="emailfail"></div>
</div> 
    </div>

  </div>
  </form>
</div>

</div>
<!-- Button trigger modal -->
<button class="btn btn-primary btn-lg" type="hidden" data-toggle="modal" data-target="#myModal1" id="test" style="display:none">
  Launch demo modal
</button> 

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      </div>
      <div class="modal-body">
      <div id="example1"></div>
<!--         <div style="text-align: center;"> -->
<!-- <iframe id="myiframe" src="http://docs.google.com/gview?url=http://www.pdf995.com/samples/pdf.pdf&embedded=true"  -->
<!-- style="width:700px; height:800px;" frameborder="0" ></iframe> -->
<!-- </div> -->
      </div>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

<script src="<%=appUrl %>/js/materialize.js"></script>
<script src="<%=appUrl %>/js/pdfobject.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.10.4/typeahead.bundle.min.js"></script>
<script src="<%=appUrl %>/js/materialize-tags.min.js"></script>
 <script src="<%=appUrl %>/js/jquery.validate.js"></script>
 <script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
	<script>
	
	  function resizeIframe(obj) {
	    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
	  }
	
	function sendemail() {
	    var token = $("meta[name='_csrf']").attr("content");
	    var header = $("meta[name='_csrf_header']").attr("content");
	    var contextPath = $("#contextPath").val();
	    var subject = $('#subject');
	    var email = $('#emailadd');
	    var message = $("#message");
	    var cc = $("#cc");
	    var docId = $('#docuID').val();
	    var valid = $("#emailform").valid();
	    /* 		var data = {
	     "name" : name.val(),
	     "email" : email.val().trim(),
	     "message" : message.val()	     
	     } */
	    if (valid == true) {
	        $.ajax({
	            type: "POST",
	            url: 'sendemail',
	            data: {
	                subject: subject.val(),
	                email: email.val().trim(),
	                cc : cc.val(),
	                message: message.val(),
	                docId: docId
	            },
	            beforeSend: function(xhr) {
	                $('#sendbtn1').buttonLoader('start');
	                xhr.setRequestHeader(header, token);
	            },
	            complete: function() {
	            	//alert('HII');
	                $("#sendbtn1").buttonLoader('stop');
	            },

	            success: function(response) {
	            	//alert('SUCCESS');
	                if (response == 1) {
	                	$("#sendbtn1").buttonLoader('stop');
	                    $("#emailsuccessalert").show();
	                    document.getElementById("emailform").reset();
	                    document.getElementById("myModal").reset();
	                } else {

	                    $("#emailfailalert").show();
	                    $("#emailfail").html(response);
	                }
	            },
	            error: function(xhr, textStatus, errorThrown) {
	                alert('ajax loading error... ... ' + errorThrown);
	                console.log(errorThrown);
	                return false;
	            }
	        });
	    }
	}
	$('[data-dismiss=modal]').on('click', function (e) {
		emailForm.resetForm();
	    var $t = $(this),
        target = $t[0].href || $t.data("target") || $t.parents('.modal') || [];

  $(target)
    .find("input,textarea,select")
       .val('')
       .end();
});
	
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

	 var emailForm=$("#emailform").validate({
		 	/* errorElement: 'p',
	    	errorClass: 'error', */
			//specify the validation rules
			rules: {
				email: {
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
				email:{
		    		 required: "Please enter a valid email address"
		    	 },
				cc:{
		    		 required: "Please enter a valid email address"
		    	},
			},
	});
	 function displaySignType(signType){
		 var sType;
		 if(signType=='S'){
			 sType='<i class="icon-self fontIcon"></i>&nbsp; SELF';
		 }
		 if(signType=='G'){
			 sType='<i class="icon-group fontIcon"></i>&nbsp; GROUP';
		 }
		 if(signType=='R'){
			 sType='<i class="fa fa-globe"></i>&nbsp; Web Service Sign';
		 }
		 return sType;
	 }
	
	 function displaySigners(signType,signerEmail,signerName,signerStatus,priority,emailCount,signerEmailId){
		 var signers;
		 if(signType=='S'){
			 signers=signerEmail+'&nbsp<button type="button"  class="btn btn-success" style="cursor: inherit;">SIGNED</button>';
		 }
		 if(signType=='G' || signType=='R'){
			
				var sn=signerName.split(",");
				var ss=signerStatus.split(",");
				var pp=priority.split(",");
				//var ec=emailCount.split(",");
				var eID=signerEmailId.split(",");
				var msg=''; 
				
				if(pp[0] == 0){
					var content = "<table class='table table-bordered'><tr><th style='background:#00bc9c;font-size: 15px;'>Name</th><th style='background:#00bc9c;font-size: 15px;'>Email ID</th><th style='background:#00bc9c;font-size: 15px;'>Status</th></tr>";
					
					for(i=0; i<sn.length; i++){
						if(ss[i] == "0" || ss[i] == "1"){
					   		//content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-warning">PENDING</button></td></tr>';
							//}else{
							content += '<tr><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-success" style="cursor: inherit;">SIGNED</button></td></tr>';
						}
					}
					content += "</table>"
				}else{
				var content = "<table class='table table-bordered'><tr><th style='background:#00bc9c;font-size: 15px;'>Priority</th style='background:#00bc9c;font-size: 15px;'><th style='background:#00bc9c;font-size: 15px;'>Name</th><th style='background:#00bc9c;font-size: 15px;'>Email ID</th><th style='background:#00bc9c;font-size: 15px;'>Status</th></tr>";
				
				for(i=0; i<sn.length; i++){
					if(ss[i] == "0" || ss[i] == "1"){
				   		//content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-warning">PENDING</button></td></tr>';
						//}else{
						content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-success" style="cursor: inherit;">SIGNED</button></td></tr>';
					}
				}
				content += "</table>"
				}
			signers=content;
				
		 }
		 
		 return signers;
	 }
	
	function format ( d ) {
	    // `d` is the original data object for the row
	    var y=displaySignType(d.signType);
	    
	    var z=displaySigners(d.signType,d.signerEmail,d.signerName,d.signerStatus,d.priority,d.emailCount,d.signerEmailId);
	    
	    return '<table  cellpadding="5" width="80%" cellspacing="0" border="0" style="padding-left:50px;">'+
	       /*  '<tr>'+
	            '<td>Full name:</td>'+
	            '<td>'+d.requestedBy+'</td>'+
	        '</tr>'+ */
	       /*  '<tr>'+
            	'<td><strong>Title:</strong></td>'+
           	 	'<td>'+d.subject+'</td>'+
        	'</tr>'+  */
        	'<tr>'+
            '<td><strong>Envelope Id:</strong></td>'+
            '<td>'+d.envelopeId+'</td>'+
        	'</tr>'+  
        	'<tr>'+
            '<td><strong>Document Name:</strong></td>'+
            '<td>'+d.documentName+'</td>'+
        	'</tr>'+  

        	'<tr>'+
	            '<td><strong>Requested By:</strong></td>'+
	            '<td>'+d.requestedBy+'</td>'+
	        '</tr>'+ 
	       /*  '<tr>'+
	            '<td><strong>Type:</strong></td>'+
	            '<td>'+y+'</td>'+
	        '</tr>'+  */
	        '<tr>'+
	            '<td><strong>Signers:</strong></td>'+
	            '<td>'+z+'</td></td>'+
       		 '</tr>'+ 
	        '<tr>'+
	            '<td><strong>View File:</strong></td>'+
	            '<td><button type="button" onclick="view('+d.docId+');" class="btn btn-yellow">VIEW</button></td>'+
	            
	        '</tr>'+
	        	'<td><strong>Download File:</strong></td>'+
        		'<td><button type="button" onclick="view1('+d.docId+');" class="btn btn-red">DOWNLOAD</button></td>'+
        	'</tr>'+
        	'<tr>'+
        		'<td><strong>Subject:</strong></td>'+
       	 		'<td>'+d.subject+'</td>'+
    		'</tr>'+ 
    		'<tr>'+
    			'<td><strong>Message:</strong></td>'+
   	 			'<td>'+d.message+'</td>'+
			'</tr>'+ 
	    '</table>';
	}
	
	 
	 
	$(document).ready(function() {
		
		 var dataSet=${list};
		 
		 
		var table= $('#example').DataTable( {
    		 data: dataSet,
    		 order: [],
    	        columns: [
					 {
					    "className":      'details-control',
					    "orderable":      false,
					    "data":           null,
					    "defaultContent": ''
					},
					
					{ "data": "subject" }, 
	/* 				{ "data": "documentName" }, */
					{ "data": "signType" },
					{ "data": "completedDate" },
					{ "data": "docId" },
					{
					    "data":           null,
					    "defaultContent": '<li class="dropdown pull-right "> <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true"> <i class="fa fa-ellipsis-v" aria-hidden="true"></i></a><ul class="dropdown-menu"><li><a class="email" href="#" data-backdrop="static" data-toggle="modal" data-target="#myModal" data-keyboard="false">SEND EMAIL</a></li></ul></li>'
					},
				/* 	{ "data": "message" } */
    	      ],
    	      columnDefs : [
    	                    { targets : [2],
    	                      render : function (data, type, row) {
    	                    	 if(data == 'S'){
    	                    		 data = 'Self Sign';
    	                    	 }else if(data == 'G'){
    	                    		 data = 'Group Sign';
    	                    	 } else if(data == 'R'){
    	                    		 data = 'WebService Sign';
    	                    	 } 
    	                    	 return data ;
    	                      }
    	                    },
    	                     {
    	                    	                "targets": [ 4 ],
    	                    	                "visible": false,
    	                    	                "searchable": false
    	                    	            }
     	                    
    	               ]
 	       } );
		 
		 $('#example tbody').on('click', 'td.details-control', function () {
		        var tr = $(this).closest('tr');
		        var row = table.row( tr );
		 
		        if ( row.child.isShown() ) {
		            // This row is already open - close it
		            row.child.hide();
		            tr.removeClass('shown');
		        }
		        else {
		            // Open this row
		            row.child( format(row.data()) ).show();
		            tr.addClass('shown');
		        }
		  }); 
		 
		 $('#example tbody').on('click', 'a.email', function() {

			    /*
			    var data = $('#example')
			    .DataTable()
			    .row( $(this).parents('tr') )
			    .data();
			    
			    alert(data.existing);
			*/
			    
			    var row = $('#example').DataTable().row( $(this).parents('tr') ),
			        index = row.index(),
			        data = row.cell(index, 4).data();
					$("#docuID").val(data) ;
			//document.getElementById("docuID").value = data;
			   // alert(data);
			});
	 
	} );
	</script>
	<script>
  	function view(docId){
  		var contextPath=$("#contextPath").val();
  		 $.ajax({
			type : "GET",
			url : "<%=appUrl%>/app/downloadFiles/internal",
			data : "docId="+docId,
			success : function(response) {
				
				if(response){
					var a=contextPath+'app/download/internal?fileName='+response+"&docId="+docId;
					PDFObject.embed(a, "#example1");
				//	 document.getElementById('myiframe').src = contextPath+'app/download/internal?fileName='+response+"&docId="+docId;
					 document.getElementById("test").click();
				//	window.open(contextPath+'app/download/internal?fileName='+response+"&docId="+docId);
					
				}else{
					alert("Error in File Verification.");
				}
				

			}
		}); 
  	}
  	
	function view1(docId){

		var contextPath=$("#contextPath").val();
 		 $.ajax({
			type : "GET",
			url : "<%=appUrl%>/app/downloadFiles/external",
			data : "docId="+docId,
			success : function(response) {
				
				if(response){
					
					//alert("Your file is verified"+response);
					window.open(contextPath+'app/download/external?fileName='+response+"&docId="+docId);
				
				}else{
					alert("Error in File Verification.");
				}
				

			}
		}); 
 	}
  	</script>