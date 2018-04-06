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
 .Message {
      box-shadow: 0px 0px 10px 1px #d4d4d4 !important;
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

</style>  
<link rel="stylesheet" href="<%=appUrl %>/css/style.css"/>
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css"/>

<div class="content-wrapper bg_wrap">
    <div class="container-fluid">
	<!-- breadcrumb -->
	<ol class="breadcrumb">		
		<li>History</li>
		<li class="active">Draft</li>			
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
	                <th class="text-left"> </th>
	                <th class="text-center">Title</th>
	                <th>Sign Type</th>
	                <th>Date and Time</th>
	               <!--  <th>Status</th> -->
	                <th class="text-left"> </th>
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
<jsp:include page="footer.jsp"></jsp:include>
<script>
$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var dataSet=${list};
	var table= $('#example').DataTable( {
		 data: dataSet,
		 order: [ 3, "desc" ],
	        columns: [
				{ "data": "envelopeId" },
				
				{ "data": "documentName" }, 
/* 				{ "data": "documentName" }, */
				{ "data": "signType" },
				{ "data": "completedDate" },
				{ "data": "envelopeId" },
/* 				{
				    "data":           null,
				    "defaultContent": '<li class="dropdown pull-right "> <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true"> <i class="fa fa-ellipsis-v" aria-hidden="true"></i></a><ul class="dropdown-menu"><li><a class="text-green" href="'+contextPath+'app/document/redirect/'+data+'">Edit</a></li><li><a href="#" class="text-red" onclick="deleteDocument(\''+data+'\');"">Delete</a></li></ul></li>'
				}, */

			/* 	{ "data": "message" } */
	      ],
	      columnDefs : [
 	                    { targets : [4],
	                      render : function (data, type, row) {
	                    	  data = '<li class="dropdown pull-right "> <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true"> <i class="fa fa-ellipsis-v" aria-hidden="true"></i></a><ul class="dropdown-menu"><li><a class="text-green" href="'+contextPath+'app/document/redirect/'+data+'">Edit</a></li><li><a href="#" class="text-red" onclick="deleteDocument(\''+data+'\');"">Delete</a></li></ul></li>';//'<a class="text-green" href="'+contextPath+'app/document/redirect/'+data+'">Edit</a><a href="#" class="text-red" onclick="deleteDocument(\''+data+'\');"">Delete</a>';
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
  	                    },
                   		{
             	                "targets": [ 0 ],
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

} );
function deleteDocument(docId){
	//alert('HII');
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
</script>