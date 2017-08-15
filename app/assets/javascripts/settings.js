
function parse_errors(data){
  clear_errors()
  for (var type in data){
    put_error_message(type, data[type]);
  }
}

function put_error_message(type, data){
  for (var key in data){
    var target = "#_" + type + "_" + key;
    $(target).parent().addClass('has-error');
    $(target).next().text(data[key]);
  }
}

function clear_errors(){
  $("div.form-group").removeClass("has-error");
  $("span.help-block").html("");
}

