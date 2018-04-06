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
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>filepicker widget</title>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600' rel='stylesheet' type='text/css'>
    <script src="<%=appUrl %>/egnyte/dist/egnyte.js"></script>
    <script src="<%=appUrl %>/egnyte/spec/conf/apiaccess.js"></script>
    <script src="<%=appUrl %>/js/jquery.min.js"></script>
</head>

<body>
    
    <div id="there">


    </div>
    <div id="andback">


    </div>
    <div id="loading" style="display:none;'">Loading</div>
    
<!-- <a href="http://kanishkkunal.in"  target="popup"   onclick="window.open('http://kanishkkunal.in','popup','width=300,height=300'); return false;">
    Open Link in Popup
</a> -->
   
    <script>
    
    $(document).ready(function(){
    	openPicker()
    });
    	var base64;
    	var fileName;
        var node = document.getElementById("there");
        var node2 = document.getElementById("andback");

        eg = Egnyte.init(egnyteDomain, {
            token: APIToken
        });

        function openPicker() {

            eg.filePicker(node, {
                selection: function (list) {
                    workWithImage(list[0]);
                },
                cancel: function () {
                    console.warn("cancelled");
                },
                select: {
                    folder: false,
                    file: true,
                    multiple: false
                },
                filterExtensions: function(ext3chars, mime){
                	   return ext3chars==="pdf"; //show only htm* files
                	}
            });

        }


        function workWithImage(fileData) {
            node2.innerHTML = '';
            //create a link for anybody to access the file
            eg.API.link.createLink({
                path: fileData.path,
                type: "file",
                accessibility: "password"
            }).then(function (newLink) {
            	$("#loading").show();
                //var linkBox = document.createElement("div");
               // linkBox.innerHTML += ' Share: <a href="' + newLink.links[0].url + '">' + newLink.links[0].url + '</a>' + '<p>password: ' + newLink.password + '</p>';
               // node2.appendChild(linkBox);
            });

            // download and use the file
            // in modern browsers you can even work with binary data
         
            eg.API.storage.fileId(fileData.group_id).download(fileData.entry_id,true).then(function (xhr) {			
                var arrayBuffer = xhr.body; // Note: not oReq.responseText
                var binaryString = '';
                if (arrayBuffer) {
                    var byteArray = new Uint8Array(arrayBuffer);
                    for (var i = 0; i < byteArray.byteLength; i++) {
                        binaryString += String.fromCharCode(byteArray[i]); //extracting the bytes
                    }
                    base64 = window.btoa(binaryString); //creating base64 string
				    fileName = fileData.name;
					CloseMySelf();
                    img.src = "data:image/png;base64," + base64; //creating a base64 uri
                    console.log("test-->"+img.src);
                    node2.appendChild(img);

                }
            });
        }
        
        function CloseMySelf() {
            try {
                //window.opener.HandlePopupResult(sender.getAttribute("result"));
              window.opener.HandlePopupResult(base64,fileName);
              $("#loading").hide();
            }
            catch (err) {}
            window.close();
            return false;
        }
    </script>
</body>



</html>
