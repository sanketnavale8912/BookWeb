<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<!-- /.content-wrapper --> 
  <!-- Main Footer -->
<footer class="main-footer"> 
    <!-- To the right -->
    <div class="social footer_div text-center hidden-xs">
      <ul class="footer_ul">
        <li style="padding-right:10px;"><span class="icon-language"></span> ENGLISH</li>
       <!--  <li><a href="#">Contact Us</a></li>
        <li><a href="#">Terms of Use</a></li>
        <li><a href="#">Privacy</a></li> -->
		<li> Copyright &copy; <script>document.write(new Date().getFullYear())</script>, Exela Technologies Inc., All Rights Reserved.</li>
      </ul>
    </div>
    <!-- Default to the left --> 
</footer>
</div>
<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
<!-- ./wrapper --> 
<!-- REQUIRED JS SCRIPTS --> 

<script src="<%=appUrl %>/js/jquery-3.1.1.min.js"></script> 
<script src="<%=appUrl %>/js/jquery-ui.js"></script> 
<script src="<%=appUrl %>/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.js"></script> 
<script src="<%=appUrl %>/js/app.min.js"></script> 
<script src="<%=appUrl %>/js/jquery.browser.js"></script>
<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script> 
<script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap4.min.js"></script> 
<script src="<%=appUrl %>/js/dataTables.responsive.js"></script> 
<script src="<%=appUrl %>/js/responsive.bootstrap.js"></script> 

<script>
$(document).ready(function() {
	
	 $(".Content-wh-module").css({ minHeight: $(window).innerHeight() - '170' });
	  $(window).resize(function() {
	    $(".Content-wh-module").css({ minHeight: $(window).innerHeight() - '170' });
	  });
	  
	 
	// store url for current page as global variable
	current_page = document.location.href
	//alert(current_page)
	// apply selected states depending on current page
 	if (current_page.match(/dashboard/)) {
 	$("ul#headernavigation li:eq(0)").addClass('active');
 	} else if (current_page.match(/document/) || current_page.match(/selfsign/) || current_page.match(/groupsign/)) {
 		$("ul#headernavigation li:eq(1)").addClass('active');
 	}else if (current_page.match(/outforSignature/) || current_page.match(/completedDocuments/) || current_page.match(/draft/))  {
 		$("ul#headernavigation li:eq(2)").addClass('active');
 		
 		if(current_page.match(/outforSignature/)){
 			$("ul#headersubnavigation li:eq(1)").addClass('active');
 		}else if(current_page.match(/completedDocuments/)){
 			$("ul#headersubnavigation li:eq(0)").addClass('active');
 		}else if(current_page.match(/draft/)){
 			$("ul#headersubnavigation li:eq(2)").addClass('active');
 		}
 		
 	}else { // don't mark any nav links as selected
 	$("ul#headernavigation li").removeClass('active');
 	};
});	


</script>
<script>	
$(window).on("load resize", function() {
    var viewportWidth = $(window).width();
    if (viewportWidth < 768) {
		//alert('hi')
		
          (function($) {
            $(document).ready(function() {
				//alert('hi');
              $( ".m-view" ).prependTo( ".dropdown-menu li.bottom" );
 $( ".m-view.user" ).prependTo( "#drpdwn" );  
            });
         }) (jQuery);
    }
});	

$('.logout').on('click', function () {
    $.confirm({
        title: 'Logout!',
        content: 'Are you sure you want to logout?',
       		 buttons: {
        	  
        	/* confirm: function () {
        	 btnClass: 'btn-red'
          	  window.location = $("#contextPath").val()+"logout";
            }, */
            somethingElse: {
                text: 'CONFIRM',
                btnClass: 'btn-green',
               
                action: function(){
                	 window.location = $("#contextPath").val()+"logout";
                }
            },
            cancel: {
		        btnClass: 'btn-red'
            },
        }
    });
});
</script>
</body>
</html>