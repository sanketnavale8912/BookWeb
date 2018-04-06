<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%> 
<jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css" href="<%=appUrl %>/css/responsive.bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=appUrl %>/css/responsive.dataTables.css">
<link rel="stylesheet" href="<%=appUrl %>/css/jquery.dataTables.min.css"> 
 <style>
 
 .table .table img {
    margin: 0 3px;
}
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

 .loader2 {
    position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=appUrl %>/images/ajax-loader_1.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
 }
</style>  
<link rel="stylesheet" href="<%=appUrl %>/css/style.css"/>
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css"/>
	  	       	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="<%=appUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.css">
<div id="loader2" class="loader2" style="display:none"></div>
<div class="content-wrapper bg_wrap">
    <div class="container-fluid">
	<!-- breadcrumb -->
	<ol class="breadcrumb">		
		<li>History</li>
		<li class="active">Out For Signature</li>			
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
	                <th>Sign Type</th>
	                <th>Date and Time</th>
	                <th></th>
	            </tr>
        	</thead>
      	</table>
		</div>
		</div>
       </div>
       </div>
    </section>
</div>
<div class="Message" id="deleteDocument">	
    <div>
	  	<a class="close" href="#" onclick="hiderDocumentPopUp();"><span class="icon-close"></span></a>
	  </div>
		 <div class="header text-center margTB20 paddLR10">		 	
		 	Do you really want to delete document?
		 </div>	
	  <div class="text-center">	  
		<button type="button" class="btn btn-primary" onclick="deleteDocumentPopUp();" >YES</button>
		<button type="button" class="btn btn-danger" onclick="hiderDocumentPopUp();" >NO</button>
	  </div> 	
 </div>
 <div class="overlay-bg"></div>
  <input type="hidden" id="docId" value=""/>
   <input type="hidden" id="signerEmailId" value=""/>
<jsp:include page="footer.jsp"></jsp:include>
	 <script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.js"></script>
	<script>
	
	 function displaySigners(signerName,signerStatus,priority,emailCount,signerEmailId, envelopeId, documentName, requestedBy, subject, message,docId,signerId) {
		
		var sn=signerName.split(",");
		var ss=signerStatus.split(",");
		var si=signerId.split(",");
		var pp=priority.split(",");
		//alert(emailCount);
		//var ec=emailCount.split(",");
		var eID=signerEmailId.split(",");
		var msg=''; 
		var message=message.replace(/\n|\r/g, "").split( "\"" ).join( "\\\"" ); 
		var subject= subject.replace(/\n|\r/g, "").split( "\"" ).join( "\\\"" ); 
		
		
	/* 	 var envelopeId = envelopeId.split(",");
		var documentName = documentName.split(",");
		var requestedBy = requestedBy.split(",");
		var subject = subject.split(",");
		var message = message.split(","); */ 
		$("#signerEmailId").val(eID);
		//alert(pp[0]);
		if(pp[0] == 0){
			var content = "<table class='table  table-signers'><tr><th>Name</th><th>Email ID</th><th>Status</th><th width='20%'>Action</th></tr>";
			//	var content = "<table class='table table-bordered'><tr><th>Name</th><th>Email ID</th><th>Status</th></tr>";
			for(i=0; i<sn.length; i++){
				if((ss[i] == "0" || ss[i] == "false")){
			   		content += '<tr><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-red" style="cursor: context-menu;">WAITING</button></td><td><img type="button" data-toggle="tooltip" data-placement="top" title="Notify" id="send_reminder_'+i+'" src="<%=appUrl %>/images/Notify_icon.png"  onclick="sendReminder(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\',\''+si[i]+'\',\''+i+'\')"><img type="button" data-toggle="tooltip" data-placement="top" title="Reassign" id="send_raessign_'+i+'" src="<%=appUrl %>/images/re-assign_icon.png"  onclick="sendReassign(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\',\''+si[i]+'\',\''+i+'\',\''+eID+'\')"><img type="button" data-toggle="tooltip" data-placement="top" title="Discard" id="send_discard_'+i+'" src="<%=appUrl %>/images/Discard_icon.png" onclick="sendDiscard(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\',\''+si[i]+'\',\''+i+'\',0)"></td></tr>';
					//content += '<tr><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-red">WAITING</button></td></tr>';
				}//else if((ss[i] == "0" || ss[i] == "false") ){
			   		//content += '<tr><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-red">WAITING</button></td><td>'+ec[i]+'&nbsp;&nbsp;<button type="button" class="btn-sm btn-warning"  onclick="sendReminder(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\')" class="btn btn-yellow">REMIND</button></td></tr>';
				else if(ss[i] == "1" || ss[i] == "true"){
					content += '<tr><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button style="cursor: context-menu;" type="button" class="btn btn-success">SIGNED</button></td><td></td></tr>';
				}
			}
			content += "</table>"
		}else{
		
		var content = "<table class='table  table-signers'><tr><th>Priority</th><th>Name</th><th>Email ID</th><th>Status</th><th width='20%'>Action</th></tr>";
		
			for(i=0; i<sn.length; i++){
				if((ss[i] == "0" || ss[i] == "false")){
			   		content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button style="cursor: context-menu;" type="button" class="btn btn-red">WAITING</button></td><td><img type="button" data-toggle="tooltip" data-placement="top" title="Notify" id="send_reminder_'+i+'" src="<%=appUrl %>/images/Notify_icon.png"  onclick="sendReminder(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\',\''+si[i]+'\',\''+i+'\')"><img type="button" data-toggle="tooltip" data-placement="top" title="Reassign"  id="send_raessign_'+i+'" src="<%=appUrl %>/images/re-assign_icon.png"  onclick="sendReassign(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\',\''+si[i]+'\',\''+i+'\',\''+eID+'\')"><img type="button" data-toggle="tooltip" data-placement="top" title="Discard" id="send_discard_'+i+'" src="<%=appUrl %>/images/Discard_icon.png" onclick="sendDiscard(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\',\''+si[i]+'\',\''+i+'\',0)"></td></tr>';
					//content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-red">WAITING</button></td> </tr>';
				}/* else if((ss[i] == "0" || ss[i] == "false") && ec[i]>0){
			   		content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn btn-red">WAITING</button></td><td>&nbsp;&nbsp;<button type="button" class="btn-sm btn-warning" onclick="sendReminder(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\')" class="btn btn-yellow">REMIND</button></td></tr>';
				} */else if(ss[i] == "1" || ss[i] == "true"){
					content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button style="cursor: context-menu;" type="button" class="btn btn-success">SIGNED</button></td><td></td></tr>';
				}
			}
			content += "</table>"
		}
				
		//alert(msg);
		return content;r
	    
	}
	function sendReminder(signerName,signerEmailId,envelopeId,documentName,requestedBy,subject,message,docId,signerId,id)
	{	
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var btn=$("#send_reminder_"+id);
		$.confirm({
		    title: 'Confirm!',
		    content: 'Are you sure want to send reminder?',
		    buttons: {
		        confirm: function () {
		        	$.ajax({
						type : "POST",
						url : "sendreminder",
						data: {"signerName":signerName, "signerEmailId":signerEmailId, "envelopeId":envelopeId, "documentName":documentName, "requestedBy":requestedBy, "subject":subject, "message":message,"docId":docId,"signerId":signerId},
						beforeSend : function(xhr) {	                
							xhr.setRequestHeader(header, token);
							$(btn).buttonLoader('start');
						},
					    complete : function() {
					 	   	$(btn).buttonLoader('stop');
						},
						success : function(response) 
						{						
							 $.alert('The reminder has been sent to '+signerName+' ('+signerEmailId+') successfully.');
						}
				  }); 
		        },
		        cancel: {
		            //close
		        },
		    }
		});
		/* if(confirm("Are you sure want to send reminder?"))
		{			
			   
		} */
	}
	 
	
	function format ( d ) {
		
		var y=displaySigners(d.signerName,d.signerStatus,d.priority,d.emailCount,d.signerEmailId, d.envelopeId, d.documentName, d.requestedBy, d.subject, d.message,d.docId,d.signerId);
	    // `d` is the original data object for the row
	    return '<table class="dataTable no-footer" cellpadding="5" cellspacing="0" border="0" style="padding-left:50px; width: 100%;">'+
	       /* '<tr>'+
	            '<td>Full name:</td>'+
	            '<td>'+d.requestedBy+'</td>'+
	        '</tr>'+  */
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
	        '<tr>'+
            	'<td><strong>Signers:</strong></td>'+
           		'<td>'+y+'</td>'+
       		'</tr>'+ 
       	 	
       		/* '<tr>'+
        		'<td><strong>Status:</strong></td>'+
       			'<td>'+x+'</td>'+
   			'</tr>'+  
   			'<tr>'
    			'<td><strong>Status:</strong></td>'+
   				'<td>'+y+'</td>'+
			'</tr>'+  
	       /*  '<tr>'+
	            '<td><strong>Signers:</strong></td>'+
	            '<td>'+d.requestedBy+'&nbsp <button type="button"  class="btn-sm btn-success">SIGNED</button></td></td>'+
       		 '</tr>'+ */ 
       		
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
					{ "data": "signType" },
					{ "data": "uploadDate" },
					{ "data": "envelopeId" }
    	      ],
    	      columnDefs : [
    	                    { targets : [4],
    		                      render : function (data, type, row) {
    		                    	  data = '<li class="dropdown pull-right "> <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true"> <i class="fa fa-ellipsis-v" aria-hidden="true"></i></a><ul class="dropdown-menu"><li><a href="#" class="text-red" onclick="deleteDocument(\''+data+'\');"">Delete</a></li></ul></li>';//'<a class="text-green" href="'+contextPath+'app/document/redirect/'+data+'">Edit</a><a href="#" class="text-red" onclick="deleteDocument(\''+data+'\');"">Delete</a>';
    		                    	  return data ;
    		                      }
    		                    },
    	                    
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
	 
	} );
	
	function deleteDocument(docId){
		//alert(docId);
		$("#docId").val(docId)
		$('.overlay-bg').show();
	     
		$('#deleteDocument').show();
		$('.overlaywhite_bg').show();
	}
	function hiderDocumentPopUp(){
		$('.overlay-bg').hide();
		$('#deleteDocument').hide();
		$('.overlaywhite_bg').hide();
	}

	function deleteDocumentPopUp(){
		
		var docId=$("#docId").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var contextPath=$("#contextPath").val();
		$.ajax({
			//contentType : 'application/json; charset=utf-8',
			type : "GET",
			url : contextPath+"app/deleteDocumentByEnvelopeId?docId="+docId,
			beforeSend : function(xhr) {
				//$('#signupbtn').buttonLoader('start');
				xhr.setRequestHeader(header, token);
			},
			complete : function() {
				//$("#signupbtn").buttonLoader('stop');
			},success : function(response) {
				//alert(response);
				if(response == "success"){
					$("#deleteDocument").hide();
					$('.overlaywhite_bg').hide();
					location.reload();
				}else{
					alert('loading error.');
				}
			},
			error: function(xhr, textStatus, errorThrown)
			 {
			 	alert('ajax loading error... ... ');
			 	return false;
			}
		})	
		
	}
	function validateEmail(sEmail) {
	    var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    if (filter.test(sEmail)) {
	        return true;
	    }
	    else {
	        return false;
	    }
	}
function sendDiscard(signerName,signerEmailId,envelopeId,documentName,requestedBy,subject,message,docId,signerId,id,priority){
		
		$.confirm({
			title: 'Discard!',
		    content: 'Are you sure want to remove signer <strong>'+signerEmailId+'</strong>?',
		    buttons: {
		        confirm: function () {
		        		   var token = $("meta[name='_csrf']").attr("content");
		              		var header = $("meta[name='_csrf_header']").attr("content");
		              		var btn=$("#send_discard_"+id);
      						$.ajax({
         						type : "POST",
         						url : "sendDiscard",
         						data: {"signerName":signerName, "signerEmailId":signerEmailId, "envelopeId":envelopeId, "documentName":documentName, "requestedBy":requestedBy, "subject":subject, "message":message,"docId":docId,"signerId":signerId,"priority":priority},
         						 beforeSend: function (xhr) {
         				   			xhr.setRequestHeader(header, token);
         				   			$("#loader2").show();
         					    },
         					    complete: function () {
         					    	$("#loader2").hide();
         					    },
         						success : function(response) 
         						{						
         							 $.each(response, function(val, text) {
         								 
         								$.confirm({
										    title: 'Done!',
										    content: text,
										    buttons: {
										        somethingElse: {
										            text: 'Ok',
										            action: function(){
										            	location.reload();
										            }
										        }
										    }
										});
         								
         							 });
         							
         						}
         				  }); 
		          },
		          cancel: {
			            //close
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
    	
	function sendReassign(signerName,oldEmail,envelopeId,documentName,requestedBy,subject,message,docId,signerId,id,signerList){
		//alert(signerList);
		$.confirm({
		    title: 'Re-Assign!',
		    content: '' +
		    '<form action="" class="formName">' +
		    '<div class="form-group">' +
		   
		    '<input type="text" id="txtFullname" placeholder="Enter name here" class="form-control" required />' +
		    '</div>' +
		   
		
		    '<input type="text" id="txtEmail" placeholder="Enter email here" class="form-control" required />' +
		    '</div>' +
		    '</form>',
		    buttons: {
		        formSubmit: {
		            text: 'Submit',
		            btnClass: 'btn-primary',
		            action: function () {
		            	  var newEmail = $('#txtEmail').val();
		                  var txtFullname=$('#txtFullname').val();
		                  if(txtFullname.length ==0){
		                	  $.alert('Please enter name');
		                      e.preventDefault();
		                  }
		            	  if ($.trim(newEmail).length == 0) {
		                     $.alert('Please enter valid email address');
		                      e.preventDefault();
		                  }
		                  if (validateEmail(newEmail)) {
		                	   var checkEmailExist = signerList.indexOf(newEmail);
		                	   
		                	   if(checkEmailExist > -1){
		                		   $.alert('This email address is already exist in signers.');
				                   e.preventDefault();
		                	   }else{
		                	    var token = $("meta[name='_csrf']").attr("content");
			              		var header = $("meta[name='_csrf_header']").attr("content");
			              		var btn=$("#send_reassign_"+id);
           						$.ajax({
              						type : "POST",
              						url : "sendReAssign",
              						data: {"signerName":txtFullname, "oldEmail":oldEmail, "newEmail":newEmail, "envelopeId":envelopeId, "documentName":documentName, "requestedBy":requestedBy, "subject":subject, "message":message,"docId":docId,"signerId":signerId},
              						 beforeSend: function (xhr) {
              				   			xhr.setRequestHeader(header, token);
              				   			$("#loader2").show();
              					    },
              					    complete: function () {
              					    	$("#loader2").hide();
              					    },
              						success : function(response) 
              						{						
              							//alert('SUCCESS'); 
              								$.confirm({
											    title: 'DONE!',
											    content: 'Email has been sent to '+txtFullname+' ('+newEmail+') successfully.',
											    buttons: {
											        somethingElse: {
											            text: 'Ok',
											            action: function(){
											            	location.reload();
											            }
											        }
											    }
											});
              						}
              					  });  
		                	 }
			              		        
		                  }
		                  else {
		                      $.alert('Invalid Email Address');
		                      e.preventDefault();
		                  }
		                //$.alert('Your name is ' + name);
		            }
		        },
		        cancel: {
		            //close
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
	</script>
	