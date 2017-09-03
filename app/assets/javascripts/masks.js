$(function($){
  $("#credit_card_mm_yy").mask("99/99",{placeholder:"MM/YY"});
  $("#credit_card_cvv").mask("9999");
  $("#_billing_zip").mask("0009999999");
  $("#_shipping_zip").mask("0009999999");
  $("#_billing_phone").mask("+00 (000) 000-999999");
  $("#_shipping_phone").mask("+00 (000) 000-999999");
  $("#credit_card_number").mask("0000  0000  0000  0000", {placeholder: "* * * *\t* * * *\t* * * *\t* * * *"});
});

