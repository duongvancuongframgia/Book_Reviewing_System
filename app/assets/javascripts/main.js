$(document).ready(function()
{
  /* smooth scrolling for scroll to top */
	$('#to-top').bind('click', function()
	{
		$('body,html').animate({scrollTop: 0}, 2500);
	});
});
// $(document).ready(function(){
//   $(".dropdown").hover(            
//     function() {
//       $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true,true).slideDown("400");
//       $(this).toggleClass('open');        
//     },
//     function() {
//       $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true,true).slideUp("400");
//       $(this).toggleClass('open');       
//     }
//   );
// });