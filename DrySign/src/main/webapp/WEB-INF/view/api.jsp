
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <jsp:include page="plan_header.jsp" />
<% 

String port = request.getServerPort()+"";
if((port !=null || port != "") && port !="443" )
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
String apiUrl = request.getScheme() + "://" + request.getServerName() + port+"/";
String serviceUrl = apiUrl+"DrySignService";
%>



    <style>
    ul.flexiselDemo3 li {
    float: none;
    display: inline-block;
    list-style: none;
}
.tab-content,.pricing_website {
    min-height: 450px;
}
    </style>
<div class="container-fluid pricing_website">
         <!-- /.breadcrumb -->
         <!--         <ul class="breadcrumb">
            <li><a href="../index.html">Home</a></li>
            <li class="active">pricing</li>
            </ul> -->
         <div class="row">
            <div class="bg-no-overlay">
               <div class="row">
                  <!--         <h1>This is a background image<br> with NO overlay.</h1>
                     <br><br>
                     <button type="button" class="btn btn-primary btn-lg">Get Started</button> -->
                  <div class="col-md-6 col-sm-6"></div>
                  <div class="col-md-6 col-sm-6 head-txt">
                     <div>
                        <a href="apiregistration" class="btn api-key-btn btn-lg">GET AN API KEY</a>
                     </div>
                     <h2>Leave your wet signatures behind <br />Sign anywhere, anytime from any device.</h2>
                  </div>
               </div>
            </div>
            <div class="container">
               <div class="rest-info">
                  <h2>REST Endpoints API</h2>
                  <p style="    color: #808081;">
                     With the DrySign REST API, developers can provision accounts, post documents, create signing invites, and more. You can also use the API to view status on all existing documents, including required fields, user provided field data, complete audit history, status of outstanding invites, complete document structure.
                  </p>
               </div>
               <div class="user-txt">
                  <h2>API</h2>
               </div>
               <div class="post-user">
                  <p>LOGIN</p>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Description</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Every request need to access service by oauth2 token, for generation for oauth2 token you need to first register with DrySign. After registration you will get free subscription plan subscribed in your account. Once your free subscription over you need to subscribe DrySign subscription plan from available plans. </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example request</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p><%=serviceUrl %>/oauth/token?grant_type=password&client_id=restapp<br/>&client_secret=restapp&username=your_username&password=your_password </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Authorization</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Basic</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Accept</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Content-Type</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>HTTP Method</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Post</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Parameters</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     
                     <p>
                       None.
                     </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example response</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     
                     { <br/>
						"value": "c0b52bae-c750-4f6e-9f0f-7076fe214ed0",<br/>
						"expiration": 1496297673726,<br/>
						"tokenType": "bearer",<br/>
						"refreshToken": {<br/>
							"value": "57d5fa4f-9dc2-4b42-91c4-cc505f562805",<br/>
							"expiration": 1498889553724<br/>
						},<br/>
						"scope": [],<br/>
						"additionalInformation": {},<br/>
						"expiresIn": 119,<br/>
						"expired": false<br/>
					}
                     </p>
                  </div>
               </div>               
               <div class="mid-info">
                  <p>In the response you need to provide value parameter to every request to access the resource uri.
                  <br/><b>NOTE : For every request user will have to call login service first, get the token from it and provide it into the intended request, otherwise service will not be permitted to serve the request.</b></p>
               </div>
               
               
               
               
                
               <div class="post-user">
                  <p>CREATE DOCUMENT</p>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Description</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>In this request user will create document and document signers. It will get return 
                     envelope_id of document that is unique for particular document.
                      User can prepare document by keeping url from response and put it into iframe or division.</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example request</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p><%=serviceUrl %>/rest/api/preparedocumentapi/?access_token=d4d38e35-314f-4fdb-baae-af2135505a80 </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Authorization</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Basic</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Accept</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Content-Type</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>HTTP Method</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Post</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Parameters: BODY RAW </p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     	{<br/>
						  "id" : 0,<br/>
						  "envelopeId" : null,<br/>
						  "documentName" : "agreement.pdf",<br/>
						  "filePath" : "send base64 string of pdf document",<br/>
						  "originatorEmail" : "your.registered.email@domain.com",<br/>
						  "signerEmail" : "signer1@domain.com,signer2@domain.com",<br/>
						  "signerName" : "signer1,signer2",<br/>
						  "status" : null,<br/>
						  "url" : null,<br/>
						  "prepareReturnUrl" : "your_server.com/preparereturnurl",<br/>
						  "returnUrl" : "your_server.com/signreturnurl",<br/>
						  "viewDocumentUrl" : "",<br/>
						"createdOn" : null,<br/>
						  "updatedOn" : null,<br/>
						  "documentFields" : [],<br/>
						  "subject" : "DrySign Invitation",<br/>
						  "message" : "asked you to sign this document ",<br/>
						  "clientIPAddress" : null,<br/>
						  "event" : null<br/>
						}<br/>
                     </p>
                     
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example response</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     
						{<br/>
							  "id" : 0,<br/>
							  "envelopeId" : "a24ae92d-e887-4cfb-aa12-074741ff2fc8",<br/>
							  "documentName" : "agreement.pdf",<br/>
							  "filePath" : "",<br/>
							  "originatorEmail" : "your.registered.email@domain.com",<br/>
							  "signerEmail" : "signer1@domain.com,signer2@domain.com",<br/>
							  "signerName" : "signer1,signer2",<br/>
							  "status" : null,<br/>
							  "url" : "<%=apiUrl %>prepareDocument?key=F6FPzaF5MclKewfllWFQ8Spah",<br/>
							  "returnUrl" : "your_server.com/signreturnurl",<br/>
							  "prepareReturnUrl" : "your_server.com/preparereturnurl",<br/>
							  "viewDocumentUrl" : "<%=apiUrl %>viewReadOnlyDocument?envelopeid=a24ae92d-e887-4cfb-aa12-074741ff2fc8",<br/>
							  "createdOn" : null,<br/>
							  "updatedOn" : null,<br/>
							  "documentFields" : [],<br/>
							  "subject" : "DrySign Invitation",<br/>
							  "message" : "asked you to sign this document ",<br/>
							  "clientIPAddress" : "0:0:0:0:0:0:0:1",<br/>
							  "event" : null<br/>
							}
                     </p>
                  </div>
               </div>               
               <div class="mid-info">
                  <p>In this request you need to provide access_token that is oauth2 token generated by login api, value parameter.</p>
               </div>
               
               
               
               
               
               
                <div class="post-user">
                  <p>GET SIGNERS API</p>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Description</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p> Once url prepared successfully it will redirected to the prepare return url, 
                     here configuration needs to call get signers api by providing parameter envelope id 
                     of document. It will return all the signers url parameter as signDocumentUrl.
                      </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example request</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
						<%=serviceUrl %>/rest/api/getsigners/?access_token=fdfd97d6-3a9c-4233-8046-464baec6fad4</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Authorization</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Basic</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Accept</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Content-Type</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>HTTP Method</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Post</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Parameters: BODY RAW </p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     	Enveloped id of created document for example: ddb555cb-2aa2-4e97-a00c-3fbe7ba4bc52
                     </p>
                     
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example response</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     
						{<br/>
						  "documentSigner" : [ {<br/>
						    "signerName" : "signer1",<br/>
						    "signerEmail" : "signer1@domain.com",<br/>
						    "signerStatus" : "0",<br/>
						    "signDocumentUrl" : "null"<br/>
						  }, {<br/>
						    "signerName" : "signer2",<br/>
						    "signerEmail" : "signer2@domain.com",<br/>
						    "signerStatus" : "0",<br/>
						    "signDocumentUrl" : "null"<br/>
						  } ],<br/>
						  "message" : "Response message from server in case any error occur."<br/>
						}<br/>
                     </p>
                  </div>
               </div>               
               <div class="mid-info">
                  <p>In this request you need to provide access_token that is oauth2 token generated by login api value parameter.</p>
               </div>
               
               
               
               
               
                <div class="post-user">
                  <p>DOWNLOAD DOCUMENT API</p>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Description</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>When signers sign the document by signing link it will return to return url here client api needs to check how much signers are remaining
                     or not signed the document by calling the get signers api in the response check
                      parameter status 1=>signed, 0= not sign.
                      Once all the signers sign the doucment client api need to call the download document api, It will return signed base64 string of pdf docuemnt.</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example request</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p><%=serviceUrl %>/rest/api/download/?access_token=5bb98e21-3a65-4d21-a5a5-a55c20b0dfd0 </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Authorization</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Basic</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Accept</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Content-Type</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>HTTP Method</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Post</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Parameters: BODY RAW </p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                    <p>
                     	<!-- Enveloped id of created document for example: ddb555cb-2aa2-4e97-a00c-3fbe7ba4bc52 -->
                     	
                     	{"envelopeId":"7cedddab-132a-4654-b7a1-6eded8d5ced8", "fileName":"filename.pdf", "status":""}
                     </p>
                     
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example response</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     
						{<br/>
						  "base64String" : "",<br/>
						  "message" : "Response message from server in case any error occur."<br/>
						}
                     </p>
                  </div>
               </div>               
               <div class="mid-info">
                  <p>In this request you need to provide access_token that is oauth2 token generated by login method api parameter.</p>
               </div>
               
               
               
               
               
               <div class="post-user">
                  <p>BACKGROUND SIGN DOCUMENT API</p>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Description</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>This api provides the background signing functionality to client applications.
Client application simply provides the document in the base64 format and signing fields(signature/name/date) of signer and their positions. In the response it will return the envelope id with success message.
Client application needs to call the download method by passing envelopeid and file name, It will return the signed document in the base64 format.
<br/>
If signatures not exist of particular signer in the DrySign, I will print the name instead of signature into document.
For creating signature of signer, we provide a create signature service where signer can create his/her signature.</p>
</div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example request</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p><%=serviceUrl %>/rest/api/backgroundsigndocument/?access_token=3ffd98de-b198-49b4-a372-6f7fa5da05da </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Authorization</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Basic</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Accept</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Content-Type</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>HTTP Method</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Post</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Parameters: BODY RAW </p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                    <p>
                     	<!-- Enveloped id of created document for example: ddb555cb-2aa2-4e97-a00c-3fbe7ba4bc52 -->
                     	
                     	{<br/>
					  "documentName" : "test.pdf",<br/>
					  "fileBase64String" : "provide base64 string of pdf document",<br/>
					  "originatorEmail" : "your.registered.email@domain.com",<br/>
					  "subject" : "DrySign Invitation",<br/>
					  "message" : "asked you to sign this document ",<br/>
					 
					  "documentFields" :<br/>
					   [ {<br/>
					    "signerEmail" : "signer1@domain.com",<br/>
					    "signerName" : "signer1",<br/>
					    "pageNumber" : 1,<br/>
					    "fieldType" : "text",<br/>
					    "fieldName" : "name",<br/>
					    "fieldValue" : "sanket navale",<br/>
					    "xPosition" : 200.0,<br/>
					    "yPosition" : 10.0,<br/>
					    "fieldHeight" : 55.0,<br/>
					    "fieldWidth" : 200.0<br/>
					  },{<br/>
					    "signerEmail" : "signer1@domain.com",<br/>
					    "signerName" : "signer1",<br/>
					    "pageNumber" : 1,<br/>
					    "fieldType" : "text",<br/>
					    "fieldName" : "date",<br/>
					    "fieldValue" : "7/26/2017",<br/>
					    "xPosition" : 400.0,<br/>
					    "yPosition" : 10.0,<br/>
					    "fieldHeight" : 55.0,<br/>
					    "fieldWidth" : 200.0<br/>
					  },{<br/>
					    "signerEmail" : "signer1@domain.com",<br/>
					    "signerName" : "signer1",<br/>
					    "pageNumber" : 1,<br/>
					    "fieldType" : "image",<br/>
					    "fieldName" : "sign",<br/>
					    "fieldValue" : null,<br/>
					    "xPosition" : 100.0,<br/>
					    "yPosition" : 100.0,<br/>
					    "fieldHeight" : 55.0,<br/>
					    "fieldWidth" : 200.0<br/>
					  },{<br/>
					    "signerEmail" : "signer2@domain.com",<br/>
					    "signerName" : "signer2",<br/>
					    "pageNumber" : 2,<br/>
					    "fieldType" : "image",<br/>
					    "fieldName" : "sign",<br/>
					    "fieldValue" : null,<br/>
					    "xPosition" : 100.0,<br/>
					    "yPosition" : 100.0,<br/>
					    "fieldHeight" : 55.0,<br/>
					    "fieldWidth" : 200.0<br/>
					  },{<br/>
					    "signerEmail" : "signer3@domain.com",<br/>
					    "signerName" : "signer3",<br/>
					    "pageNumber" : 3,<br/>
					    "fieldType" : "image",<br/>
					    "fieldName" : "sign",<br/>
					    "fieldValue" : null,<br/>
					    "xPosition" : 100.0,<br/>
					    "yPosition" : 100.0,<br/>
					    "fieldHeight" : 55.0,<br/>
					    "fieldWidth" : 200.0<br/>
					  }   ]<br/>
					}<br/>
                     </p>
                     
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example response</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     
						{ <br/>
						   "documentName" : "test.pdf",<br/>
						   "envelopeId" : "0db4ed24-2aa4-4ae2-8845-b45b5c502470",<br/>
						   "viewDocumentUrl" : "<%=apiUrl %>viewReadOnlyDocument?envelopeid=a24ae92d-e887-4cfb-aa12-074741ff2fc8",<br/>
						   "message":"success"<br/>
						}
                     </p>
                  </div>
               </div>               
               <div class="mid-info">
                  <p>In this request you need to provide access_token that is oauth2 token generated by login method api parameter.</p>
               </div>
               




  
               
                <div class="post-user">
                  <p>CREATE SIGNATURE API</p>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Description</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>In this API client api can create signature of signers. in the request simply provide the name and signature of signer it will return with create signature url. Create signature url will open in the browser where signer can create his/her signature. If the signature already created or exist into system it will show signature into saved signature section. Signer can able to edit the signatue.</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example request</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p><%=serviceUrl %>/rest/api/createsignature/?access_token=572b7beb-3f83-49e1-984b-cc49dcc5e8ca </p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Authorization</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Basic</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Accept</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Content-Type</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Application/json</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>HTTP Method</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>Post</p>
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Parameters: BODY RAW </p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                    <p>
                     	<!-- Enveloped id of created document for example: ddb555cb-2aa2-4e97-a00c-3fbe7ba4bc52 -->
                     	
                     	{"firstname" : "signer_firstname", "lastname" : "signer_lastname","email" : "signer.email@domain.com" }
                     </p>
                     
                  </div>
               </div>
               <div class="row puser-info">
                  <div class="col-md-3 col-xs-12 color-info">
                     <p>Example response</p>
                  </div>
                  <div class="col-md-9 col-xs-12 D-info">
                     <p>
                     
						{<br/>
 						 "email" : "signer.email@domain.com",<br/>
						  "createSignatureUrl":"<%=apiUrl %>createsignature?token=4fc059e1-ad00-4cdd-8c5b-11e6e5f9bf99",<br/>
						  "message" : "success"<br/>
						}<br/>
                     </p>
                  </div>
               </div>               
               <div class="mid-info">
                  <p>In this request you need to provide access_token that is oauth2 token generated by login method api parameter.</p>
               </div>
               
               
               
               
              
            </div>
         </div>
      </div>

<jsp:include page="plan_footer.jsp" />