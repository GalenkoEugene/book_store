$(document).ready(function() {
  $(".clickable-step").click(function() {
    window.location = $(this).data("href");
  });

  $(".clickable-step").css( 'cursor', 'pointer' );
});
