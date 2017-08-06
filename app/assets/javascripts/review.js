$(document).ready(function() {
  $('form#post_review').submit(function() {
    // $('div.general-message-wrap.divider.form').fadeOut('slow');
    setTimeout(function(){
      $('form#post_review')[0].reset();
    }, 200);
  });
});
