let ValidationConfig= {
  init(){
    Parsley.options.trigger = "focusout";
    Parsley.options.errorsContainer = function(ParsleyField){
      var $err = ParsleyField.$element.closest(".error-con");
      return $err;
    }
    $('select').on('select2:select', function(evt) {
      $(this).parsley().validate();
  });
  }
}

export default ValidationConfig