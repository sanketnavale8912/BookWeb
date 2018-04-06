<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>



<link rel="stylesheet" href="<%=appUrl %>/css/fonts_icon.css" type="text/css">
<!--/.Footer -->

	<div class="footer">
		
		<div class="row">
			<div class="col-xs-12 text-center">
				<!-- &copy Copyright 2017 Exela Technologies Inc., All Rights Reserved. -->
			<span class="icon-language"></span> ENGLISH | Copyright &copy; <script>document.write(new Date().getFullYear())</script>, Exela Technologies Inc., All Rights Reserved.
			</div>
		</div>
	</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 


<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=appUrl %>/js/bootstrap.js"></script>
	<script src="<%=appUrl %>/js/responsive-tabs.js"></script>
	<script src="<%=appUrl %>/js/jquery.flexisel.js"></script>
	<%-- <script src="<%=appUrl %>/js/materialize.js"></script> --%>
	 <script src="<%=appUrl %>/js/jquery.buttonLoader.js"></script>
	
<script type="text/javascript">
	
	$(window).on("load", function() {
    var viewportWidth = $(window).width();
    if (viewportWidth < 768) {
		//alert('hi');
          (function($) {
            $(document).ready(function() {
               $(".flexiselDemo3").flexisel({
		
        visibleItems: 1,
        itemsToScroll: 0,         
       autoPlay: {
           enable: true,
            interval: 5000,
            pauseOnHover: true
        }        
    });
            });
         }) (jQuery);
    }
});
	

	
  (function($) {
      fakewaffle.responsiveTabs(['xs', 'sm']);
	  $('#myTab a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
});
  })(jQuery);
	
  

 
  $(document).ready(function() {
  	// store url for current page as global variable
  	current_page = document.location.href
  	//alert(current_page)
  	// apply selected states depending on current page
   	if (current_page.match(/pricing/) || current_page.match(/plans/)  || current_page.match(/checkout/)) 
   	{
   	$("ul#headernavigation li:eq(2)").addClass('active');
   	
   	}else if(current_page.match(/api/)) {
   		$("ul#headernavigation li:eq(3)").addClass('active');
   	}
  });	


</script>
</body>
</html>