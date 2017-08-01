$(document).ready(function() {
    var showChar = 300;  // How many characters are shown
    
    $('p.lead.small.line-height-2').each(function() {
        var content = $(this).html();
        if(content.length > showChar) {
            var c = content.substr(0, showChar);
            var h = content.substr(showChar, content.length - showChar);
            var html = c + '<span>... </span><span class="more_content"><span>' + h + '</span>  <a class="in-gold-500 ml-10" href="#">Read More</a></span>';
            $(this).html(html);
        }
    });
 
    $(".in-gold-500.ml-10").click(function(){
        $(this).toggle();
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });


    var quantity = $('input.form-control.quantity-input') // Input fields for amount of books
    var amount = parseInt(quantity.val());
    $('div.input-group.general-position i.fa.fa-minus.line-height-40').click(function(){
        if (amount > 1) {
            amount -= 1
            quantity.val(amount);
        } 
    });

    $('div.input-group.general-position i.fa.fa-plus.line-height-40').click(function(){
        amount += 1
        quantity.val(amount);
    });

});